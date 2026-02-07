--=============================== Customer Use Cases Test ================================

SELECT * FROM customer;
SELECT * FROM cust_phones;
SELECT * FROM Orders;

--========1. Register Customer========
EXEC sp_AddCustomer 
    @name = 'Shimaa',
    @phone_number = '01211111111',
    @street = 'Konouz',
    @city = 'Qena';

--======== Duplicate Phone Test ========
EXEC sp_AddCustomer 
    @name = 'Mohammed',
    @phone_number = '01211111111',   -- ‰›” «·—ﬁ„
    @street = 'October',
    @city = 'Cairo';

--======== New Valid Customer ========
EXEC sp_AddCustomer 
    @name = 'Ali',
    @phone_number = '01022222222',
    @street = 'October',
    @city = 'Cairo';

--========Update Customer Address========
EXEC sp_UpdateCustomerAddress 
    @cust_id = 1,
    @street = 'Zamalek',
    @city = 'Cairo';

SELECT * 
FROM customer 
WHERE cust_id = 1;

--======== View Customers========
SELECT * FROM customer;
SELECT * FROM cust_phones;


--========2. Customer Profile View========
SELECT * 
FROM vw_CustomerProfile;


--========3. Get Customer Orders========
EXEC sp_GetCustomerOrders @cust_id = 1;


--========4. Customer Financial Analytics Dashboard========
SELECT * 
FROM fn_CustomerFinancialAnalytics(1);


--======== Customer Classification (VIP / Normal)   (office)========
SELECT * 
FROM vw_CustomerCategory;





--========5. Prevent Delete Customer With Orders========
DELETE FROM customer 
WHERE cust_id = 1;   


--========6. Delete Customer Without Orders========
DELETE FROM customer 
WHERE cust_id = 999;  


--========10. Data Validation========
SELECT * FROM customer;
SELECT * FROM cust_phones;
SELECT * FROM Orders;
