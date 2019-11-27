--Prozeduren
/* schneller, weil Plan kompiliert vorliegt, nach dem ersten Aufruf mit dem ersten Param..
*/
select * from customers[CustomerID]
--[CustomerID] nchar(5)
exec gpKundensuche 'ALFKI'	--1 Zeile
exec gpKundensuche 'A'		--4 Zeile
exec gpKundensuche			--alle  Zeile


create or alter proc gpKundensuche @kdid varchar(10) = '%'
as
select * from customers where customerid like @kdid +'%' --'A    %'

declare @var as varchar(150) --50%.. statt75 30 Zeichen
select * from tabelle where order by sp--RAM Schätzung.. 15MB --12 MB--2 MB in tempdb auslagern
--Profiler : sort warnings


--alles schlecht!!!!
--niemals benutzerfreundlich

--Thema des vormittags??
--Indizes

--Vorteil der Proc: komp. mit ersten Param

select * from customers where customerid like 'ALFKI%' --IX? NIX_CUSTID  3 Seiten

select * from customers where customerid like '%%' --92--SCAN

--SEEK


select * into ku3 from ku1
dbcc showcontig('Ku3')
set statistics io, time on
select * from ku3 where kuid < 10500--, CPU-Zeit = 0 ms, verstrichene Zeit = 237 ms. Seiten 102 von 42166

--Nicht gr IX auf KUID
create or alter proc gksucheid @kuid int 
as
select * from ku3 where kuid < @kuid
GO


exec gkSucheId 1000000 --1.002.239  Seiten !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--Was wäre eine Kompromisslösung..Idee

dbcc freeproccache

--neuer Plan mit SCAN


--neue Idee.. immer richtiger Plan





exec gkSucheId 1000000 --Plan mit Scan--42000--42166,



exec gkSucheId 100


--Trick.. die richtige Proc aufrufen

create proc
as
IF @par < 11000
	exec gpSuchemitSeek
else
	exec gpsuchemitScan

	--25
create proc testxy @par 50
as
if @par < 50
select * from orders where freight < @par --25
else
select * from products where unitsinstock > @par--grob geschätzte


select * from ku3 where left(kuid,1) = 1--SQL 2019.. fbrutto(sp)< 100

--wir sind wieder da.. ;-)












exec gpKundensuche 'A'		--4 Zeile
exec gpKundensuche			--alle  Zeile

