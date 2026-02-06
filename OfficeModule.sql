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
        RAISERROR ('Cannot delete office that has employees.', 16, 1);
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
        RAISERROR ('Paid orders must have a payment amount.', 16, 1);
        ROLLBACK;
    END
END;
