select employeeid, lastname, reportsto from employees


--Liste 
Fuller       0
Leverling    1
Peacock      1
Buchanan    1
Callahan     1
Dodsworth    2
King        2


--CTE
WITH CTENAME (Spalten, Spalten..)
as
(Ergebnismenge)
select * from cte

with kundenfrachtkosten (Firma, Frachtkosten)
as
(select companyname as Firma, freight as Fracht from customers c inner join
		orders o on c.customerid = o.customerid)
select Firma, sum(Frachtkosten) from Kundenfrachtkosten group by Firma


WITH CTE (Spalten)
as
(select --Basis
UNION ALL
select --)
select ..CTE

WITH CTEANG (id, Nachname, Ebene)
as
(select employeeid, lastname, 0 as Ebene from employees where reportsto is null
UNION ALL
select employeeid , lastname, Ebene +1 from employees e
	inner join CTEANG on CTEANG.id=e.reportsto
)
select * from CTEANG where ebene = 2





















