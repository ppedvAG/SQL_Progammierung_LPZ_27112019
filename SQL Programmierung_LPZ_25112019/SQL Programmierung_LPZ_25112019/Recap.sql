--Programmierung

--DBDesign: Normalisierung --> Redundanz  #temp, zusätzliche Spalten RngSumme
--Rdundanz pflegen: Trigger, Jobs, Rechtesystem...

--Warum ist Trigger nicht der schnellste...?

--DDL create, alter drop   DML ins up del


--DML
insert --> inserted Tabelle
delete --> deleted Tabelle
update --> inserted und deleted

--Wie oft?


--Nicht vergessen: Physik unter der Haube
--Blöcke und Seiten (8192bytes 8060)
--Blöcke besdtehen aus 8 aufeinanderfolgenden Seiten
--IAM

--Warum sollte man auf das schauen?
--dbcc showcontig('Tabelle')
--Seiten.. mittlerer ´Füllgrad
--Anzahl der Seiten * 8kb --> RAM  (50,79)
--Verbesserung der Auslastung varchar statt char

--Seiten sind mit varchar voll (Schreiben)
--Trick: zerlege ein Feld

--Bestelldatum.. QU  KW JAHR
--email   Präfix | mailDomäne..like microsoft.com

--bequem

--where f(datum)--

--alle im Rentenalter: 65
declare @var 
select * from employees
	--where year(getdate)-year(birthdate) >65
	--where datediff(yy, getdate(), birthdate) > 65

	where birthdate < dateadd(yy,-65,getdate()) --Alternaitv @var

--Abfrage where orderid = 10249  @id
--ab Join keine Param.


--Tabelle werden immer größer... Salamitaktik
--Partitionierung  , part Sicht(update, inserts)--> PK, ID
--kleinen Teil, mittleren , Archiv
--













dbcc showcontig('orders')








100--101--205--509--104
select * into ##t1 from orders