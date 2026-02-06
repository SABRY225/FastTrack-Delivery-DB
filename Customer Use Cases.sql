
--=============================== Customer Use Cases ================================

--============= Register Customer ==============
use db40264

create or alter procedure sp_AddCustomer 
    @name varchar(100),
    @phone_number varchar(20),
    @street varchar(150),
    @city varchar(100)
as
begin

  declare @newCustId int;

   if exists (select 1 from cust_phones where phone_number = @phone_number)
    begin
        print 'Phone number already exists'
        return;
    end

  BEGIN TRY
     BEGIN TRANSACTION;
         
  insert into customer(name,street,city)
  values (@name,@street,@city)

  SET @newCustId = SCOPE_IDENTITY();

  insert into cust_phones(cust_id,phone_number)
  values (@newCustId,@phone_number)

     COMMIT TRANSACTION;
   END TRY
   BEGIN CATCH
      ROLLBACK TRANSACTION;
   END CATCH;
end


--============= Customer Profile ==============

create or alter view vw_CustomerProfile
as
select c.name , c.street, c.city, 
        ISNULL(COUNT(o.order_number), 0) as total_orders,ISNULL(SUM(o.total_cost),0) as total_spent,
        MAX(o.order_date) AS last_order_date
from customer c 
     left join Orders o
     on c.cust_id = o.cust_id
group by c.name,c.street, c.city


--============= Customer Orders ==============

create or alter procedure sp_GetCustomerOrders
   @cust_id int
as
begin

  if not exists (select 1 from customer where cust_id = @cust_id)
    BEGIN
        print 'The customer not found';
        return;
    END

  if not exists (select 1 from Orders where cust_id = @cust_id)
    BEGIN
        print 'There are no orders for this customer.';
        return;
    END

  select c.name,o.order_number,o.order_date,o.total_cost,o.order_status
  from Orders o
       inner join customer c 
         on o.cust_id = c.cust_id
         WHERE o.cust_id = @cust_id
   order by o.order_date desc
end


--============= Customer Financial Analytics Dashboard ==============

create or alter function fn_CustomerFinancialAnalytics(@customer_id int)
returns table
as
return

 select ISNULL(SUM(total_cost), 0) AS total_spent,
        ISNULL(AVG(total_cost), 0) AS average_order_value,
        COUNT(*) AS total_orders,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        ISNULL(DATEDIFF(DAY, MAX(order_date), GETDATE()), 0) AS days_since_last_order,
        (
            select top 1 pay_method 
            FROM Orders 
            WHERE cust_id = @customer_id 
            GROUP BY pay_method 
            ORDER BY COUNT(*) DESC
        ) AS preferred_payment_method,

        case 
            when ISNULL(SUM(total_cost), 0) > 10000 THEN 'VIP'
            else 'Normal'
        end as customer_type
        
 from Orders
 where cust_id = @customer_id



--============= Customer classification (VIP / Normal) ==============

create or alter view vw_CustomerCategory
as
select 
    c.cust_id,
    c.name,
    c.city,
    ISNULL(SUM(o.total_cost), 0) AS total_spent,
    COUNT(o.order_number) AS total_orders,
    CASE 
        WHEN ISNULL(SUM(o.total_cost), 0) >= 10000 THEN 'VIP'
        ELSE 'Normal'
    END AS customer_type
from customer c
left join Orders o ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.name,c.city


--============= Customer address update ==============

create or alter procedure sp_UpdateCustomerAddress
    @cust_id int,
    @street varchar(150),
    @city varchar(100)
as
begin

 if not exists (select 1 from customer where cust_id = @cust_id)
    begin
        print 'Customer Not Found';
        return;
    end

    UPDATE customer
    SET street = @street,
        city = @city
    WHERE cust_id = @cust_id
END


--============= Preventing the deletion of a customer with orders ==============
create or alter trigger trg_PreventDeleteCustomer
on customer
instead of delete
as
begin
    if exists ( select 1 from deleted d 
                where exists (
                select 1 
                from Orders o 
                where o.cust_id = d.cust_id)
              )
    begin
        print 'Cannot delete customer with existing orders';
        rollback
        return;
    end

    delete from customer
    where cust_id in (select cust_id from deleted)
     PRINT 'Deleted successsfully'
end
