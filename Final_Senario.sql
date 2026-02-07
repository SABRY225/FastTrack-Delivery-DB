--------- Client or Customer

-- 1. Add Cuystomer
EXEC sp_AddCustomer 
    @name = 'Shimaa',
    @phone_number = '01211111111',
    @street = 'Konouz',
    @city = 'Qena';

    -- Duplicate Phone Test
EXEC sp_AddCustomer 
    @name = 'Mohammed',
    @phone_number = '01211111111',   -- ‰›” «·—ﬁ„
    @street = 'October',
    @city = 'Cairo';

EXEC sp_UpdateCustomerAddress 
    @cust_id = 1,
    @street = 'Zamalek',
    @city = 'Cairo';


SELECT * FROM customer WHERE cust_id = 1;

-- 2.  add order for the customer
EXEC sp_CreateOrder
    @order_number = 2100,
    @order_date = '2025-01-10',
    @cust_id = 1,
    @driver_id = null,
    @office_id = 1,
    @order_status = 'pending';

EXEC sp_AddDeliveryItem
    @item_id = 3,
    @description = 'Laptop',
    @item_weight = 2.5,
    @delivery_fee = 100,
    @order_number = 2000;


-- 3.  The customer display orders
EXEC sp_GetCustomerOrders @cust_id = 1;

-- 4. Cancel order
UPDATE Orders
SET order_status = 'cancelled'
WHERE order_number = 1;

-- 5. View a financial report for the client
SELECT * 
FROM fn_CustomerFinancialAnalytics(1);

-- 6. The customer deleted the account while on the orders
DELETE FROM customer 
WHERE cust_id = 1;   


--------- Office
--1. View all orders
	SELECT *
	FROM Orders
	WHERE office_id = 1;

--2. View order details
	SELECT *
	FROM vw_OrderDetails
	WHERE order_number = 2000;

--3. Preventing the deletion order

	DELETE FROM Orders
	WHERE order_number = 2000;
	
--4. Shipping order form (person and automatic vehicle)
	exec sp_AssignOrderToDelivery @order_number = 2000

--------- Driver
--1. Create a delivery driver
EXEC sp_RegisterDriver
    @emp_name = 'Ahmed Hassan',
    @job_title = 'Delivery Man',
    @hire_date = '2024-01-10',
    @salary = 6000,
    @office_id = 1,
    @license_number = 'LIC-DEL-001';


--2. View their profile
EXEC GetCustomerProfile @cust_id = 10;

--3. View assigned orders
EXEC sp_GetDriverOrders @driver_id = 1;


--4. Calculate their total earnings
SELECT dbo.fn_TotalDriverEarnings(1) AS Total_Earnings;

--5. Payment process (delivering the order to the customer and changing its status)
EXEC [dbo].[sp_PayOrder] 2000, 'cash';

--6.  delivery report
EXEC GetDeliveryReport @driver_id = 3;


--------- Owner
--1. Complete report for a specific office
	SELECT *
	FROM vw_OfficeSummary
	WHERE office_id = 1;

--2. I cannot delete a branch with employees
	DELETE FROM office
	WHERE office_id = 1;

--3. Customer classification as Regular or VIP

SELECT * 
FROM vw_CustomerCategory;
