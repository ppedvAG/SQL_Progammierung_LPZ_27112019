--temp Tabellen

/* sind in Tempdb

#t  lokale temp Tabelle
	Lebensdauer: bis sie gel�scht wird oder Verbindung gekillt wird
	G�ltigkeitsbereich: nur in der Erstellerverb


##t globale temp Tabelle
	Lebensdauer: bis sie gel�scht wird, Verb gekillt..
	G�ltigkeit: auch in anderen Verbindungen, lfd Abfragen werden nicht unterbrochen


--Einsatz: Zwischenergebnis, schnell, statt Codewurscht lieber einz Schritte
		   Wiederverwenden

--wenn mehr als 1000  
--�nderbar, Indizes
--falls l�nger verwendbar: perm. Tabelle


*/

select * into #t from orders

select * from #t


select  Kont, country,Region,city,count(*)as Anzahl from ku1 group by country, city with rollup

select count(*)as Anzahl, country,city from ku1 group by country, city with cube--

select * from #tanal

create proc #proc --auch temp Prozeduren.. 