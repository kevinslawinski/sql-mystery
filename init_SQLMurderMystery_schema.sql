-- Create a new database called 'SQLMurderMystery'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'SQLMurderMystery'
)
CREATE DATABASE SQLMurderMystery
GO
-- Switch to the new database for the remainder of the script
USE SQLMurderMystery
GO

CREATE TABLE [CrimeSceneReport] (
	[Date] date NOT NULL,
	[Type] nvarchar(20) NOT NULL,
	[Description] nvarchar(500) NULL,
	[City] nvarchar(30) NOT NULL
)
GO

CREATE TABLE [DriversLicense] (
	[Id] int NOT NULL CONSTRAINT PK_DriversLicense_Id PRIMARY KEY,
	[Age] int NOT NULL,
	[Height] int NOT NULL,
	[EyeColor] nvarchar(15) NOT NULL,
	[HairColor] nvarchar(15) NOT NULL,
	[Gender] nvarchar(15) NOT NULL,
	[PlateNumber] nvarchar(6) NULL,
	[CarMake] nvarchar(20) NULL,
	[CarModel] nvarchar(30) NULL
)
GO

CREATE TABLE [Income] (
	[SSN] varchar(11) NOT NULL CONSTRAINT PK_Income_SSN PRIMARY KEY,
	[AnnualIncome] int NOT NULL
)
GO

CREATE TABLE [Person] (
	[Id] int NOT NULL CONSTRAINT PK_Person_Id PRIMARY KEY,
	[Name] nvarchar(50) NOT NULL,
	[LicenseId] int NULL CONSTRAINT FK_Person_DriversLicense_LicenseId FOREIGN KEY ([LicenseId]) REFERENCES [DriversLicense]([Id]),
	[AddressNumber] int NULL,
	[AddressStreetName] nvarchar(30) NULL,
	[SSN] varchar(11) NULL CONSTRAINT FK_Person_Income_SSN FOREIGN KEY ([SSN]) REFERENCES [Income]([SSN])
)
GO

CREATE TABLE [FacebookEventCheckIn] (
	[PersonId] int NOT NULL CONSTRAINT FK_FacebookEventCheckIn_Person_PersonId FOREIGN KEY ([PersonId]) REFERENCES [Person]([Id]),
	[EventId] int NOT NULL,
	[EventName] nvarchar(100) NULL,
	[Date] date NOT NULL
)
GO

CREATE TABLE [Interview] (
	[PersonId] int NOT NULL CONSTRAINT FK_Interview_Person_PersonId FOREIGN KEY ([PersonId]) REFERENCES [Person]([ID]),
	[Transcript] nvarchar(255) NULL
)
GO

CREATE TABLE [GetFitNowMember] (
	[Id] nvarchar(5) NOT NULL CONSTRAINT PK_GetFitNowMember_Id PRIMARY KEY,
	[PersonId] int NOT NULL CONSTRAINT FK_GetFitNowMember_Person_PersonId FOREIGN KEY ([PersonId]) REFERENCES [Person]([Id]),
	[Name] nvarchar(50) NOT NULL,
	[MembershipStartDate] date NOT NULL,
	[MembershipStatus] nvarchar(15)  NOT NULL
)
GO

CREATE TABLE [GetFitNowCheckIn] (
	[MembershipId] nvarchar(5) NULL CONSTRAINT FK_GetFitNowCheckIn_GetFitNowMember_MembershipId FOREIGN KEY ([MembershipId]) REFERENCES [GetFitNowMember]([Id]),
	[CheckInDate] date NOT NULL,
	[CheckInTime] time NOT NULL,
	[CheckOutTime] time NOT NULL
)
GO

CREATE TABLE [Solution] (
	[User] int NULL,
	[Value] nvarchar(max) NULL
)
GO

CREATE TRIGGER [tr_ValidateSolution]
ON [Solution]
AFTER INSERT
AS
	BEGIN
		-- Clean up any old solution records previously created by the trigger
		DELETE FROM [Solution] WHERE [User] = 0
		-- Check if there is a new record entered by a user
		IF (SELECT [User] FROM [Solution]) = 1
			-- Insert the applicable answer for the user
			INSERT INTO [Solution]
				VALUES (0,
					CASE 
						-- User entered murderer's name
						WHEN (SELECT CAST(CAST((SELECT [Value] FROM [Solution]) AS nvarchar(max)) AS varbinary)) = 0x4A006500720065006D007900200042006F007700650072007300 THEN 'Congrats, you found the murderer! But wait, there''s more... If you think you''re up for a challenge, try querying the interview transcript of the murderer to find the real villian behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.'
						-- User entered mastermind's name
						WHEN (SELECT CAST(CAST((SELECT [Value] FROM [Solution]) AS nvarchar(max)) AS varbinary)) = 0x4D006900720061006E006400610020005000720069006500730074006C00 THEN 'Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!'
						-- User entered wrong person
						ELSE 'That''s not the right person. Try again!'
					END)
			DELETE FROM [Solution] WHERE [User] = 1
	END
GO