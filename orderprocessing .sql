CREATE TABLE Customer (
CustNo INT PRIMARY KEY,
cname VARCHAR(50),
city VARCHAR(50)
);
CREATE TABLE Order (
order_no INT PRIMARY KEY,
odate DATE,
cust_no INT,
order_amt INT,
FOREIGN KEY (cust_no) REFERENCES Customer(CustNo)
);
CREATE TABLE Order_Item (
order_no INT,
item_no INT,
qty INT,
PRIMARY KEY (order_no, item_no),
FOREIGN KEY (order_no) REFERENCES Order(order_no),
FOREIGN KEY (item_no) REFERENCES Item(item_no)
);
CREATE TABLE Item (
item_no INT PRIMARY KEY,
unit_price INT
);
CREATE TABLE Shipment (
order_no INT,
warehouse_no INT,
ship_date DATE,
PRIMARY KEY (order_no),
FOREIGN KEY (order_no) REFERENCES Order(order_no)
);
CREATE TABLE Warehouse (
warehouse_no INT PRIMARY KEY,
city VARCHAR(50)
);
-------------------------------------------------------------------------------
----------------------->>>>>>>>>>>>>>>>>>
Insertion:-
-- Inserting data into Customer Table
INSERT INTO Customer (CustNo, cname, city) VALUES
(1, 'Amit Kumar', 'Bangalore'),
(2, 'Priya Sharma', 'Mysuru'),
(3, 'Rajesh Singh', 'Hubli'),
(4, 'Sneha Patel', 'Belagavi'),
(5, 'Karthik Reddy', 'Mangalore'),
(6, 'Ananya Gupta', 'Gulbarga'),
(7, 'Vijay Singh', 'Shimoga'),
(8, 'Neha Kapoor', 'Davanagere'),
(9, 'Rahul Verma', 'Bellary'),
(10, 'Pooja Desai', 'Bidar');
-- Inserting data into Order Table
INSERT INTO Order (order_no, odate, cust_no, order_amt) VALUES

(101, '2023-01-15', 1, 5000),
(102, '2023-02-20', 2, 7000),
(103, '2023-03-10', 3, 8000),
(104, '2023-04-05', 4, 6000),
(105, '2023-05-12', 5, 9000),
(106, '2023-06-18', 6, 7500),
(107, '2023-07-02', 7, 8200),
(108, '2023-08-22', 8, 5500),
(109, '2023-09-15', 9, 6800),
(110, '2023-10-08', 10, 7200);
-- Inserting data into Item Table
INSERT INTO Item (item_no, unit_price) VALUES
(1, 100),
(2, 150),
(3, 200),
(4, 120),
(5, 180);
-- Inserting data into Order_Item Table
INSERT INTO Order_Item (order_no, item_no, qty) VALUES
(101, 1, 2),
(101, 2, 3),
(102, 1, 1),
(103, 3, 2),
(104, 4, 4),
(105, 5, 3),
(106, 2, 2),
(107, 1, 3),
(108, 5, 1),
(109, 4, 2);
-- Inserting data into Shipment Table
INSERT INTO Shipment (order_no, warehouse_no, ship_date) VALUES
(101, 1, '2023-01-20'),
(102, 2, '2023-02-25'),
(103, 1, '2023-03-15'),
(104, 3, '2023-04-10'),
(105, 2, '2023-05-18'),
(106, 1, '2023-06-25'),
(107, 3, '2023-07-10'),
(108, 1, '2023-08-28'),
(109, 2, '2023-09-20'),
(110, 3, '2023-10-15');
-- Inserting data into Warehouse Table
INSERT INTO Warehouse (warehouse_no, city) VALUES
(1, 'Bangalore'),
(2, 'Mysuru'),
(3, 'Hubli');
-------------------------------------------------------------------------------
---------------------------------------------------------------------------
-- List the Order# and Ship_date for all orders shipped from Warehouse# "0001".
select order_id,ship_date from Shipments where warehouse_id=0001;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------

-- List the Warehouse information from which the Customer named "Kumar" was
supplied his orders. Produce a listing of Order#, Warehouse#
select order_id,warehouse_id from Warehouses natural join Shipments where
order_id in (select order_id from Orders where cust_id in (Select cust_id from
Customers where cname like "%Kumar%"));
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-----------------
-- Produce a listing: Cname, #ofOrders, Avg_Order_Amt, where the middle column
is the total number of orders by the customer and the last column is the
average order amount for that customer. (Use aggregate functions)
select cname, COUNT(*) as no_of_orders, AVG(order_amt) as avg_order_amt
from Customers c, Orders o
where c.cust_id=o.cust_id
group by cname;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-----------------
-- Delete all orders for customer named "Kumar".
delete from Orders where cust_id = (select cust_id from Customers where cname
like "%Kumar%");
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------
-- Find the item with the maximum unit price.
select max(unitprice) from Items;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------
-- A tigger that updates order_amount based on quantity and unit price of
order_item
DELIMITER $$
create trigger UpdateOrderAmt
after insert on OrderItems
for each row
BEGIN
update Orders set order_amt=(new.qty*(select distinct unitprice from Items
NATURAL JOIN OrderItems where item_id=new.item_id)) where
Orders.order_id=new.order_id;
END; $$
DELIMITER ;
INSERT INTO Orders VALUES
(006, "2020-12-23", 0004, 1200);
INSERT INTO OrderItems VALUES
(006, 0001, 5); -- This will automatically update the Orders Table also
select * from Orders;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------
-- Create a view to display orderID and shipment date of all orders shipped
from a warehouse 2.
create view ShipmentDatesFromWarehouse2 as
select order_id, ship_date
from Shipments

where warehouse_id=2;
select * from ShipmentDatesFromWarehouse2;
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
