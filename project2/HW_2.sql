
-- Creating my version of the Call PhoneCall table

select * into jlima.phonecall from PhoneCall

select * from jlima.phonecall

-- Creating a new column called "Enrollment Group"

alter table jlima.phonecall add "Enrollment Group" nvarchar (35)

-- Updating coded values on the new column:

update jlima.phonecall set [Enrollment Group] = 'Clinical Alert'
where EncounterCode = 125060000

update jlima.phonecall set [Enrollment Group] = 'Health Coaching'
where EncounterCode = 125060001

update jlima.phonecall set [Enrollment Group] = 'Technical Question'
where EncounterCode = 125060002

update jlima.phonecall set [Enrollment Group] = 'Administrative' 
where EncounterCode = 125060003

update jlima.phonecall set [Enrollment Group] = 'Other'
where EncounterCode = 125060004

update jlima.phonecall set [Enrollment Group] = 'Lack of Engagement'
where EncounterCode = 125060005

select count ([Enrollment Group]) [Clinical Alert] from jlima.phonecall
where EncounterCode = 125060000

select count ([Enrollment Group]) [Health Coaching] from jlima.phonecall
where EncounterCode = 125060001

select count ([Enrollment Group]) [Technical Question] from jlima.phonecall
where EncounterCode = 125060002

select count ([Enrollment Group]) Administrative from jlima.phonecall
where EncounterCode = 125060003

select count([Enrollment Group]) Other from jlima.phonecall
where EncounterCode = 125060004

select count ([Enrollment Group]) [Lack of Engagement] from jlima.phonecall
where EncounterCode = 125060005


-- select column , count of column  grouped by enrolment group


-- Creating my version of the Call Duration table

select * into jlima.CallDuration from CallDuration

select * from jlima.CallDuration
select * from jlima.phonecall

-- Merging the Phone call encounter table with Call duration table as making a new table

select * into jlima.merged_phone_duration from jlima.phonecall Inner Join jlima.CallDuration
on jlima.phonecall.CustomerId = jlima.CallDuration.tri_CustomerIDEntityReference

select * from jlima.merged_phone_duration

-- creating a new column and codification for CallType  

alter table jlima.merged_phone_duration add Call_Type_Code nvarchar (35)
update jlima.merged_phone_duration set Call_Type_Code = 'Inbound'
where CallType = 1
update jlima.merged_phone_duration set Call_Type_Code = 'Outbound'
where CallType = 2

-- creating a new column and codification for CallOutcome

alter table jlima.merged_phone_duration add Call_Outcome_Code nvarchar (35)

update jlima.merged_phone_duration set Call_Outcome_Code = 'No response'
where CallType = 1
update jlima.merged_phone_duration set Call_Outcome_Code = 'Left voice mail'
where CallType = 2
update jlima.merged_phone_duration set Call_Outcome_Code = 'Successful'
where CallType = 3

-- finding the number of records for each call outcomes and call type:

select count (Call_Type_Code) Inbound from jlima.merged_phone_duration
where Call_Type_Code = 'Inbound'

select count (Call_Type_Code) Outbound from jlima.merged_phone_duration
where Call_Type_Code = 'Outbound'

select count (Call_Outcome_Code) [No response] from jlima.merged_phone_duration
where Call_Outcome_Code = 'No response'

select count (Call_Outcome_Code) [Left voice mail] from jlima.merged_phone_duration
where Call_Outcome_Code = 'Left voice mail'

select count (Call_Outcome_Code) Successful from jlima.merged_phone_duration
where Call_Outcome_Code = 'Successful'

-- Finding the duration of each of the enrollment groups

select * from [jlima].[merged_phone_duration]

select sum (CallDuration) from jlima.merged_phone_duration
where [Enrollment Group] = 'Clinical Alert'

select sum (CallDuration) from jlima.merged_phone_duration
where [Enrollment Group] = 'Health Coaching'

select sum (CallDuration) from jlima.merged_phone_duration
where [Enrollment Group] = 'Technical Question'

select sum (CallDuration) from jlima.merged_phone_duration
where [Enrollment Group] = 'Administrative'

select sum (CallDuration) from jlima.merged_phone_duration
where [Enrollment Group] = 'Other'

select sum (CallDuration) from jlima.merged_phone_duration
where [Enrollment Group] = 'Lack of Engagement'

-- Merging the tables Demographics, Chronic Conditions and TextMessages

select * from [dbo].[Demographics]
select * from [dbo].[ChronicConditions]
select * from [dbo].[Text]



/* how to merge 3 or more tables: SELECT * FROM table1 join table2 ON table1.primarykey = table2.foreignkey
                                  join table3 ON table2.primarykey = table3.foreignkey */


select * into jlima.Text_Chronic_Demog from Demographics Inner Join ChronicConditions
on [contactid] = [tri_patientid] join Text on [tri_patientid] = [tri_contactId]

select * from jlima.Text_Chronic_Demog

alter table [jlima].[Text_Chronic_Demog] add WeekNumber nvarchar (10)
update [jlima].[Text_Chronic_Demog] set WeekNumber = datepart (wk, [TextSentDate])

-- Finding the number of the texts/per week, by the type of sender:
 
select SenderName, datepart(week,[TextSentDate])[Week], count (WeekNumber)[Nr_of_Messages] from [jlima].[Text_Chronic_Demog]
group by SenderName, datepart(week,[TextSentDate])
order by SenderName, datepart(week,[TextSentDate])

-- Count of texts based on the chronic condition per week:
select tri_name, datepart(week,[TextSentDate])[Week], count (WeekNumber)[Nr_of_Messages] from [jlima].[Text_Chronic_Demog]
group by tri_name, datepart(week,[TextSentDate])
order by tri_name, datepart(week,[TextSentDate])


/*select year([TextSentDate])[Year],datepart(week,[TextSentDate])[Week],count([WeekNumber]) [Number_of_Messages]
from [jlima].[Text_Chronic_Demog]
group by year([TextSentDate]),datepart(week,[TextSentDate])
order by year, week*/
