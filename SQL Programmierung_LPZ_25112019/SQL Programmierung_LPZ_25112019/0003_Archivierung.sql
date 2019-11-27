--DB Design


--A 10000  B 100000
-- 10 gleich oder schneller         3 B


--A 10000  B 1000000000000000000000000
--A --

--Idee: kleine sind schneller, dann machen wir halt die Tabellen kleiner?

--Idee1:
--Daten auslagern!
--App frägt nach Umsatztabelle

--Sicht umfasst alle Tabellen 

--statt Umsatztabelle, viele kleine
create table u2019 (id int identity, jahr int, spx int)
create table u2018 (id int identity, jahr int, spx int)
create table u2017 (id int identity, jahr int, spx int)
create table u2016 (id int identity, jahr int, spx int)


select * from umsatz


create view umsatz --suche nicht nach doppelten
as
select * from u2019
UNION ALL
select * from u2018
UNION ALL
select * from u2017
UNION ALL
select * from u2016


ALTER TABLE dbo.u2017 ADD CONSTRAINT
	CK_u2017 CHECK (jahr=2017)

ALTER TABLE dbo.u2018 ADD CONSTRAINT
	CK_u2018 CHECK (jahr=2018)

ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)

ALTER TABLE dbo.u2016 ADD CONSTRAINT
	CK_u2016 CHECK (jahr=2016)

select * from umsatz where jahr = 2019

--Cool für Abfragen.. sollten schneller sein..



--kann man in Sichten INS UP DEL machen?
--ja und nein

--hier gehts theortisch

insert into umsatz (id,jahr, spx) values (next value for sequid,2017,100)
--Error wg PK in 2019 Tabelle

--Idee.. für einen fortlaufenden ID Wert
select * from umsatz


select next value for sequid




--Dafür gibts aber ein bessere Lösung
--
--PARTITIONIERUNG


--hdd

--Weg für optimales SQL:
--Plan: Plan kann auch mal lügen .. sieht gut oder schlecht aus
	--where ... SEEK, SCAN 
		--SEEK herauspicken
		--SCAN: A bis Z

--Messungen: set statistics .. die Zahlen alleine sagen mir nix
----Alternativzahlen


--DBDesign...je mehr Norm desto mehr joins
--OLAP...: Vorausberechnung

with cube

use northwind

select country, city, count(*) from customers group by country, city with rollup
order by 1,2,3
select country, city, count(*) from customers group by country, city with cube
order by 1,2,3


--Seiten und Blöcke

--DBDesign... Sparse... Datentyp
--Seitenauslastung statt 80%   95%


--Kompression.. kein DB Redesign


--historische archivieren--> trotzdem muss select von Umsatz funktionieren... part Sicht
--INS UP DEL: PK kein Identity



--Partitionierung:


--Dateigruppen?


--- G: (RAID 10)
-- Tabellen mit Stammdaten auf Lw G und Umsätze auf Lw H

create table kunden (id int) on STAMM
--Dgruppe = d:\SQLDBS\stammdaten.ndf  (STAMM)

--bwin: 1 Tabelle auf 1000DGruppen = 1000 HDDS



--Tabelle gesplittet

-------------------100-----------------------------200-----------------------------
--     1                              2                                3


--Partitionierungsfunktion f(117) --> 2


--Partf()
--Part Scheme
--mehrere Dgruppen


create partition function fZahl(int) 
as 
RANGE LEFT FOR VALUES (100,200)-- 3 Bereiche


select $partition.fzahl(117) --> 2



create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest) --Dateigruppennamen müssen existieren
---------               1    2     3


create table ptab (id int identity, nummer int, spx char(4100))--so liegt sie auf Primary

--auf Part Scheme legen
create table ptab (id int identity, nummer int, spx char(4100)) on schZahl(nummer)


--APEX...0 Euro

declare @i as int = 1

while @i <= 20000
	begin
		insert into ptab(nummer, spx) values (@i,'XY')
		set @i+=1
	end

--Batches sind teuer

set statistics io, time on
select * from ptab where id = 17

select * from ptab where nummer = 17--bsi zu 15000 Teile schustern

--flexibel


--neue Grenzen reintun: bis5000

----------100]------------200]------------------------------5000]--------------------------
--    1              2                             3                           4


--Tabelle, f(), scheme
--F(), scheme, nix mit Tabelle

--scheme, f()

alter partition scheme schZahl next used bis5000 --, gilt erst wenn f() einen 4 meldet



select $partition.fzahl(nummer), min(nummer), max(nummer), count(*) from ptab
group by $partition.fzahl(nummer)

alter partition function fZahl() split range (5000)

select * from ptab where id = 1117

--Grenze entfernen
--Tabelle, f(), scheme
--nur f()

ALTER PARTITION function fzahl() merge range(100)


CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [Rest])
GO

CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO


--Archivierung
--wie kann man Datensätze aus einer Tabelle in eine andere verschieben: kein Move

create table Archiv (id int not null, nummer int, spx char(4100)) on bis200

----------------------------------------------------
Txxxxxxxxxxxxxxxxx          
----------------------------------------------------

--Archivtabelle muss aufr der selben DGr sein wie die zu arch Partition
alter table ptab switch partition 1 to archiv

select * from archiv

select * from ptab

--100MB /SEK .. Part1 1000000000000 MB.. ?--> ca 0









--A bis G     H bis R   S bis Z
create partition function fZahl(varchar(50)) 
as 
RANGE LEFT FOR VALUES ('H','S')

---100---200---

create partition function fZahl(datetime) 
as 
RANGE LEFT FOR VALUES ('31.12.2017','','')










CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([PRIMARY], [PRIMARY], [PRIMARY])
GO

--besser

--T 10     T2 20Mrd
-- |XXXXXX   XXXXXX   XXXXXX| 15000


--Löschen der Tabelle
















