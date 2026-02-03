--- Create Table DB

--=============CREATE TABLE customer================

CREATE TABLE customer (
    cust_id     INT IDENTITY(1,1),
    name        VARCHAR(100) NOT NULL,
    street      VARCHAR(150) NOT NULL,
    city        VARCHAR(100) NOT NULL,

    CONSTRAINT PK_customer 
        PRIMARY KEY (cust_id)
);

--=============CREATE TABLE cust_phones================

CREATE TABLE cust_phones (
    cust_id      INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,

    CONSTRAINT PK_cust_phones 
        PRIMARY KEY (cust_id, phone_number),

    CONSTRAINT FK_cust_phones_customer
        FOREIGN KEY (cust_id)
        REFERENCES customer(cust_id)
        ON DELETE CASCADE
);

--=============CREATE TABLE vehicle================

CREATE TABLE Vehicle (
    plate_number VARCHAR(20) NOT NULL,
    model VARCHAR(50) NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    capacity INT NOT NULL,

    CONSTRAINT pk_vehicle PRIMARY KEY (plate_number),

    CONSTRAINT chk_vehicle_type 
        CHECK (vehicle_type IN ('car', 'bus', 'truck', 'motorcycle')),

    CONSTRAINT chk_vehicle_capacity 
        CHECK (capacity > 0)
)



--=============CREATE TABLE orders================


CREATE TABLE Orders (
    order_number INT NOT NULL,
    order_date DATE NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,

    cust_id INT NOT NULL,
    driver_id INT NOT NULL,
    office_id INT NOT NULL,

    pay_date DATE,
    pay_method VARCHAR(20),
    amount DECIMAL(10,2),

    order_status VARCHAR(20) NOT NULL,

    CONSTRAINT pk_orders PRIMARY KEY (order_number),

    CONSTRAINT chk_total_cost 
        CHECK (total_cost > 0),

    CONSTRAINT chk_amount 
        CHECK (amount IS NULL OR amount > 0),

    CONSTRAINT chk_pay_method 
        CHECK (pay_method IN ('cash', 'card', 'online')),

    CONSTRAINT chk_order_status 
        CHECK (order_status IN ('pending', 'paid', 'cancelled', 'delivered')),

    CONSTRAINT fk_orders_customer 
        FOREIGN KEY (cust_id) REFERENCES customer(cust_id),

    CONSTRAINT fk_orders_driver 
        FOREIGN KEY (driver_id) REFERENCES driver(driver_id),

    CONSTRAINT fk_orders_office 
        FOREIGN KEY (office_id) REFERENCES office(office_id)
);
