select * into blu.demographics from Demographics

--1.Rename all the columns
EXEC sp_rename 'blu.demographics.tri_age', 'Age', 'COLUMN'
EXEC sp_rename 'blu.demographics.gendercode', 'Gender', 'COLUMN'
EXEC sp_rename 'blu.demographics.contactid', 'ID', 'COLUMN'
EXEC sp_rename 'blu.demographics.address1_stateorprovince', 'State', 'COLUMN'
EXEC sp_rename 'blu.demographics.tri_imaginecareenrollmentemailsentdate', 'EmailSentdate', 'COLUMN'
EXEC sp_rename 'blu.demographics.tri_enrollmentcompletedate', 'Completedate', 'COLUMN'
alter table blu.demographics add datedifference nvarchar(100)
update blu.demographics set datedifference = datediff(day, TRY_CONVERT(date, [EmailSentdate]),
TRY_CONVERT(date,[Completedate])) from blu.demographics

--2.Create a new column ¡°Enrollment Status¡±
alter table blu.demographics add EnrollmentStatus nvarchar(100)
update blu.demographics set EnrollmentStatus = 'Complete'
where [tri_imaginecareenrollmentstatus] = 167410011
update blu.demographics set EnrollmentStatus = 'Email Sent'
where [tri_imaginecareenrollmentstatus] = 167410001
update blu.demographics set EnrollmentStatus = 'Non Responder'
where [tri_imaginecareenrollmentstatus] = 167410004
update blu.demographics set EnrollmentStatus = 'Facilitated Enrollment'
where [tri_imaginecareenrollmentstatus] = 167410005
update blu.demographics set EnrollmentStatus = 'Incomplete Enrollments'
where [tri_imaginecareenrollmentstatus] = 167410002
update blu.demographics set EnrollmentStatus = 'Opted Out'
where [tri_imaginecareenrollmentstatus] = 167410003
update blu.demographics set EnrollmentStatus = 'Unprocessed'
where [tri_imaginecareenrollmentstatus] = 167410000
update blu.demographics set EnrollmentStatus = 'Second Email Sent'
where [tri_imaginecareenrollmentstatus] = 167410006

--3.Create a new Column ¡°Sex¡±
alter table blu.demographics add Sex nvarchar(100)
update blu.demographics set Sex = 'female'
where [Gender] = '2'
update blu.demographics set Sex = 'male'
where [Gender] = '1'
update blu.demographics set Sex = 'other'
where [Gender] = '167410000'
update blu.demographics set Sex = 'Unknown'
where [Gender] = 'NULL'

--4.Create a new column ¡°Age group¡± and create age groups with an interval of 25 yrs.
alter table blu.demographics add Agegroup nvarchar(100)
update blu.demographics set Agegroup = '0-25'
where [Age] >= 0 and [Age] <= 25
update blu.demographics set Agegroup = '26-50'
where [Age] >= 26 and [Age] <= 50
update blu.demographics set Agegroup = '51-75'
where [Age] >= 51 and [Age] <= 75
update blu.demographics set Agegroup = '76-100'
where [Age] >= 76 and [Age] <= 100
update blu.demographics set Agegroup = '101-125'
where [Age] >= 101 and [Age] <= 125


SELECT TOP 10 * from blu.demographics
ORDER BY NEWID()

 
