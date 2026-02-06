SELECT * FROM customer
SELECT * FROM office
SELECT * FROM delivery
SELECT * FROM employee
SELECT * FROM Orders
SELECT * FROM deliveryItem
--========1.Creat Order========
EXEC sp_CreateOrder
    @order_number = 1005,
    @order_date = '2025-01-10',
    @cust_id = 1,
    @driver_id = 1,
    @office_id = 1,
    @order_status = 'pending';
--========2.Add Delivery Items========
	EXEC sp_AddDeliveryItem
    @item_id = 1,
    @description = 'Laptop',
    @item_weight = 2.5,
    @delivery_fee = 100,
    @order_number = 1005;

	--========
	EXEC sp_AddDeliveryItem
    @item_id = 2,
    @description = 'Headphones',
    @item_weight = 0.5,
    @delivery_fee = 40,
    @order_number = 1005;
--========3.Calculate Order Total========
	SELECT dbo.fn_CalculateOrderTotal(1005) AS Total_Cost;


--========4.Auto Update Order Total========
	SELECT order_number, total_cost
	FROM Orders
	WHERE order_number = 1005;

--========5.View Order Details========
	SELECT *
	FROM vw_OrderDetails
	WHERE order_number = 1005;

--=======6.Paid orders must have a payment amount.

	UPDATE Orders
	SET order_status = 'paid'
	WHERE order_number = 1005;

--========7.Pay Order========
	EXEC [dbo].[sp_PayOrder] 1005, 'cash';

--========8.Office Summary Report========
	SELECT *
	FROM vw_OfficeSummary
	-- or in one
	WHERE office_id = 1;

--========9.Prevent Office Deletion========
	DELETE FROM office
	WHERE office_id = 1;
--========10.Prevent Office Deletion========
	SELECT *
	FROM Orders
	WHERE office_id = 1;


