--Trigger: DML DDL

-- I UP DEL    CR AL DR

select * into oy from orders

create trigger trgdemo1 on oy
for insert, update, delete --erst danach wird die Aktion des Triggers ausgelöst
as
select * from inserted
select * from deleted


update oy set freight = freight *1.1 where orderid = 10250


select * into orders2 from orders

select * into od2 from [order details]

alter table orders2 add RngSumme money

select top 3 * from od2
select top 3 * from orders2

--Mittels Trigger RngSumme aktualisieren
--Order details...
create trigger trgRngSumme on od2 --instead of
after insert, update, delete --erst danach wird die Aktion des Triggers ausgelöst
as
select sum(unitprice*quantity) from inserted--nur INS und UP, aber kein DEL
select * from deleted --del aber auch die aus dem Update

select sum(unitprice*quantity) from od2 where 

--hier am besten auf die OrgTabelle gehen

--DDL
create table logging (id int identity, logtext xml)

ALTER trigger lachmichtot2
on database
for ALTER_VIEW--alle CR AL DR
as
insert into logging select eventdata()
rollback--vorsicht.. es wird nichts mehrins Log geschrieben


USE [Northwind]
GO

ALTER   view [dbo].[vdemo] with schemabinding
as
select count_big(*) as Anzahl3 , country from dbo.ku1 
group by country
GO


select * from logging

















