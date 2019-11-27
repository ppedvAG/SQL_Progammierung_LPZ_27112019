use TemporalTables
GO

insert into Contacts 
(Lastname,Firstname,Birthday, Phone, email) 
select 'Kent', 'Clark','3.4.2010', '089-3303003', 'clarkk@krypton.universe' 

insert into Contacts 
(Lastname,Firstname,Birthday, Phone, email) 
select 'Wayne', 'Bruce','3.4.2012', '08677-3303003', 'brucew@gotham.city' 

--Und nun die Änderungen, die zu einer Versionierung der Datensätze führt 
WAITFOR DELAY '00:00:02'
update contacts set email = 'wer@earth.de' where cid = 1 
update contacts set Phone = 'w3434' where cid = 1 
update contacts set Lastname = 'Wayne' where cid = 1 

WAITFOR DELAY '00:00:02'

update contacts set email = 'asas@earth.de' where cid = 1 
update contacts set Phone = 'w34sasaa34' where cid = 2 
update contacts set Lastname = 'Smith' where cid = 1 

--Result
select * from contacts 

delete from contacts where cid = 1
select * from ContactsHistory 


--nach Version suchen

select * from contactshistory 
where 
    Startdatum >= '2019-11-27 15:49:10.6286148' 
    and 
    Enddatum <= '2019-11-27 15:49:12.6286148'  

--Noch besser
select * from contacts 
    FOR SYSTEM_TIME AS OF '2019-11-27 15:49:11.6286148' 
    where cid =1 

	select * from contactshistory where cid = 1 order by enddatum desc
	except
	select cid from contacts

	se
	

	Alter Table contacts
	add spx int


	update contacts set Firstname= 'Chris', spx=2 where cid = 1

	--nope
delete from Contactshistory where StartDatum <= '2016-08-05 12:45:43.2711351'


