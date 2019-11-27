/*
Indizes

Gruppierter (Clustered) IX
Nicht gruppierter (non cl) IX
-------------------------------
xabdeckender IX
gefilterter IX
xzusammengesetzten IX
xIX mit eingeschl Spalten
xpartitionierter IX 
xind Sicht
xeindeutigen IX
---------------------------------
xColumnstore (cl und non cl)

*/
use northwind
GO


SELECT Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, Orders.ShipCountry, 
                  [Order Details].Quantity, [Order Details].UnitPrice, [Order Details].ProductID, [Order Details].OrderID, Employees.LastName, Employees.FirstName, Employees.BirthDate, Products.ProductName, Products.UnitsInStock
into KundeUmsatz
FROM     Customers INNER JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                  [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                  Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                  Products ON [Order Details].ProductID = Products.ProductID

--bei 1,1 Mio Zeile Schluss (551000)
insert into Kundeumsatz
select * from kundeumsatz


select * into ku1 from kundeumsatz


alter table ku1 add kuid int identity

set statistics io, time on
select kuid from ku1 where kuid = 100
--Plan: T SCAN
--56117-- 312..57ms

--Verbessern: zuerst CL IX festlegen (bereichsabfragen)..Orderdate
--NIX_KUID
select kuid from ku1 where kuid = 100
--3 Seiten.. 0 ms-- wg 3 Seiten weiss man auch, dass der IX aus  3 Ebene

select kuid, freight from ku1 where kuid =100
--IX Seek mit Lookup (50%) .. 4 Seiten.. 0 ms

--NIX_KUID_FR.. zusammengesetzter IX
select kuid, freight from ku1 where kuid =100
--IX SEEK.. 3 Seiten 0 ms

--Wieviele IX kann eine Tabelle haben mit 3 Spalten A B C
--ca 1000
--sp_blitzIndex Brent Ozar

--abdeckender IX: wenn eine Abfrage komplett per IX seek beantwortet wird...
select kuid, freight, city, country, ... from ku1 where kuid =100
--zusammengestzter IX kann nicht mehr als 16 Spalten haben..max 900byte

--SELECT Spalten und where Unterscheiden
--IX mit eingeschl Spalten..kann 1000 Spalten haben
select kuid, freight, city, country from ku1 where kuid =100

select orderdate, freight, birthdate from ku1 where city = 'Berlin'
--NIX_CITY_inkl_odfrbd

select freight from ku1 where city = 'Berlin' or Unitprice = 3.25
--IX NIX_CI_INKL_FR  NIX_UP_INKL_FR..2 Indizes

--Selektivere Spalte zuerst
select freight from ku1 where country = 'UK' and city = 'London'

select freight from ku1 where kuid= 100 and city = 'London'


select freight from ku1 
	where city = 'Berlin' or (employeeid = 3 and unitsinstock = 10)

--NIX!!!..Klammern verlangen!!


--Anzahl der Ebenen: 5 Ebenen--> 4 oder 3 Ebenen


--NIX_CITY_filter_London
-- hat 3 Ebenen .. ein IX auf alle hat auch 3 .. kein sinn mehr für gefiltert

--Abfrage..Schätzung 100DS--> IX!  IX1 IX2 IX3 .. zuerst den mit geringeren Tiefe.. IX1 IX2

--DMV
select * from sys.dm_db_index_usage_Stats where database_id = db_id()


dbcc showcontig('ku1')-- 42162

select * from ku1 where unitprice = 100 --56117

-- KUID!! in 99% vollen Seiten
--zusätzl. Spalte mit IDs in weitere Seiten hinten ranhängen

select * from sys.dm_db_index_physical_Stats(db_id(), object_id('ku1'), NULL, NULL, 'detailed')

--das muss besser werden--Lösung: forward Record Counts müssen weg--> CL IX


select top 3 * from ku1

--Aggregat, pro .. where 
--Umsatz pro City

--ku1..(unitprice, quantity, pro Stadt nur die wo Ang Nr 1 verkaufte




select 
		  city
		, sum(unitprice*quantity) from ku1 
where 
		country = 'UK'
group by city
/*
CREATE NONCLUSTERED INDEX NIXTEST
ON [dbo].[ku1] ([EmployeeID])
INCLUDE ([City],[Quantity],[UnitPrice])
*/
--1054 Seiten  31...24ms

select 
		  city
		, sum(unitprice*quantity) from ku2 
where 
		country = 'UK'
group by city

--Magic--
--KI-- KA

--statt 330MB nur 3
--a es handelt sich um 3 MB Daten
--b es handelt sich um Zeiger --> x

--a.. 300--3MB --Kompression (row, page) 40-60%..??

--2011..Excel..PowerPivot ..RAM
--2012..Columnstore ab 2016 Sp1 gr. Columnstore auch in SSEX!!!



2GB --> 170MB--> 72MB

insert into ku2
SELECT top 100000 [CustomerID]
      ,[CompanyName]
      ,[ContactName]
      ,[ContactTitle]
      ,[City]
      ,[Country]
      ,[EmployeeID]
      ,[OrderDate]
      ,[Freight]
      ,[ShipCity]
      ,[ShipCountry]
      ,[Quantity]
      ,[UnitPrice]
      ,[ProductID]
      ,[OrderID]
      ,[LastName]
      ,[FirstName]
      ,[BirthDate]
      ,[ProductName]
      ,[UnitsInStock]
 
  FROM [dbo].[ku2]
GO









--Wie schnell ist eine Sicht im vergl zur adhoc Abfrage

select count(*) as Anzahl , country from ku1 ---8245,170 ms, verstrichene Zeit = 38 ms.
group by country--Ent


create or alter view vdemo with schemabinding
as
select count_big(*) as Anzahl , country from dbo.ku1 
group by country

select * from vdemo--2 Seiten.. 0ms

--Hat eine Sicht Daten?--- NEIN!!
--

--Annahme: wir liefern an alle Länder der Welt Waren aus..
--Analyse: Umsatz pro Land seit Bestehen der Firma..
--20 Billionen DS

--Frage.. wie lange dauert die Abfrage und wieviele Seiten braucht die Abfrage?
--ca 0 Dauer... 2 Seiten

--Einschränkungen: count_big(*), Schemagebunden, eindeutigkeit.. 












--TAB SCAN vs CL IX SCAN.. gleich
--IX SEEK od IX SCAN ... IX SEEK
--IX SCAN vs TAB SCAN vs CL IX SCAN .. IX SCAN(5000)
--IX SEEK --> HEAP ! besser
--IX SEEK --> CL IX

--uniqueidentifier
select newid()--sehr sehr eindeutig

--? CL IX auf GUID ????--CL IX???

---Niemals !!






















Spaltenindex

select * from customers





*/

insert into customers (customerid, companyname) values ('ppedv', 'ppedv AG')


--Table Scan, CL IX SCAN, IX SCAN, CL IX SEEK, NCL IX SEEK
select * from bestell
--PK macht per default einen CL IX rein!!
--keine gute Abfrage mehr auf BDatum möglich

--PK braucht nur eine Eindeutigkeit

--Tabelle anlegen--> CL IX vergeben, dann PK!!

--
--


