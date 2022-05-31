if object_id('order', 'U') is not null
drop table [order]
if object_id('invoice', 'U') is not null
drop table [invoice]
if object_id('payment_method', 'U') is not null
drop table [payment_method]
if object_id('client', 'U') is not null
drop table [client]
go

create table [client] (
    [id] int identity(1, 1) primary key,
    [first_name] nvarchar(max) not null,
    [last_name] nvarchar(max) not null,
    [company_name] nvarchar(50),
    [address] nvarchar(100) not null,
    [email] nvarchar(50) not null,
    [phone_number] nvarchar(10) not null
);
create table [payment_method] (
    [id] int identity(1, 1) primary key,
    [client_id] int references client(id),
    [type] nvarchar(10) not null,
    [number] nvarchar(16) not null,
    [exp_month] nvarchar(10) not null,
    [exp_year] int not null,
    [security_code] int not null
);
create table [invoice] (
    [id] int identity(1, 1) primary key,
    [client_id] int references client(id),
    [pega_order_number] nvarchar(6) not null,
    [date] date not null,
    [total] decimal(38, 2) not null,
    [commission] decimal(38, 2) not null
);
create table [order] (
    [id] int identity(1, 1) primary key,
    [client_id] int references client(id),
    [invoice_id] int references invoice(id),
    [date] date not null,
    [product_name] nvarchar(50) not null,
    [product_quantity] int not null,
    [product_price] decimal(38, 2) not null
);
go

insert into [client] ([first_name],[last_name], [address], [email], [phone_number]) values
('Dan', 'Lebron', '4633 Norman Street, Long Beach, CA 90802', 'wplee.327@gmail.com', '5623136450'),
('Natalia', 'McRae', '3458 Ritter Street, Decatur, AL 35601', 'wplee.327@gmail.com', '2565666545'),
('Richard', 'Tillison', '635 Vine Street, Cary, IL 60013', 'wplee.327@gmail.com', '7083595624'),
('James', 'Yokoyama', '2517 Rivendell Drive, Lordstown, OH 44483', 'wplee.327@gmail.com', '4197423947'),
('Rebecca', 'Smith', '2950 Pallet Street, New York, NY 10007', 'wplee.327@gmail.com', '9174392751');
insert into [payment_method] ([client_id], [type], [number], [exp_month], [exp_year], [security_code]) values
(1, 'Visa', '4046203747133351', 'January', 2020, 966),
(2, 'Mastercard', '5305982984853994', 'October', 2018, 731),
(3, 'Visa', '4148510943586076', 'March', 2019, 378),
(4, 'Visa', '4054264415776508', 'September', 2019, 432),
(5, 'Mastercard', '5146867954383366', 'September', 2017, 744);
go

select * from [client];
select * from [payment_method];
select * from [invoice];
select * from [order];