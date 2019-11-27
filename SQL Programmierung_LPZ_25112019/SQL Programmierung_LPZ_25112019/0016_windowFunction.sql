--Giftliste: kein IX (CL IX), F(), Trigger, C r o r, U a f r n, CTE



--Tabelle erstellen

drop table DemoTab

create table demoTab(
		id		int identity not null	primary key,
		x		decimal(8,2) not null	default 0,
		spalten char(100)	 not null	default '#'
		)
go











--select * from demotab
--select abs(checksum(NEWID()))*0.01%20000
insert demotab(x)
	select 	0.01 *ABS(checksum(newid()) %20000) from tuning..Numbers 
	where id<= 20000
		

select * from demotab

--> 1 112
--> 2 286
--> 3 

--Hmm wie?
--Window F(), Join, Subqueries

--Kurze Worte zu newid()
select NEWID()

select 0.01*ABS(checksum(newid())) %20000

select * from demotab


-- select CHECKSUM(200.09)
	-- select checksum(*) from Northwind..Customers


--select * from demotab
--Errechnen der laufenden Summe

select   
		T1.id, SUM(t2.x) as rt 
from 
		demotab T1 inner join demoTab T2 
										on T2.id <= t1.id
group by t1.id
order by id


select t1.id,  t1.x, t2.x
from 	
		demotab T1 inner join demoTab T2 
										on T2.id <= t1.id
order by t1.id


-- Alternative
select   T1.id, 
		(select SUM (t2.x) 
				from 
					demotab T2 
				where t2.id <= T1.id
		) as rt
from demotab t1
order by t1.id

--14 Sek.. 39Sek

select *, (Select max(freight) from orders where ..) from customers

select * from (select * from orders) t inner join customers c on t.customerid..

select * from orders
	where shipcountry in (select country from customers)




--Cursor
-- errechnete Werte in eine temp Tabelle wegschreiben
-- fast forward zum schnellen durchlauf

--Temp Tabelle #t
create table #t(id int not null primary key, s decimal (16,2) not null)

--Variablen mit Spalten der T1 und Spalte @s für Summen
declare @id int, @x decimal(8,2), @s decimal (16,2)
set @s= 0

--Cursor deklarieren
declare #c cursor fast_forward for
	select id, x from demotab order by id
	
--Cursor öffnen
open #c
	-- solange durchlaufen und füllen  bis Ende
	while (1=1)
		begin
		fetch next from #c into @id, @x
		if (@@FETCH_STATUS != 0) break 
		set @s=@s+@x
		
		if @@TRANCOUNT = 0	begin tran

		insert #t values (@id,@s)
		
		if (@id %1000) = 0	commit
	end	
if @@trancount >0
	commit
	close #c
	deallocate #c
	
select * from #t order by id

drop table #t


-- Cursor dann ok, wenn keine mengenbasierende Lösung 



--Window Function
select id, 
		SUM(x) OVER(ORDER BY id RANGE UNBOUNDED PRECEDING) "Range"  
from demotab

--LAG LEAD
--RANK--
--NTILE ()
--row_number
--dense_rank()



select * from demotab

select row_number() over(order by id partition by sp)

select * from kundeumsatz


--, country , Customerid, sum(freight)

select country, customerid, sum(freight)
from kundeumsatz
group by country, customerid



select country, customerid, sum(freight) as Summe, row_number() over (order by country) as RANG
from kundeumsatz
group by country, customerid

select * from 
	(
	select country, customerid, sum(freight) as Summe, 
			row_number() over (partition by Country order by sum(freight) desc) as RANG

	from kundeumsatz
	group by country, customerid
	) t where rang = 1


select * from #t where rang = 1


--dense_rank()
--ntile()
--rank()







