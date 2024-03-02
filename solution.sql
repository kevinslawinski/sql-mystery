USE SQLMurderMystery
GO

/* A crime has taken place and the detective needs your help. 
The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a murder that occurred sometime on January 15, 2018 and that it took place in SQL City. 
Start by retrieving the corresponding crime scene report from the police department's database. */

SELECT * FROM CrimeSceneReport 
WHERE Type = 'murder'
AND City = 'SQL City'
AND Date = '2018-01-15'

SELECT TOP 1 Name AS Witness1 FROM Person
WHERE AddressStreetName LIKE '%Northwestern%'
ORDER BY AddressNumber DESC

SELECT TOP 1 Name AS Witness2 FROM Person
WHERE AddressStreetName LIKE '%Franklin%'
AND Name LIKE '%Annabel%'

SELECT p.Name AS Witness, i.Transcript FROM Interview i
INNER JOIN Person p ON p.ID = i.PersonId
WHERE p.Name LIKE '%Morty Schapiro%'
OR p.Name LIKE '%Annabel Miller%'

SELECT p.Name AS Suspect1 FROM Person p
INNER JOIN GetFitNowMember m ON m.PersonId = p.ID
INNER JOIN DriversLicense d ON d.ID = p.LicenseId
WHERE m.ID LIKE '%48Z%'
AND m.MembershipStatus = 'gold'
AND d.PlateNumber LIKE '%H42W%'

SELECT m.PersonId, p.Name, c.MembershipId, c.CheckInDate FROM PERSON p
JOIN GetFitNowMember m ON m.PersonId = p.ID
JOIN GetFitNowCheckIn c	ON c.MembershipId = m.ID
where CheckInDate like '%01-09'

INSERT INTO Solution VALUES (1, 'Jeremy Bowers')
SELECT Value as Result FROM Solution

SELECT P.Name AS Interviewee, Transcript FROM Interview i
JOIN Person p ON p.ID = i.PersonId
WHERE p.Name = 'Jeremy Bowers'

SELECT DISTINCT p.Name AS Suspect2 FROM Person p
JOIN Income i ON i.SSN = p.SSN
JOIN DriversLicense d ON d.ID = p.LicenseId
JOIN FacebookEventCheckIn f ON f.PersonId = p.ID
WHERE d.HairColor = 'red'
AND d.CarMake = 'tesla'
AND d.CarModel = 'model S'
AND d.Height BETWEEN 65 AND 67
AND d.Gender = 'female'
AND f.EventName like '%Symphony%'
AND DatePart (yy, f.Date) = 2017
AND DatePart (mm, f.Date) = 12

INSERT INTO Solution VALUES (1, 'Miranda Priestly')
SELECT Value as Result FROM Solution