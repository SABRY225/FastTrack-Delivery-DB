  --- Create Table DB

--=============CREATE TABLE office================
CREATE TABLE office (
    office_id INT IDENTITY(1,1),
    name      VARCHAR(100) NOT NULL,
    city      VARCHAR(100) NOT NULL,
    street    VARCHAR(150) NOT NULL,

    CONSTRAINT PK_office
        PRIMARY KEY (office_id)
);

--=============CREATE TABLE office_phones================
CREATE TABLE office_phones (
    office_id    INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,

    CONSTRAINT PK_office_phones
        PRIMARY KEY (office_id, phone_number),

    CONSTRAINT FK_office_phones_office
        FOREIGN KEY (office_id)
        REFERENCES office(office_id)
        ON DELETE CASCADE
);

--=============CREATE TABLE employee================

CREATE TABLE employee (
    emp_id     INT IDENTITY(1,1),
    name       VARCHAR(100) NOT NULL,
    job_title  VARCHAR(100) NOT NULL,
    hire_date  DATE NOT NULL,
    salary     DECIMAL(10,2) NOT NULL,
    office_id  INT NOT NULL,

    CONSTRAINT PK_employee
        PRIMARY KEY (emp_id),

    CONSTRAINT FK_employee_office
        FOREIGN KEY (office_id)
        REFERENCES office(office_id)
        ON DELETE NO ACTION
);

--=============CREATE TABLE Emp_phones================

CREATE TABLE emp_phones (
    emp_id       INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,

    CONSTRAINT PK_emp_phones
        PRIMARY KEY (emp_id, phone_number),

    CONSTRAINT FK_emp_phones_employee
        FOREIGN KEY (emp_id)
        REFERENCES employee(emp_id)
        ON DELETE CASCADE
);

--=============CREATE TABLE Delivery================

CREATE TABLE delivery (
    driver_id      INT IDENTITY(1,1),
    license_number VARCHAR(50) NOT NULL,
    emp_id         INT NOT NULL,

    CONSTRAINT PK_delivery
        PRIMARY KEY (driver_id),

    CONSTRAINT UQ_delivery_license
        UNIQUE (license_number),

    CONSTRAINT FK_delivery_employee
        FOREIGN KEY (emp_id)
        REFERENCES employee(emp_id)
        ON DELETE CASCADE
);

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



--=============CREATE TABLE Delivery Item================
create table deliveryItem(
item_id int,
description varchar(200),
item_weight decimal(10,2) not null,
delivery_fee decimal(10,2),
order_number int not null,
primary key (item_id,order_number),
foreign key (order_number) REFERENCES Orders(order_number),

CONSTRAINT chk_item_weight CHECK (item_weight >= 0),
CONSTRAINT chk_delivery_fee CHECK (delivery_fee >= 0)
)


--=============CREATE TABLE Vehicle Assignment================
create table VehicleAssignment(
vehicle_ass_ID int primary key identity(1,1),
driver_id int not null,
plate_number varchar(20) not null,
startDate datetime ,
endDate datetime,
foreign key (driver_id) REFERENCES delivery(driver_id),
foreign key (plate_number) REFERENCES Vehicle(plate_number),

CONSTRAINT chk_dates CHECK (endDate >= startDate),
CONSTRAINT uq_driver_start UNIQUE (driver_id, startDate),
CONSTRAINT uq_plate_num UNIQUE (plate_number, startDate)
)