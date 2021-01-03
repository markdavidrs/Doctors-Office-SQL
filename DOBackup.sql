Use DocOffice

-- Backup for Person Table
If OBJECT_ID('Person_Backup') IS NOT NULL
	Drop Table Person_Backup

Select * 
Into Person_Backup
From Person

-- Backup for Doctor Table
If OBJECT_ID('Doctor_Backup') IS NOT NULL
	Drop Table Doctor_Backup

Select *
Into Doctor_Backup
From Doctor

-- Backup for Patient Table
If OBJECT_ID('Patient_Backup') IS NOT NULL
	Drop Table Patient_Backup

Select *
Into Patient_Backup 
From Doctor

-- Backup For PatientVisit Table
If OBJECT_ID('PatientVisit_BAckup') IS NOT NULL
	Drop Table PatientVisit_Backup

Select *
Into PatientVisit_Backup
From PatientVisit

-- Backup Test Table
If OBJECT_ID('Test_Backup') IS NOT NULL
	Drop Table Test_Backup

Select *
Into Test_Backup
From Test

-- Backup PVisitTest Table
If OBJECT_ID('PVisitTest_Backup') IS NOT NULL
	Drop Table PVisitTest_Backup

Select *
Into PVisitTest_Backup
From PVisitTest

-- Backup Prescription Table
If OBJECT_ID('Prescription_Backup') IS NOT NULL
	Drop Table Prescription_Backup

Select *
Into Prescription_Backup
From Prescription

-- Backup PVisitPrescription Table
If OBJECT_ID('PVisitPrescription_Backup') IS NOT NULL
	Drop Table PVisitPrescription_Backup

Select *
Into PVisitPrescription_Backup
From PVisitPrescription

-- Backup Speciality Table
If OBJECT_ID('Speciality_Backup') IS NOT NULL
	Drop Table Speciality_Backup

Select *
Into Speciality_Backup
From Speciality

-- Backup DoctorSpeciality Table
If OBJECT_ID('DoctorSpeciality_Backup') IS NOT NULL
	Drop Table DoctorSpeciality_Backup

Select *
Into DoctorSpeciality_Backup
From DoctorSpeciality