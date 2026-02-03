--- Create Table DB

CREATE TABLE customer (
    cust_id     INT IDENTITY(1,1),
    name        VARCHAR(100) NOT NULL,
    street      VARCHAR(150) NOT NULL,
    city        VARCHAR(100) NOT NULL,

    CONSTRAINT PK_customer 
        PRIMARY KEY (cust_id)
);

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
