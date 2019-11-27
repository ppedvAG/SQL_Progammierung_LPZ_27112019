--DBDesign

/*
OLAP-Redundanz
OLTP-Normalisierung NOrmalform (1,2,3,4,5,BC)--> Redundanz vermeiden
	PK   (eindeutigkeit--falsch, Beziehungen PK-FK)
	Beziehung: alles andere ohne PK-FK ist mit Sicherheit schlechter
	PK setzen tut mehr als nur PK setzen...
Generalisierung

Offline



--Je mehr Normalisiert, desto langsamer

select newid()
BIB

Leser
Lid  int identity  ... GUID (Vorteil: Offline, schnell bei Inserts Nachteil. groß)
FamName Nvarchar(50)
Vorname 
PLZ  nvarchar(5) ..oder int
Ort  nv(50)
Str  nv(50)
GebDat date.. datetime(ms).. datetime2 (ns)..smalldatetime (s)


Istr der Datentypo heute eigtl noch so wichtig (genau)


Buch
Bid int
Titel nv(50)
Autor nv(50)
ISBN 

Leihe
Leihid
Lid
Leihdatum

LeihDetails
Ldid
Leihid
Bid



15 23 12.7.2010
15 26 12.7.2010
15 87 12.7.2010



*/

Bestelldatum (datetime)

--Umsatz des Jahres 1997

select * from bestellungen 
	where year(Bestelldatum) =1997 --aber langsam

	where bestelldatum between '1.1.1997' and '31.12.1997 23:59:59.999' --falsch





	--wie groß darf der Wert einer Zelle max werden?... 2GB

	create table t1 (id int identity, spx varchar(4100), sp2 char(4100))

	--weil ein DS normalerweise nicht mehr als 8192bytes.. 8060 werden


	..mdf Datei.. Seiten und Blöcke (Pages Extents)
	--eine Seite 8192bytes(8060) NUtzlast)

	--Seite ist zu 51% voll... --> 1:1 in RAM


use Northwind;
GO

delete from customers where customerid = 'ALFKI'

create database testdb;
GO--Batchdelimiter

use testdb;
GO
create table t1 (id int identity, spx char(4100));


insert into t1
select 'XY'
GO 20000 --17 Sekunden / 15 Sekunden / 


--wie groß: 8060/2 = 4030.. 4100 --> 1 DS pro Seite --> 20000* 8 = 160MB
--> 160MB im RAM.. 160MB in 15 Sekunden..wieso dauert das solange???

select * into t2 from t1 --es geht auch in 1 Sekunde




dbcc showcontig()




NULL Werte .. brauchen Platz


--Faktoren: viele Spalten, Normalisierung (PK), Seiten
--


set statistics io, time on

select * from t1 where id = 10











--DBDesign: "falsche" Datentypen
--> Datenseiten evtl nicht gut ausgelastet
		--8192 bytes davon 8060 Nutzlast
		--dbcc showcontig('Tabelle')

--> pain points: wichtige Tabelle(breite und große Tabellen mit viel Trafic

--Verbesserung
--NULL Werte

--eine breite Tabelle zu machen!!
--viele Spalten bleiben leer.. NULL kostet Platz


--sparse Columns...> 30000 Spalten

create table rezepte
	( id int,
	  Bez int,
	  Zutat varchar(50), Menge 
	  Salz int sparse null,
	  Pfeffer int
	  

--Weg 2: Luft rauslassen
--komprimierung?

--t1 wird komprimiert:--> select länger oder auch weniger... 
---IO sinkt, CPU sinken, Dekomprimieren CPU steigt
--Dauer kann sein unverändert
--Daten kommen beim Client dekomnpirmiert" sein


set statistics io, time on -->

select * from t1--= 234 ms, verstrichene Zeit = 1285 ms. 20000 Seiten
--KOmpression: Seiten oder rows.. 40-60%


--SQL Neustart
--RAM Taskmanager: 295 MB -- 1:1 462 MB 
set statistics io, time on 
select * from testdb..t1
--Seiten:20000  CPU 171   Dauer: 1445ms


--Kompression

--SQL Neustart
--RAM Taskmanager 295 --> danach:fast nix geändert 1:1 in RAM , weniger RAM Verbauch
set statistics io, time on 
select * from testdb..t1
--Seiten:  CPU   Dauer:
--weniger seiten   normalerweise höher  kommt drauf an

--gute Idee für Archivdaten
--aber wie ... ??

--Warum kann man nicht gleich die DB komprimieren?

--Indizes
--> HHD!!!!
--CPU: 























--bei Sparse braucht NULL keinen Platz, aberwnn doch kein NULL, dann mehr als vorher
--mind 60% NULLs, dann evtl rentable
--bit.. 98% NULLs



















