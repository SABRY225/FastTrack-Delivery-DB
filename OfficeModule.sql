--==============Case 1: Create Order :: Stored Procedure=========================
CREATE OR ALTER PROCEDURE sp_CreateOrder
    @order_number INT,
    @order_date DATE,
    @cust_id INT,
    @driver_id INT,
    @office_id INT,
    @order_status VARCHAR(20)
WITH ENCRYPTION
AS
BEGIN
    INSERT INTO Orders (
        order_number,
        order_date,
        total_cost,
        cust_id,
        driver_id,
        office_id,
        order_status
    )
    VALUES (
        @order_number,
        @order_date,
        0,
        @cust_id,
        @driver_id,
        @office_id,
        @order_status
    );
END;

--==============Case 2: Add Delivery Item to Order :: Stored Procedure=========================
CREATE OR ALTER PROCEDURE sp_AddDeliveryItem
    @item_id INT,
    @description VARCHAR(200),
    @item_weight DECIMAL(10,2),
    @delivery_fee DECIMAL(10,2),
    @order_number INT
WITH ENCRYPTION
AS
BEGIN
    INSERT INTO deliveryItem (
        item_id,
        description,
        item_weight,
        delivery_fee,
        order_number
    )
    VALUES (
        @item_id,
        @description,
        @item_weight,
        @delivery_fee,
        @order_number
    );
END;

--==============Case 3: Calculate Order Total :: Function=========================
CREATE OR ALTER FUNCTION fn_CalculateOrderTotal (@order_number INT)
RETURNS DECIMAL(10,2)
WITH ENCRYPTION
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SELECT @total = SUM(delivery_fee)
    FROM deliveryItem
    WHERE order_number = @order_number;

    RETURN ISNULL(@total, 0);
END;


--==============Case 4: Auto Update Order Total :: Trigger=========================
CREATE OR ALTER TRIGGER trg_UpdateOrderTotal
ON deliveryItem
AFTER INSERT
AS
BEGIN
    UPDATE Orders
    SET total_cost = dbo.fn_CalculateOrderTotal(Orders.order_number)
    FROM Orders
    JOIN inserted i
        ON Orders.order_number = i.order_number;
END;

--==============Case 5: View Order Details :: View=========================
CREATE OR ALTER VIEW vw_OrderDetails
WITH ENCRYPTION
AS
SELECT
    o.order_number,
    o.order_date,
    o.order_status,
    o.total_cost,

    c.name  customer_name,
    d.driver_id,
    ofc.name  office_name,

    o.pay_date,
    o.pay_method,
    o.amount
FROM Orders o
JOIN customer c ON o.cust_id = c.cust_id
JOIN delivery d ON o.driver_id = d.driver_id
JOIN office ofc ON o.office_id = ofc.office_id;

--==============Case 6: Office Summary Report :: View=========================
CREATE OR ALTER VIEW vw_OfficeSummary
WITH ENCRYPTION
AS
SELECT
    ofc.office_id,
    ofc.name AS office_name,

    COUNT(DISTINCT e.emp_id) AS employee_count,
    COUNT(DISTINCT o.order_number) AS order_count,
    SUM(o.total_cost) AS total_revenue
FROM office ofc
LEFT JOIN employee e ON ofc.office_id = e.office_id
LEFT JOIN Orders o ON ofc.office_id = o.office_id
GROUP BY ofc.office_id, ofc.name;
--==============Case 7: Prevent Office Deletion :: TRIGGER=========================
CREATE OR ALTER TRIGGER trg_PreventOfficeDelete
ON office
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM employee e
        JOIN deleted d ON e.office_id = d.office_id
    )
    BEGIN
        PRINT'Cannot delete office that has employees.'
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM office
        WHERE office_id IN (SELECT office_id FROM deleted);
    END
END;

--==============Case 8: Improve Office Orders Search :: Index=========================
CREATE INDEX idx_Orders_OfficeId
ON Orders (office_id);

--==============Case 9: PayOrder :: PROCEDURE=========================
CREATE OR ALTER PROCEDURE sp_PayOrder
    @order_number INT,
    @pay_method VARCHAR(20)
WITH ENCRYPTION
AS
BEGIN
    UPDATE Orders
    SET 
        amount = total_cost,
        pay_method = @pay_method,
        pay_date = GETDATE(),
        order_status = 'paid'
    WHERE order_number = @order_number;
END;
--==============Case 10: Validate Payment :: TRIGGER=========================
CREATE OR ALTER TRIGGER trg_ValidatePayment
ON Orders
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.order_status = 'paid'
          AND i.amount IS NULL
    )
    BEGIN
        PRINT 'Paid orders must have a payment amount.'
        ROLLBACK;
    END
END;

--==============Case 11: Prevent Paid Order Update :: TRIGGER=========================
CREATE OR ALTER TRIGGER trg_PreventPaidOrderUpdate
ON Orders
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.order_number = d.order_number
        WHERE i.order_status = 'paid'
          AND (i.total_cost <> d.total_cost OR i.amount <> d.amount)
    )
    BEGIN
        PRINT 'Cannot change total_cost or amount for orders that are already paid.'
        ROLLBACK;
    END
END;


--==============Case 12: Prevent Any Order Delete :: TRIGGER=========================

CREATE TRIGGER trg_PreventAnyOrderDelete
ON Orders
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Deleting orders is not allowed! All orders are preserved for reporting.';
    ROLLBACK TRANSACTION;
END;


--==============Case 13: Assign Order To Delivery :: PROCEDURE=========================
CREATE or alter PROCEDURE sp_AssignOrderToDelivery
    @order_number INT
AS
BEGIN
    DECLARE @driver_id INT;
    DECLARE @plate_number VARCHAR(10);

    SELECT TOP 1 
        @driver_id = e.emp_id, 
        @plate_number = va.plate_number
    FROM employee e
    JOIN VehicleAssignment va ON e.emp_id = va.driver_id
    WHERE va.endDate IS NULL 
    ORDER BY e.emp_id;

    IF @driver_id IS NOT NULL AND @plate_number IS NOT NULL
    BEGIN
        UPDATE Orders
        SET driver_id = @driver_id
        WHERE order_number = @order_number;

        UPDATE VehicleAssignment
        SET startDate = GETDATE()
        WHERE driver_id = @driver_id AND plate_number = @plate_number;

        PRINT 'Order assigned successfully!';
    END
    ELSE
    BEGIN
        PRINT 'No available driver or vehicle to assign!';
    END
END;


--===========================
CREATE TRIGGER trg_prevent_cancel_paid_order
ON Orders
INSTEAD OF UPDATE
AS
BEGIN

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Orders o ON i.order_number = o.order_number
        WHERE 
            i.order_status = 'cancelled'
            AND (
                    o.order_status = 'paid'
                    OR o.amount IS NOT NULL
                )
    )
    BEGIN
        RAISERROR ('Cannot cancel a paid order.', 16, 1);
        RETURN;
    END

    UPDATE Orders
    SET 
        order_date = i.order_date,
        total_cost = i.total_cost,
        cust_id = i.cust_id,
        driver_id = i.driver_id,
        office_id = i.office_id,
        pay_date = i.pay_date,
        pay_method = i.pay_method,
        amount = i.amount,
        order_status = i.order_status
    FROM Orders o
    JOIN inserted i ON o.order_number = i.order_number;

END;