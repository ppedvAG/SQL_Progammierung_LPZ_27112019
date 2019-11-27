select customerid as KundenId , sum(freight) as Frachtsumme
from orders
where customerid like 'A%'
group by customerid
order by Frachtsumme desc


select customerid as KundenId , sum(freight) as Frachtsumme
from orders
where customerid like 'A%' --geht nicht
group by customerid
order by Kundenid desc


select o.customerid as KundenId , sum(freight)*1.19 as Frachtsumme
from orders o
where customerid like 'A%' 
group by customerid having sum(freight)> 200
order by Kundenid desc

--Logischer Fluss

--> FROM (Alias)-->JOIN--> WHERE --> GROUP BY --> HAVING --> SELECT (nicht Ausgabe; Berchnungen, Alias)
-->ORDER BY (ALIAS, 1,2,3) --> TOP |DISTINCT --> AUSGABE


--was darf ich daher nicht tun

select customerid, sum(freight) from orders
group by customerid having shipcity = 'ALFK ' --niemals etas mit ahving filtern, was im where gefiltert werden kann
--das having sollte nur AGG filtern

select '!'+Shipcity + '!' from orders where shipcity = 'Reims '

--T1 FinnSw   T2 Latin

--#t1.. FinnSw...> Latin1..

--Contained DB verwenden!




















