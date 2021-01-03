Use [MASTER]

-- Check to see if database already exists
If DB_ID('DocOffice') is not null
	Drop Database DocOffice;

-- Database Creation
Create Database DocOffice
go
Use DocOffice
go
Create Table Person(
	PersonID int Primary Key,
	FirstName varchar(30),
	LastName varchar(30),
	StreetAddress varchar(40),
	City varchar(20),
	State varchar(20),
	Zip int,
	PhoneNumber BIGINT,
	SSN BIGINT,
)

go
Create Table Doctor(
	DoctorID varchar(10) Primary Key,
	MedicalDegrees varchar(40),
	PersonID int Foreign Key References Person(PersonID),
)

go
Create Table Patient(
	PatientID INT  NOT NULL IDENTITY(1,1) Primary Key,
	SecPhoneNumber BIGINT,
	DOB date,
	PersonID int Foreign Key References Person(PersonID),
)

go
Create Table PatientVisit(
	VisitID int Primary Key,
	PatientID int Foreign Key References Patient(PatientID),
	DoctorID varchar(10) Foreign Key References Doctor(DoctorID),
	VisitDate date,
	DocNote varchar(300)
)

go
Create Table Test(
	TestID int Primary Key,
	TestName Varchar(30)
)

go
Create Table PVisitTest(
	VisitID int Foreign Key References PatientVisit(VisitID),
	TestID int Foreign Key References Test(TestID)
)

go
Create Table Prescription(
	PrescriptionID int Primary Key,
	PrescriptionName varchar(40)
)

go
Create Table PVisitPrescription(
	VisitID int Foreign Key References PatientVisit(VisitID),
	PrescriptionID int Foreign Key References Prescription(PrescriptionID)
)

go
Create Table Speciality(
	SpecialityID int Primary Key,
	SpecialityName varchar(40),
)

go
Create Table DoctorSpeciality(
	DoctorID varchar(10) Foreign Key References Doctor(DoctorID),
	SpecialityID int Foreign Key References Speciality(SpecialityID)
)


-- Populating the tables for testing

-- Persons
Insert Into Person Values(1, 'Bob', 'Dylan', '911 T St.', 'Tacoma', 'Washington', 98402, 9399223456, 201044206)
Insert Into Person Values(2, 'Terrance', 'Ross', '914 T St.', 'Tacoma', 'Washington', 98402, 2329523456, 701054206)
Insert Into Person Values(3, 'Hue', 'Jackson', '849 L St.', 'Bellingham', 'Washington', 84972, 3495028231, 489028457)
Insert Into Person Values(4, 'Liza', 'Rodman', '534 T St.', 'Tacoma', 'Washington', 98403, 2194048231, 1590584567)

-- Doctors
Insert Into Person Values(5, 'Ron', 'Gates', '900 E St.', 'Tacoma', 'Washington', 98402, 9498224563, 421051204)
Insert Into Person Values(6, 'Bill', 'Gates', '723 W St.', 'Tacoma', 'Washington', 98402, 9787636758, 805938666)
Insert Into Person Values(7, 'Ron', 'Gater', '483 N St.', 'Seattle', 'Washington', 98105, 8493458692, 764918374)

-- Doctor Tables
Insert Into Doctor Values('RG1', 'D.M.D', 5)
Insert Into Doctor Values('BG1', 'D.M.D', 6)
Insert Into Doctor Values('RG2', 'D.M.D', 7)

-- Patient Tables
INSERT Into Patient (SecPhoneNumber, DOB, PersonID)
VALUES (2065553333, '1980-10-09', 1), (2065553334, '1980-10-19', 2), (2099995867, '1978-01-31', 3), (2489059384, '1995-04-25', 4)

-- PatientVisit Tables
INSERT Into PatientVisit Values(1, 1, 'RG1', '2020-08-01', 'n/a'),
(2, 2, 'RG1', '2020-08-01', 'n/a'), (3, 3, 'BG1', '1998-07-04', 'n/a'),
(4, 4, 'RG2', '05-18-1999', 'n/a'), (5, 2, 'RG1', '2020-08-05', 'return visit')

-- Prescription Table
Insert Into Prescription Values(1, 'Vicodin'), (2, 'Lipitor'), (3, 'Amlodipine')

-- PVistPrescription Table
Insert Into PVisitPrescription Values(1,1), (2,1), (3,2), (4,3), (5,2)

-- Speciality
Insert Into Speciality Values(1, 'ENT'), (2, 'Pediatrics')

-- DoctorSpeciality Table
Insert Into DoctorSpeciality Values ('RG1',1), ('BG1',2)



