create schema assignment_1;

create table assignment_1.Products (
	product_id INT primary key,
	product_name VARCHAR(255),
	category varchar(255),
	price int
);

create table assignment_1.Orders (
	order_id INT primary key,
	customer_name VARCHAR(255),
	product_id INT REFERENCES assignment_1.Products(product_id),
    quantity INT,
    order_date DATE
);

insert into assignment_1.products (product_id,product_name,category,price)
values
(1, 'Laptop', 'Electronics', 1200),
(2, 'Smartphone', 'Electronics', 800),
(3, 'Headphones', 'Accessories', 150),
(4, 'Desk Chair', 'Furniture', 200),
(5, 'Monitor', 'Electronics', 300);

INSERT INTO assignment_1.Orders (order_id, customer_name, product_id, quantity, order_date) VALUES
(1, 'Alice', 1, 1, '2024-07-01'),
(2, 'Bob', 2, 2, '2024-07-01'),
(3, 'Charlie', 3, 3, '2024-07-02'),
(4, 'David', 4, 5, '2024-07-02'),
(5, 'Eve', 1, 6, '2024-07-02');

--Calculate the total quantity ordered for each product category in the orders table
select p.category , sum(o.quantity) as totalquantity
from assignment_1.products p 
join assignment_1.orders o on o.product_id = p.product_id 
group by p.category 

-- Find categories where the total number of products ordered is greater than 5
select p.category , sum(o.quantity) as totalquantity
from assignment_1.products p 
join assignment_1.orders o on o.product_id = p.product_id 
group by p.category 
having sum(o.quantity)>5;



