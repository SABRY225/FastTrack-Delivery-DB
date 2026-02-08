--1 create new driver
CREATE PROCEDURE sp_RegisterDriver
    @emp_name VARCHAR(100),
    @job_title VARCHAR(100),
    @hire_date DATE,
    @salary DECIMAL(10,2),
    @office_id INT,
    @license_number VARCHAR(50)
AS
BEGIN
    INSERT INTO employee (name, job_title, hire_date, salary, office_id)
    VALUES (@emp_name, @job_title, @hire_date, @salary, @office_id);

    DECLARE @emp_id INT = SCOPE_IDENTITY();

    INSERT INTO delivery (license_number, emp_id)
    VALUES (@license_number, @emp_id);
END;

--2 triger to duplicate delivery number
CREATE TRIGGER trg_PreventDuplicateDriverPhone
ON emp_phones
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM emp_phones ep
        JOIN inserted i
        ON ep.phone_number = i.phone_number
    )
    BEGIN
        RAISERROR('رقم الموبايل مستخدم من قبل',16,1);
        RETURN;
    END

    INSERT INTO emp_phones (emp_id, phone_number)
    SELECT emp_id, phone_number FROM inserted;
END;

--3 view to get delevery detalis
CREATE VIEW vw_DriverProfile
AS
SELECT 
    d.driver_id,
    e.name,
    e.job_title,
    e.salary,
    COUNT(o.order_number) AS total_orders,
    va.plate_number
FROM delivery d
JOIN employee e ON d.emp_id = e.emp_id
LEFT JOIN Orders o ON d.driver_id = o.driver_id
LEFT JOIN VehicleAssignment va 
    ON d.driver_id = va.driver_id AND va.endDate IS NULL
GROUP BY d.driver_id, e.name, e.job_title, e.salary, va.plate_number;

--4 show delevery orders
CREATE PROCEDURE sp_GetDriverOrders
    @driver_id INT
AS
BEGIN
    SELECT 
        o.order_number,
        o.order_date,
        o.total_cost,
        o.order_status
    FROM Orders o
    WHERE o.driver_id = @driver_id
    ORDER BY o.order_date DESC;
END;

--6 get delevery total earns
CREATE or alter FUNCTION fn_TotalDriverEarnings (@driver_id INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SELECT @total = SUM(amount)
    FROM Orders
    WHERE driver_id = @driver_id
      AND order_status in('paid','delivered');

    RETURN ISNULL(@total, 0);
END;

--7 get driver classification
CREATE VIEW vw_DriverClassification
AS
SELECT 
    d.driver_id,
    e.name,
    dbo.fn_TotalDriverEarnings(d.driver_id) AS total_earnings,
    CASE 
        WHEN dbo.fn_TotalDriverEarnings(d.driver_id) >= 10000 
        THEN 'VIP'
        ELSE 'Normal'
    END AS driver_level
FROM delivery d
JOIN employee e ON d.emp_id = e.emp_id;

--- AssignVehicleToDeliveryMan
CREATE PROCEDURE AssignVehicleToDeliveryMan
    @delivery_man_id INT,
    @plate_number INT,
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    -- التحقق من صحة التواريخ
    IF @start_date >= @end_date
    BEGIN
        RAISERROR('Start date must be before end date', 16, 1);
        RETURN;
    END

    -- التحقق من عدم وجود تعارض
    IF EXISTS (
        SELECT 1
        FROM VehicleAssignment
        WHERE plate_number = @plate_number
        AND (
            @start_date BETWEEN startDate AND endDate
            OR
            @end_date BETWEEN startDate AND endDate
        )
    )
    BEGIN
        RAISERROR('Vehicle already assigned in this period', 16, 1);
        RETURN;
    END

    INSERT INTO VehicleAssignment
    (driver_id, plate_number, startDate, endDate)
    VALUES
    (@delivery_man_id,@plate_number, @start_date, @end_date);
END;
---
CREATE TRIGGER trg_PreventVehicleConflict
ON VehicleAssignment
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM VehicleAssignment d
        JOIN inserted i
        ON d.plate_number = i.plate_number
        AND (
            i.startDate BETWEEN d.startDate AND d.endDate
            OR
            i.endDate BETWEEN d.startDate AND d.endDate
        )
    )
    BEGIN
        RAISERROR('Vehicle already assigned during this period',16,1);
        ROLLBACK;
        RETURN;
    END


    INSERT INTO VehicleAssignment
        (driver_id, plate_number, startDate, endDate)
    SELECT
        driver_id,
        plate_number,
        startDate,
        endDate
        from inserted
END;
---
CREATE PROCEDURE MarkOrderAsDelivered
    @order_id INT
AS
BEGIN
    UPDATE orders
    SET 
        order_status = 'delivered'
        --,delivered_at = GETDATE()
    WHERE order_number = @order_id;
END;
---
CREATE TRIGGER trg_PreventDeleteDeliveryMan
ON delivery
AFTER DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM orders o
        JOIN deleted d
        ON o.delivery_man_id = d.id
    )
    BEGIN
        RAISERROR('Cannot delete delivery man with existing orders',16,1);
        ROLLBACK TRANSACTION;
    END
END;
---
CREATE OR ALTER PROCEDURE GetCustomerProfile
    @cust_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.cust_id,
        c.name,
        c.city,
        d.license_number,
        cp.phone_number
    FROM customer c , delivery d , cust_phones cp
    WHERE c.cust_id = @cust_id and  cp.cust_id = @cust_id and d.emp_id = @cust_id ; 
END;


CREATE TRIGGER trg_prevent_delete_driver_with_orders
ON delivery
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM Orders o
        JOIN deleted d
            ON o.driver_id = d.driver_id
    )
    BEGIN
        RAISERROR ('Cannot delete driver because he has orders.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;



CREATE PROCEDURE GetDeliveryReport
    @driver_id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        d.driver_id,
        e.name,
        d.license_number,

        COUNT(o.order_number) AS total_orders,

        SUM(CASE WHEN o.order_status = 'delivered' THEN 1 ELSE 0 END) 
            AS delivered_orders,

        SUM(CASE WHEN o.order_status = 'cancelled' THEN 1 ELSE 0 END) 
            AS cancelled_orders,

        SUM(o.total_cost) AS total_orders_value

    FROM delivery d
    JOIN employee e ON d.emp_id = e.emp_id
    LEFT JOIN Orders o ON d.driver_id = o.driver_id

    WHERE d.driver_id = @driver_id

    GROUP BY 
        d.driver_id,
        e.name,
        d.license_number;
END;
GO