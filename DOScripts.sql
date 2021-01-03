-- Script for creating functions, storedprocedures, and views of the DocOffice database
Use DocOffice

/*
Create a function that takes a doctors first name and last name,
and returns the names and Phone numbers of all of the doctors patients
*/
go
Create Function RetrievePatient(@fn varchar(30), @ln varchar(30))
Returns Table
as
Return
	Select DISTINCT P.FirstName, P.LastName, P.PhoneNumber
	From Person as P 
		 Inner Join Patient as PA on P.PersonID = PA.PersonID
		 Inner Join PatientVisit as PV on PV.PatientID = PA.PatientID
		 Inner Join Doctor as D on D.DoctorID = PV.DoctorID
	Where D.DoctorID in (
		Select D.DoctorID
		From PatientVisit as PV 
		Inner Join Doctor as D on D.DoctorID = PV.DoctorID
		Inner Join Person as P on P.PersonID = D.PersonID
		Where P.FirstName = @fn and P.LastName = @ln
		)

-- Testing the Function
Select *
From dbo.RetrievePatient('Ron','Gates')


/*Create a function which accepts a prescription name and returns the First Names,
Last Names of all doctors who gave out that prescription*/
go
Create Function Prescriber(@name varchar(40))
Returns Table
As
Return
	Select Distinct P.FirstName, P.LastName
	From Person as P
		Inner Join Doctor as D on D.PersonID = P.PersonID
		Inner Join PatientVisit as PV on PV.DoctorID = D.DoctorID
		Inner Join PVisitPrescription as PVP on PVP.VisitID = PV.VisitID
		Inner Join Prescription as PM on PM.PrescriptionID = PVP.PrescriptionID
	Where PM.PrescriptionName = @name

-- Testing This Function

Select *
From dbo.Prescriber('Lipitor')


 /*Create a view which Shows the First Name and Last name
   of all doctors and their specialty’s*/
go
Create View vSpecialty
as
Select P.FirstName, P.LastName, S.SpecialityName
From 
Doctor as D Inner Join Person as P on D.PersonID = P.PersonID
Inner Join DoctorSpeciality as DS on DS.DoctorID = D.DoctorID
Inner Join Speciality as S on S.SpecialityID = DS.SpecialityID

-- Testing the view
Select *
From vSpecialty

/*Modify the view created in Q4 to show the First Name and Last name of all
doctors and theirspecialties ALSO include doctors who DO NOT have any specialty*/
go
Create View vInclusiveSpecialty
as
Select P.FirstName, P.LastName, S.SpecialityName
From 
Doctor as D Inner Join Person as P on D.PersonID = P.PersonID
Left Outer Join DoctorSpeciality as DS on DS.DoctorID = D.DoctorID
Left Outer Join Speciality as S on S.SpecialityID = DS.SpecialityID

-- Testing the altered view
Select *
From vInclusiveSpecialty

/*Create a stored procedure that gives Prescription name and the number
patients from city of Tacoma with that prescription.*/
go
Create PROC spPrescNum
@name varchar(40),
@pname varchar(40) output,
@count int output
As
Select @pname = PP.PrescriptionName, @count = Count(P.PersonID)
From Person as P
Inner Join Patient as PT on P.PersonID = PT.PersonID
Inner Join PatientVisit as PV on PV.PatientID = PT.PatientID
Inner Join PVisitPrescription as PVP on PVP.VisitID = PV.VisitID
Inner Join Prescription as PP on PP.PrescriptionID = PVP.PrescriptionID
Where P.City = 'Tacoma'
Group By PP.PrescriptionName
Having PP.PrescriptionName = @name

-- Executing the stored procedure we just created
-- Inputing Vicodin as the Prescription Name
Declare @oname varchar(40)
Declare @pcount int
EXEC spPrescNum @name = 'Lipitor', @pname = @oname OUTPUT, @count = @pcount OUTPUT
Print '| ' + CAST(@pcount as varchar(20)) + ' | ' + @oname + ' |'

/* Create trigger on the DoctorSpeciality so that every time a doctor specialty is
updated or added, a new entry is made in the audit table. The audit table will have 
the following (Hint-The trigger willbe on DoctorSpecialty table)
*/

-- Creating Audit Table
/*I left out the action column because I wasn't sure how to do it as it wasn't covered
in any lectures this quarter and google searches weren't even giving me any direction.
*/

If OBJECT_ID('DoctorSpecialityAudit') IS NOT NULL
	Drop Table DoctorSpecialityAudit

go
Create Table  DoctorSpecialityAudit(
				Fname varchar(30),
				Speciality varchar(30),
				ModificationD date)

Drop Trigger SpecialityChanges

go
Create Trigger SpecialityChanges
ON DoctorSpeciality
FOR INSERT, UPDATE
AS
Begin
Declare @name varchar(30)
Declare @s varchar(30)
Declare @d date
Select @name = P.FirstName, @s = S.SpecialityName, @d = GETDATE()
From Doctor as D 
Inner Join Person as P on D.PersonID = P.PersonID
Inner Join DoctorSpeciality as DS on DS.DoctorID = D.DoctorID
Inner Join Speciality as S on S.SpecialityID = DS.SpecialityID
Insert Into DoctorSpecialityAudit Values(@name, @s, @d)
End

-- Testing Insert
Insert into DoctorSpeciality Values('RG1', 2)

-- Testing Update
Select *
From DoctorSpeciality

Update DoctorSpeciality
Set SpecialityID = 1
Where DoctorID = 'RG1'


Select *
From DoctorSpecialityAudit