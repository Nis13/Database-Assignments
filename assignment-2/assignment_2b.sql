create schema bookStore

create table bookstore.Publishers(
	publisher_id serial primary key,
	publisher_name varchar(255) not null,
	country varchar(255)
)

create table bookstore.Authors(
	author_id serial primary key,
	author_name varchar(255) not null,
	birth_date timestamp,
	nationality varchar(255)
)

create table bookstore.Books(
	book_id serial primary key,
	title varchar(255) not null,
	genre varchar(255) default 'unknown',
	publisher_id int,
	publication_year int,
	foreign key (publisher_id) references bookstore.Publishers(publisher_id)
)

create table bookstore.Customers(
	customer_id serial primary key,
	customer_name varchar(255) not null,
	email varchar(255) unique,
	address varchar(255)
)

create table bookstore.Orders(
	order_id serial primary key,
	order_date timestamp,
	customer_id int,
	total_amount int,
	foreign key(customer_id) references bookstore.Customers(customer_id)
)

create table bookstore.Book_Authors(
	book_id int,
	author_id int,
	foreign key(book_id) references bookStore.Books(book_id),
	foreign key(author_id) references bookStore.Authors(author_id)
)

create table bookstore.Order_Items(
	order_id int,
	book_id int,
	foreign key(order_id) references bookStore.Orders(order_id),
	foreign key(book_id) references bookStore.Books(book_id)
)
