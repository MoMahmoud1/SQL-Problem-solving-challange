use my_guitar_shop ;
/*
1. Write an INSERT statement that adds this row to the Categories table:
category_name: Brass
Code the INSERT statement so MySQL automatically generates the
category_id column.
*/
insert into categories (category_name, category_id)
values('Brass', default);

/*
2. Write an UPDATE statement that modifies the row you just added to the
Categories table. This statement should change the product_name column
to “Woodwinds”, and it should use the category_id column to identify the
row.
*/

-- select * from categories;
update categories
set productn_name = 'Woodwinds' 
where category_id = 5;
/*
3. Write a DELETE statement that deletes the row you added to the
Categories table in exercise 1. This statement should use the category_id
column to identify the row.
*/

delete from categories 
where category_id = 5;

/*
4. Write an INSERT statement that adds this row to the Products table:
product_id: The next automatically generated ID 
category_id: 4
product_code: dgx_640
product_name: Yamaha DGX 640 88-Key Digital Piano
description: Long description to come.
list_price: 799.99
discount_percent: 0
date_added: Today’s date/time.
Use a column list for this statement.
*/
insert into products(product_id,category_id,product_code,product_name,description,list_price,discount_percen,date_added)
values(default, 4, dgx_640, 'Yamaha DGX 640 88-Key Digital Piano','Long description to come', 799.99, 0, now());

/*
5. Write an UPDATE statement that modifies the product you added in
exercise 4. This statement should change the discount_percent column
from 0% to 35%.
*/
-- select * from products;
update products
set discount_percent = 35
where product_id = 5;

/*
6. Write a DELETE statement that deletes the Keyboards category. When you
execute this statement, it will produce an error since the category has
related rows in the Products table. To fix that, precede the DELETE
statement with another DELETE statement that deletes all products in this
category. (Remember that to code two or more statements in a script, you
must end each statement with a semicolon.)
*/
-- select * from categories;
delete Categories
from Categories c join Products p
ON c.Category_id = p.Category_id;

/*
7. Write an INSERT statement that adds this row to the Customers table:
email_address: rick@raven.com
password: (empty string)
first_name: Rick
last_name: Raven
Use a column list for this statement.
*/
insert into customers(email_address, password, first_name, last_name)
values('rick@raven.com', '', Rick, Raven )  ;


/*
8. Write an UPDATE statement that modifies the Customers table. Change
the password column to “secret” for the customer with an email address
of rick@raven.com.
*/

update customers
set password = 'secret' 
where email_address = 'rick@raven.com';

/*
9. Write an UPDATE statement that modifies the Customers table. Change
the password column to “reset” for every customer in the table. If you get
an error due to safe-update mode, you can add a LIMIT clause to update
the first 100 rows of the table. (This should update all rows in the table.)
*/

update customers
set password = 'reset'
where password is not null 
limit 100; 

/*
10. Open the script named create_my_guitar_shop.sql that’s in the
mgs_ex_starts directory. Then, run this script. That should restore the data
that’s in the database.

*/

/*
1. Write a SELECT statement that returns these columns:
The count of the number of orders in the Orders table
The sum of the tax_amount columns in the Orders table
*/
select count(*) as total_orders, sum(tax_amount) as total_tax
from orders ;

/*
2. Write a SELECT statement that returns one row for each category that has
products with these columns:
The category_name column from the Categories table
The count of the products in the Products table
The list price of the most expensive product in the Products table
Sort the result set so the category with the most products appears first.
*/

select c.category_name,
    COUNT(p.product_id) AS product_count,
    ROUND(AVG(p.list_price), 2) as average_price
from categories c join products p 
on c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC;

/*
3. Write a SELECT statement that returns one row for each customer that has
orders with these columns:
The email_address column from the Customers table
The sum of the item price in the Order_Items table multiplied by
the quantity in the Order_Items table
The sum of the discount amount column in the Order_Items
table multiplied by the quantity in the Order_Items table
Sort the result set in descending sequence by the item price total for each
customer.
*/
select
    email_address AS email,
    SUM(item_price * quantity) AS item_price_total,
    SUM(discount_amount * quantity) AS discount_total
from
    customers c join orders o on c.customer_id = o.customer_id
        join
    order_items oi ON o.order_id = oi.order_id
GROUP BY c.email_address
ORDER BY item_price_total ASC;

/*
. Write a SELECT statement that returns one row for each customer that has
orders with these columns:
The email_address column from the Customers table
A count of the number of orders
The total amount for each order (Hint: First, subtract the
discount amount from the price. Then, multiply by the
quantity.)
*/

select
    email_address AS email,
    count(order_id) as number_of_order,sum((item_price-discoutn_amount)*quantity) as sum_of_line_item_amounts
from customers c join orders o 
on c.customer_id = o.customer_id
        join
    order_items oi 
on o.order_id = oi.order_id
GROUP BY c.email_address
HAVING number_orders >1
ORDER BY sum_of_line_item_amounts desc;    

/*
 Modify the solution to exercise 4 so it only counts and totals line items
that have an item_price value that’s greater than 400.
*/
select count(*) as total_item_count ,sum(item_price) as total_price 
from order_items
where item_price >400;






















