--Sichten: 
--Vereinfachung
--Rechte (I, UP, D).. Rechte!!

drop table demosicht
create table demosicht(stadt int, land int, fluss int)

insert into demosicht
select 1,10,100
UNION ALL
select 2,20,200
UNION ALL
select 3,30,300

select * from demosicht


create view viewdemo2 with schemabinding
as
select stadt, land, fluss from dbo.demosicht

select * from viewdemo2

alter table demosicht add Tier int

update demosicht set tier = Stadt * 1000

select * from demosicht

select * from viewdemo

alter table demosicht drop column tier

select * from demosicht

select * from viewdemo

--wie kann man das vermeiden!!!

--with schemabinding: du musst exakt arbeiten

create view viewdemo2 with schemabinding
as
select * from demosicht



create view vdemo3
as
SELECT Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, 
		Customers.CustomerID, Employees.EmployeeID, Employees.Title, 
		Employees.LastName, Employees.FirstName, [Order Details].ProductID, 
        [Order Details].UnitPrice, [Order Details].Quantity,
		Products.ProductName, Orders.EmployeeID AS Expr1, Orders.OrderDate, 
		Customers.City, Customers.Country
FROM     Customers INNER JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                  Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                  [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                  Products ON [Order Details].ProductID = Products.ProductID

set statistics io, time on
select distinct companyname from vdemo3 where country = 'UK'

select companyname from customers where country = 'UK'



--TAB Ang Userxy Verweigern
--USerXY Sichten anlegen.. 

--TX LOCKS CTE TRIGGER
--PIVOT
--Window JOIN SUBQUERIES CURSOR 
--##t1 vs Tabellenvariablen (> 1000) ..@ @@
drop #t1
--Offline
--VS_
--txt  BULK INSERT
--

1 23
2 234
3 434
4
5