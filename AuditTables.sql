--===============================Audit Tables================================

--=============================== office ================================
--============ office_history ===============

CREATE TABLE office_history (
    office_id INT,
    name      VARCHAR(100),
    city      VARCHAR(100),
    street    VARCHAR(150),

    action_type VARCHAR(10),   
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)

--============ trg_office_history ===============

CREATE TRIGGER trg_office_history
ON office
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO office_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE office_id NOT IN (SELECT office_id FROM deleted);

    -- UPDATE
    INSERT INTO office_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE office_id IN (SELECT office_id FROM deleted);

    -- DELETE
    INSERT INTO office_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END


--=============================== employee ================================
--============ employee_history ===============

CREATE TABLE employee_history (
    emp_id     INT,
    name       VARCHAR(100),
    job_title  VARCHAR(100),
    hire_date  DATE,
    salary     DECIMAL(10,2),
    office_id  INT,

    action_type VARCHAR(10),   
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)

--============ trg_employee_history ===============
CREATE TRIGGER trg_employee_history
ON employee
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO employee_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE emp_id NOT IN (SELECT emp_id FROM deleted);

    -- UPDATE
    INSERT INTO employee_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE emp_id IN (SELECT emp_id FROM deleted);

    -- DELETE
    INSERT INTO employee_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END

--=============================== office_phones ================================
--============ office_phones_history ===============
CREATE TABLE office_phones_history (
    office_id    INT,
    phone_number VARCHAR(20),

    action_type VARCHAR(10),   
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)
--============ trg_office_phones_history ===============
CREATE TRIGGER trg_office_phones_history
ON office_phones
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO office_phones_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE office_id + phone_number NOT IN 
          (SELECT office_id + phone_number FROM deleted);

    -- UPDATE
    INSERT INTO office_phones_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE office_id + phone_number IN 
          (SELECT office_id + phone_number FROM deleted);

    -- DELETE
    INSERT INTO office_phones_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END

--=============================== emp_phones ================================
--============ emp_phones_history ===============
CREATE TABLE emp_phones_history (
    emp_id       INT,
    phone_number VARCHAR(20),

    action_type VARCHAR(10), 
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)


--============ trg_emp_phones_history ===============
CREATE TRIGGER trg_emp_phones_history
ON emp_phones
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO emp_phones_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE emp_id + phone_number NOT IN 
          (SELECT emp_id + phone_number FROM deleted);

    -- UPDATE
    INSERT INTO emp_phones_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE emp_id + phone_number IN 
          (SELECT emp_id + phone_number FROM deleted);

    -- DELETE
    INSERT INTO emp_phones_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END
--=============================== customer ================================
--============ customer_history ===============
CREATE TABLE customer_history (
    cust_id INT,
    name    VARCHAR(100),
    street  VARCHAR(150),
    city    VARCHAR(100),

    action_type VARCHAR(10),   
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)
--============ trg_customer_history ===============
CREATE TRIGGER trg_customer_history
ON customer
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO customer_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE cust_id NOT IN (SELECT cust_id FROM deleted);

    -- UPDATE
    INSERT INTO customer_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE cust_id IN (SELECT cust_id FROM deleted);

    -- DELETE
    INSERT INTO customer_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END

--=============================== cust_phones ================================
--============ cust_phones_history ===============

CREATE TABLE cust_phones_history (
    cust_id      INT,
    phone_number VARCHAR(20),

    action_type VARCHAR(10),   
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)
--============ trg_cust_phones_history ===============

CREATE TRIGGER trg_cust_phones_history
ON cust_phones
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO cust_phones_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE cust_id + phone_number NOT IN 
          (SELECT cust_id + phone_number FROM deleted);

    -- UPDATE
    INSERT INTO cust_phones_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE cust_id + phone_number IN 
          (SELECT cust_id + phone_number FROM deleted);

    -- DELETE
    INSERT INTO cust_phones_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END

--=============================== delivery ================================
--============ delivery_history ===============
CREATE TABLE delivery_history (
    driver_id      INT,
    license_number VARCHAR(50),
    emp_id         INT,

    action_type VARCHAR(10),  
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)
--============ trg_delivery_history ===============
CREATE TRIGGER trg_delivery_history
ON delivery
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO delivery_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE driver_id NOT IN (SELECT driver_id FROM deleted);

    -- UPDATE
    INSERT INTO delivery_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE driver_id IN (SELECT driver_id FROM deleted);

    -- DELETE
    INSERT INTO delivery_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END
--=============================== vehicle ================================
--============ vehicle_history ===============


CREATE TABLE vehicle_history (
    plate_number  VARCHAR(20),
    model         VARCHAR(50),
    vehicle_type  VARCHAR(20),
    capacity      INT,

    action_type VARCHAR(10),  
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)

--============ trg_vehicle_history ===============
CREATE TRIGGER trg_vehicle_history
ON vehicle
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO vehicle_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE plate_number NOT IN (SELECT plate_number FROM deleted);

    -- UPDATE
    INSERT INTO vehicle_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE plate_number IN (SELECT plate_number FROM deleted);

    -- DELETE
    INSERT INTO vehicle_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END

--=============================== orders ================================
--============ orders_history ===============
CREATE TABLE orders_history (
    order_number INT,
    order_date   DATE,
    total_cost   DECIMAL(10,2),

    cust_id      INT,
    driver_id    INT,
    office_id    INT,

    pay_date     DATE,
    pay_method   VARCHAR(20),
    amount       DECIMAL(10,2),
    order_status VARCHAR(20),

    action_type VARCHAR(10),  
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)

--============ trg_orders_history ===============
CREATE TRIGGER trg_orders_history
ON Orders
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO orders_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE order_number NOT IN (SELECT order_number FROM deleted);

    -- UPDATE
    INSERT INTO orders_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE order_number IN (SELECT order_number FROM deleted);

    -- DELETE
    INSERT INTO orders_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END

--=============================== deliveryItem ================================
--============ deliveryItem_history ===============
CREATE TABLE deliveryItem_history (
    item_id        INT,
    description    VARCHAR(200),
    item_weight    DECIMAL(10,2),
    delivery_fee   DECIMAL(10,2),
    order_number   INT,

    action_type VARCHAR(10),  
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)


--============ trg_deliveryItem_history ===============
CREATE TRIGGER trg_deliveryItem_history
ON deliveryItem
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO deliveryItem_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE item_id + order_number NOT IN 
          (SELECT item_id + order_number FROM deleted);

    -- UPDATE
    INSERT INTO deliveryItem_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE item_id + order_number IN 
          (SELECT item_id + order_number FROM deleted);

    -- DELETE
    INSERT INTO deliveryItem_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END

--=============================== VehicleAssignment ================================
--============ VehicleAssignment_history ===============
CREATE TABLE VehicleAssignment_history (
    vehicle_ass_ID INT,
    driver_id      INT,
    plate_number   VARCHAR(20),
    startDate      DATETIME,
    endDate        DATETIME,

    action_type VARCHAR(10),  
    action_date DATETIME DEFAULT GETDATE(),
    action_user VARCHAR(100) DEFAULT SYSTEM_USER
)
--============ trg_VehicleAssignment_history ===============
CREATE TRIGGER trg_VehicleAssignment_history
ON VehicleAssignment
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- INSERT
    INSERT INTO VehicleAssignment_history
    SELECT *, 'INSERT', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE vehicle_ass_ID NOT IN (SELECT vehicle_ass_ID FROM deleted);

    -- UPDATE
    INSERT INTO VehicleAssignment_history
    SELECT *, 'UPDATE', GETDATE(), SYSTEM_USER
    FROM inserted
    WHERE vehicle_ass_ID IN (SELECT vehicle_ass_ID FROM deleted);

    -- DELETE
    INSERT INTO VehicleAssignment_history
    SELECT *, 'DELETE', GETDATE(), SYSTEM_USER
    FROM deleted;
END