select * from [blu].[IC_BP]

--1(a) change BPAlerts to BPStatus
EXEC sp_rename '[blu].[IC_BP].BPAlerts', 'BPStatus', 'COLUMN'

SELECT TOP 10 * from [blu].[IC_BP]
ORDER BY NEWID()


--1(b) change status to different types 
update [blu].[IC_BP] set [BPStatus] = 1
where [BPStatus] = 'Hypo1'
update [blu].[IC_BP] set [BPStatus] = 1
where [BPStatus] = 'Normal'
update [blu].[IC_BP] set [BPStatus] = 0
where [BPStatus] = 'Hypo2'
update [blu].[IC_BP] set [BPStatus] = 0
where [BPStatus] = 'HTN1'
update [blu].[IC_BP] set [BPStatus] = 0
where [BPStatus] = 'HTN2'
update [blu].[IC_BP] set [BPStatus] = 0
where [BPStatus] = 'HTN3'

SELECT TOP 10 * from [blu].[IC_BP]
ORDER BY NEWID()

--1(c)
--select certain columns from [blu].[IC_BP] and [dbo].[Demographics], and inner join them by ID, then make a new data set called blu.megDI
select A.*, B.[tri_enrollmentcompletedate] into [blu].[megDI] from [blu].[IC_BP] A
inner join [dbo].[Demographics] B
on A.ID=B.contactid

SELECT TOP 10 * from [blu].[megDI]
ORDER BY NEWID()

select * from [blu].[megDI]

--1(d)
--create a new column called weekdiff
alter table [blu].[megDI] add weekdiff nvarchar(100)
--use datediff function to calcute number of weeks between tri_enrollmentcompletedate and ObservedTime
update [blu].[megDI] set weekdiff = datediff(WEEK,TRY_CONVERT(DATETIME2,tri_enrollmentcompletedate),ObservedTime)

--select weekdiff >= 0 and weekdiff <=12
select * into [blu].[weekdiff] from [blu].[megDI]
where weekdiff >= 0 and weekdiff <=12
order by ID, ObservedTime

select * from [blu].[weekdiff]

--create a new column which is the integer value for BPStatus
alter table [blu].[weekdiff] add bpst float
update [blu].[weekdiff] set bpst=BPStatus

--calcute BP average for each patient, then group by and sort by ID 
select ID, weekdiff, cast(avg(bpst) as decimal(10,1)) as BPavg into [blu].[bpavg] from [blu].[weekdiff]
group by ID,weekdiff
order by ID,weekdiff

select * from [blu].[bpavg]

SELECT TOP 10 * from [blu].[bpavg]
ORDER BY NEWID()

--1(e)
--select baseline and 12 week
select ID,weekdiff,BPavg from [blu].[bpavg]
where weekdiff = 0 or weekdiff = 12

select count(weekdiff) from [blu].[bpavg]
where [weekdiff] = 0

select count(weekdiff) from [blu].[bpavg]
where [weekdiff] = 12

SELECT TOP 10 * from [blu].[bpavg]
ORDER BY NEWID()

--1(f)
--select baseline and BP status = 0
select ID,[BPStatus] into [blu].[f1] from [blu].[weekdiff] where [weekdiff]=0 and BPStatus=0
--select 12 weeks and BP status = 1
select ID,[BPStatus] into [blu].[f2] from [blu].[weekdiff] where [weekdiff]=12 and BPStatus=1
--match the ID for the two selected datasetes
select [blu].[f1].* into [blu].[f3] from [blu].[f1]  
inner join [blu].[f2]
on [blu].[f1].ID=[blu].[f2].ID

select distinct ID from [blu].[f3]

SELECT TOP 10 * from [blu].[f3]
ORDER BY NEWID()
--2
--inner join all datasets that we need into blu.final
select A.*,B.*,C.* into [blu].[final] from [dbo].[ChronicConditions] A
inner join [dbo].[Text] B
on A.tri_patientid=B.tri_contactId
inner join [dbo].[Demographics] C
on A.tri_patientid=C.contactid

select * from  [blu].[final]

--drop tri_patientid and tri_contactId for depulicating
alter table [blu].[final] drop column tri_patientid
alter table [blu].[final] drop column tri_contactId

--creat data set d by selecting the latest date and group by id 
select tri_patientid, max(TextSentDate) 
as TextSentLatestDate into [blu].[d] from [blu].[final] 
group by tri_patientid

select * from [blu].[d]

--merge the final data set and d and on TextSentDate, TextSentLatestDate and contactid, tri_patientid
select A.*,B.* from [blu].[final] A
inner join [blu].[d] B 
on A.TextSentDate=B.TextSentLatestDate and
A.contactid=B.tri_patientid

SELECT TOP 10 * from [blu].[final]
ORDER BY NEWID()

