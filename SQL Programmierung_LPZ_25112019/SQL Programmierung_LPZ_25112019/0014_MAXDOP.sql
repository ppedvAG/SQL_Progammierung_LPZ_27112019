--
--braucht mehr CPUs..
--gut oder schlecht

set statistics io, time on

select country, sum(freight) from customers c
inner join orders o on c.customerid = o.customerid
group by country
option (maxdop 4)



--RUNNABLE,.. RUNNING... SUSPENDED

--Messbar


select * from sys.dm_os_wait_stats where wait_type like 'CX%'



--|---------------|-----------------|
--0                50ms             60ms    110ms wait_time
-- signal time: Anteil der CPU 60... 110-60=50
--Anteil PCU > 25% .. CPU Engpass


select * from sys.dm_os_wait_stats order by 3 desc

--SLEEP QUEUE

select * from sysdatabases

--, CPU-Zeit = 7188 ms, verstrichene Zeit = 974 ms... demnach hat es sich gelohnt
--3 Sekunden für Paral... Dauer: 4500ms
--mit 6 CPUs ca gleich schnell.. 2 CPUs Pause.. CPU Zeit ist gesunken


--von 5 SQL Dollar und 0 (alle CPUs).. 50% d CPUS und 50 SQL Dollar






--aber effizient gewesen
--Wieviele CPUs?....8 CPUs.. fast! gleich groß.. er nimmt entweder 1 oder alle!
--weniger besser?

--CXPACKET: 
