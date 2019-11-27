--Indizes

/*
GR IX
NGR IX
CS IX

zusammengestzten IX vs IX mit eingeschl Spalten

zus. IX
alle Spalten sind in jeder Ebene vertreten

where Rngnr=19 and PosNr = 15

IX mit eingeschl. Sp
eingeschl sind nur in der Blattebene (die mit den Zeigern 1:04:03)
select Bezahlt, BDatum from Tabelle where RngNr = 10234

eindeutiger zusamm IX mit eingeschl

Eindeutigkeit

*/


--Ist die Verwendung meiner IX eigtl ok ?
--DMV

select * from sys.dm_db_index_usage_stats
--index_id: 0 HEAP
	--      1 CL IX
	--      >1 NCL IX

--dbcc showcontig('')--42100
select * from sys.dm_db_index_physical_Stats(db_id(),object_id('ku1'),NULL, NULL, 'detailed')--42500



--DS sind in Tabellen.. aber auch in Blöcken und Seiten

--L:S  L> S   S>L  




create table txx (id int, spx int)

insert into txx
select 3,3
GO 100000

select * from txx where spx =2 --Anzahl der DS im geschätzten Plan
insert into txx
select * from txx where id = 2


--Stat werden:  20% Änderungen + 500!

--NCL 1% Tipping Point.. wenn Seek, aber Seek schlecht..  42000  10000000 Seiten

--Große Tabellen sind meist nicht mehr betroffen



--Ganz Böse: 2min...30min
set statistics io, time on
declare @i as int = 1

while @i< 10
	begin
		select * from ku1 where kuid = @i
		set @i = @i+1
	end






















