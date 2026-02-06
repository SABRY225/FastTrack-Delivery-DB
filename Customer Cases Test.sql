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


--========2. View Customers========
SELECT * FROM customer;
SELECT * FROM cust_phones;


--========3. Customer Profile View========
SELECT * 
FROM vw_CustomerProfile;


--========4. Get Customer Orders========
EXEC sp_GetCustomerOrders @cust_id = 1;


--========5. Customer Financial Analytics Dashboard========
SELECT * 
FROM fn_CustomerFinancialAnalytics(1);


--========6. Customer Classification (VIP / Normal)========
SELECT * 
FROM vw_CustomerCategory;


--========7. Update Customer Address========
EXEC sp_UpdateCustomerAddress 
    @cust_id = 1,
    @street = 'Zamalek',
    @city = 'Cairo';

SELECT * 
FROM customer 
WHERE cust_id = 1;


--========8. Prevent Delete Customer With Orders========
DELETE FROM customer 
WHERE cust_id = 1;   


--========9. Delete Customer Without Orders========
DELETE FROM customer 
WHERE cust_id = 999;  


--========10. Data Validation========
SELECT * FROM customer;
SELECT * FROM cust_phones;
SELECT * FROM Orders;
