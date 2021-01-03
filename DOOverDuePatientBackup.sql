/*Creating a backup for all patients and the contact
address who have not seen any doctor in the last year*/

Use DocOffice

If OBJECT_ID('PatientOverdue_Backup') IS NOT NULL
	Drop Table PatientOverdue_Backup

Select *
Into PatientOverdue_Backup
From Patient
Where PatientID in (
	Select PatientID
	From PatientVisit
	Where (DATEPART(YY,GETDATE()) - DATEPART(YY, VisitDate)) > 1
	)

-- Test
Select *
From PatientOverdue_Backup