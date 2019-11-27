--DB Objekte

/*

1) adhoc select .....
2) View  select ....
3) F()   select ...
4) SP    select ......


--langsam ..schnell
1 2 3 4
SP  F()   V  adhoc

3 1|2 4 .. warum?

--Kompiliert? 
wird exakt genauso ausgeführt wie jedert andere Code..hmmmm
Pläne!!

*/

--Kompilierzeit:
select * from customers where city = 'Den Haag'--20..2IX 

--exec proc par..erster Aufruf der Proz ergibt den fixen Plan:--Plan wird eruirt



exec custordersdetail 10249--

select * from orders where orderid = 10249 --parametrisiert

select * from customers c inner join orders o on c.customerid = o.customerid where
o.orderid = 10249 --kann nicht mehr wiederverwendet werden.. 



--Warum ist F() schlechter (meist)




--Was würde im Plan stehen: gut =  SEEK --->  schlecht = SCAN

select * from customers where companyname like 'A%'

select * from customers where left(companyname,1) ='A'
--Zeile für Zeile.. SCAN

select * from f(xy)---1 oder 100..13755


--INDIZES!!!!


