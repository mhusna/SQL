Set ServerOutPut ON;
Set timing ON;

 

Create Table orders as
Select *
From OracleData.Sales_Orders;

 

Select * From ORDERS;

 

Set autotrace ON;
Select ORDERID From ORDERS Where ORDERID = 10312;

 

Create Index inx_orders_orderid on ORDERS(ORDERID);

 

Set autotrace ON;
Select * From ORDERS Where ORDERID = 10312;

Set autotrace ON;
Select ORDERID From ORDERS Where ORDERID = 10312;

 

Set autotrace ON;
Select ORDERID, shipcountry From ORDERS Where ORDERID = 10312;
/

 

-- Drop Index inx_orders2;
/

 

Create Index inx_orders2 on ORDERS(ORDERID,CUSTID,EMPID);
/

 

Set autotrace ON;
Select ORDERID,CUSTID,EMPID From ORDERS Where ORDERID = 10312;

 

Set autotrace ON;
Select ORDERID,CUSTID,EMPID From ORDERS;
-- INDEX FAST FULL SCAN

 

Set autotrace ON;
Select * From ORDERS;
-- TABLE ACCESS FULL

 

Set autotrace ON;
Select SHIPCOUNTRY,SHIPCITY  From ORDERS Where ORDERID = 10312;
-- TABLE ACCESS BY INDEX ROWID | ORDERS
-- INDEX RANGE SCAN            | INX_ORDERS_ORDERID

 

Set autotrace ON;
Select SHIPCOUNTRY,SHIPCITY  From ORDERS;
-- TABLE ACCESS FULL| ORDERS

 

Create index ix_co_ci On ORDERS(SHIPCOUNTRY,SHIPCITY);

 

Set autotrace ON;
Select SHIPCOUNTRY,SHIPCITY  From ORDERS;
-- INDEX FAST FULL SCAN

 

Set autotrace ON;
Select SHIPCOUNTRY,SHIPCITY  From ORDERS where SHIPCOUNTRY = 'USA';
-- INDEX RANGE SCAN
/
Create Table customers as
Select *
From Sales_Customers;
/
Select * From customers;
/

 

Set autotrace ON;
Select *
From Orders o
join customers c on c.CUSTID= o.CUSTID;
-- HASH JOIN
-- TABLE ACCESS FULL| CUSTOMERS
-- TABLE ACCESS FULL| ORDERS

 

Set autotrace ON;
Select c.CUSTID, o.ORDERID
From Orders o
join customers c on c.CUSTID= o.CUSTID;
-- HASH JOIN
-- TABLE ACCESS FULL   | CUSTOMERS
-- INDEX FAST FULL SCAN| INX_ORDERS2

 

Create index ixcust1 on Customers(custid);
/
Set autotrace ON;
Select c.CUSTID, o.ORDERID
From Orders o
join AP.customers c on c.CUSTID= o.CUSTID;

 

--  NESTED LOOPS
-- INDEX FAST FULL SCAN| INX_ORDERS2
-- INDEX RANGE SCAN    | IXCUST1

 

Set autotrace ON;
Select c.CUSTID, o.ORDERID
From Orders o
join AP.customers c on c.CUSTID= o.CUSTID
Where c.CUSTID = 1;
/*
MERGE JOIN CARTESIAN |             
INDEX FAST FULL SCAN| INX_ORDERS2 
BUFFER SORT         |             
  INDEX RANGE SCAN   | IXCUST1    
*/

 

Set autotrace ON;
Select c.CUSTID, o.ORDERID
From Orders o
join customers c on c.CUSTID= o.CUSTID
Where o.CUSTID = 1;
/*
MERGE JOIN CARTESIAN |             
INDEX FAST FULL SCAN| INX_ORDERS2 
BUFFER SORT         |             
  INDEX RANGE SCAN   | IXCUST1    
*/

 

Set autotrace ON;
Select c.CUSTID, o.ORDERID, o.shipcountry, o.shipcity
From Orders o
join AP.customers c on c.CUSTID= o.CUSTID
Where o.CUSTID = 1;
/

 

Set autotrace ON;
Select c.CUSTID, o.ORDERID, o.shipcountry, o.shipcity
From Orders o
join AP.customers c on c.CUSTID= o.CUSTID
Where c.CUSTID = 1;
/
Set autotrace ON;
Select c.CUSTID, o.ORDERID, o.shipcountry, o.shipcity
From Orders o
join AP.customers     c on c.CUSTID = o.CUSTID
join ap.hr_employees  e on e.empid  = o.empid;

 

/
Set autotrace ON;
Select shipcountry, shipcity
From Orders
Where SHIPREGION = 'BC';
-- TABLE ACCESS FULL

 

Create index ixo_sr1 On Orders(SHIPREGION);
/

 

Set autotrace ON;
Select shipcountry, shipcity
From Orders
Where SHIPREGION = 'BC';

 

 

Create index ixo_sr2 On Orders(Lower(SHIPREGION));

 

Set autotrace ON;
Select shipcountry, shipcity
From Orders
Where Lower(SHIPREGION) = 'bc';
-- TABLE ACCESS BY INDEX ROWID| ORDERS
-- INDEX RANGE SCAN           | IXO_SR2

 

Set autotrace ON;
Select shipcountry, shipcity
From Orders
Where shipcountry='USA' and shipcity='Seattle';
-- INDEX RANGE SCAN| IX_CO_CI |	