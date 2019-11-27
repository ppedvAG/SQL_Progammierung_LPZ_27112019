create database testdb2

--Stdgrˆﬂen:
--2012/2014		: 5MB Daten und 2 MB Logfile  Wachstum 1 MB  / 10% Logfile
--2016/2017/2019: 8/8MB  Wachstum 64 MB


--ideal w‰re: keinerlei Wachstum..: 100GB (Log:25%.. Backup Log)

--2014: 5MB--> 10GB aus Oracle..1MB jeweils (1MB 0en)
--10000mal

--besser wenn es schon 10GB h‰tte

--DB Dateien so groﬂ ansetzten wie man in ca 3 Jahren erwartet
--Datentr‰gervolumewartungstask aktivieren??
--keine 0 mehr geschrieben werden

--Backup: 100GB DB 1 GB Daten.. es werden nur Daten gesichert

--Trenne Log von Daten

