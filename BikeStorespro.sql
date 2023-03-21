--customers and their order dates 
SELECT 
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name) as 'customers',
	cus.state,
	ord.order_date
From sales.orders ord
	Join sales.customers cus
	On ord.customer_id = cus.customer_id

-- sales volume and total revenue generated 
SELECT 
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name) as 'customers',
	cus.state,
	ord.order_date,
	SUM(ite.quantity) as 'total_units',
	SUM(ite.quantity * ite.list_price) as 'revnue'
From sales.orders ord
	Join sales.customers cus
	On ord.customer_id = cus.customer_id
	Join sales.order_items ite 
	On ord.order_id = ite.order_id 
Group by
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name),
	cus.state,
	ord.order_date

--sales volume, total revenue generated, and products purchased 
SELECT 
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name) as 'customers',
	cus.state,
	ord.order_date,
	SUM(ite.quantity) as 'total_units',
	SUM(ite.quantity * ite.list_price) as 'revnue',
	pro.product_name
From sales.orders ord
	Join sales.customers cus
	On ord.customer_id = cus.customer_id
	Join sales.order_items ite 
	On ord.order_id = ite.order_id 
	Join production.products pro
	ON ite.product_id = pro.product_id
Group by
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name),
	cus.state,
	ord.order_date,
	pro.product_name

--sales volume, total revenue generated, products purchased and category products purchased 
SELECT 
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name) as 'customers',
	cus.state,
	ord.order_date,
	SUM(ite.quantity) as 'total_units',
	SUM(ite.quantity * ite.list_price) as 'revnue',
	pro.product_name,
	cat.category_name
From sales.orders ord
	Join sales.customers cus
	On ord.customer_id = cus.customer_id
	Join sales.order_items ite 
	On ord.order_id = ite.order_id 
	Join production.products pro
	ON ite.product_id = pro.product_id
	Join production.categories cat 
	On pro.category_id = cat.category_id
Group by
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name),
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name 

--sales volume, total revenue generated, products purchased, category products purchased, store, and sales rep
SELECT 
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name) as 'customers',
	cus.state,
	ord.order_date,
	SUM(ite.quantity) as 'total_units',
	SUM(ite.quantity * ite.list_price) as 'revnue',
	pro.product_name,
	cat.category_name,
	sto.store_name,
	CONCAT(sta.first_name, ' ' ,sta.last_name) as 'sales rep'
From sales.orders ord
	Join sales.customers cus
	On ord.customer_id = cus.customer_id
	Join sales.order_items ite 
	On ord.order_id = ite.order_id 
	Join production.products pro
	ON ite.product_id = pro.product_id
	Join production.categories cat 
	On pro.category_id = cat.category_id
	Join sales.stores sto
	ON ord.store_id = sto.store_id 
	Join sales.staffs sta 
	On ord.staff_id = sta.staff_id
Group by
ord.order_id,
CONCAT(cus.first_name, ' ',cus.last_name),
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	sto.store_name, 
	CONCAT(sta.first_name, ' ' ,sta.last_name)