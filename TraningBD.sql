CREATE DATABASE TraningBD
USE TraningBD

--Modify DATABASE Name
ALTER DATABASE TraningBD  MODIFY NAME = Traning_Course

EXEC sys.sp_renamedb  'Traning_Course ', 'TraningBD'

DROP DATABASE TraningBD

---Single User Mode
ALTER DATABASE TraningBD SET SINGLE_USER WITH ROLLBACK IMMEDIATE

-- ReBack Single User Mode
ALTER DATABASE  TraningBD SET MULTI_USER

--create table.......

CREATE TABLE TblGender
(
Id INT PRIMARY KEY,
GenderName VARCHAR(30)
)

CREATE TABLE TblPerson
(
Id INT PRIMARY KEY ,
Name VARCHAR(100),
Email VARCHAR(100),
Gender INT ,
)
   
DROP TABLE dbo.TblPerson

---Foreign Key Add....
ALTER TABLE dbo.TblPerson
ADD CONSTRAINT TblPerson_Gender_PK FOREIGN KEY (Gender) REFERENCES dbo.TblGender(Id)

--Cascading .........

ALTER TABLE dbo.TblPerson
ADD CONSTRAINT tblperson_pk FOREIGN KEY(Gender) REFERENCES dbo.TblGender(Id)
ON UPDATE SET NULL ON DELETE SET NULL

---------
ALTER TABLE dbo.TblPerson
ADD CONSTRAINT fk_tblperson FOREIGN KEY(Gender) REFERENCES dbo.TblGender(Id)
ON DELETE CASCADE ON UPDATE CASCADE


----CHECK CONSTRAINT ..........

CREATE TABLE Constraintbl
(
id INT PRIMARY KEY,
Name VARCHAR(25),
age INT
)

ALTER TABLE dbo.Constraintbl
ADD CONSTRAINT pk_constrain CHECK(age>0 AND age <150)

---Drop Constraint......

ALTER TABLE dbo.Constraintbl
DROP CONSTRAINT pk_constrain

-----Identity -------

CREATE TABLE TraningBD
(
Id INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(25),
Address VARCHAR(25),
Email VARCHAR(25),
Phone int
)

  SELECT SCOPE_IDENTITY()
  SELECT @@IDENTITY
  SELECT IDENT_CURRENT('Retrieve')

 ---- Scop_Identity...........

CREATE TABLE TblPerson1
(
personId INT IDENTITY(1,1) PRIMARY KEY,
personName VARCHAR(100)
)
GO

CREATE TABLE tblPerson2
(
PersonId INT IDENTITY(101,1) PRIMARY KEY,
PersonName VARCHAR(25)
)

CREATE TRIGGER trgtblperson
ON TblPerson1 FOR INSERT
AS
INSERT INTO tblPerson2 VALUES ('shohan')
GO

INSERT INTO TblPerson1 VALUES('Kalam');
SELECT SCOPE_IDENTITY()

SELECT * FROM dbo.TblPerson1
SELECT * FROM dbo.tblPerson2
-------------------------------------------------

---Unique Key..........

CREATE TABLE uniq_key
(
Id INT IDENTITY(1,1) PRIMARY KEY,
 Name VARCHAR(20),
 Phone INT UNIQUE,
)

INSERT INTO uniq_key VALUES ('Hasan',01876473517);
----------------------

--Select Statement..............

SELECT * FROM tblgender

SELECT Name,Gender  FROM tblperson
----------------------------------------

-----GROUP BY Statment..............

---SUM, DIV,MUL, AGGREGATE FUNCITON

CREATE TABLE Group_by
(
Id INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(20),
Salary INT,
City VARCHAR(20)

)


SELECT city,  SUM(Salary) AS TotalSalary , COUNT(Salary) AS TotalCount  FROM dbo.Group_by
GROUP BY city
--------------------

---Having Cluse............

SELECT city,  SUM(Salary) AS TotalSalary , COUNT(Salary) AS TotalCount  FROM dbo.Group_by
GROUP BY city
HAVING SUM(Salary) >5000
--------------------------------------

---------JOIN TABLES..............

CREATE TABLE Student_detail
(
Roll INT ,
Name VARCHAR(20),
Institute VARCHAR(20),
Address VARCHAR(20),

)

INSERT INTO dbo.Student_detail VALUES (101,'joherulhoq','icst','Feni')
INSERT INTO dbo.Student_detail VALUES (102,'rubel','icst','Feni')
INSERT INTO dbo.Student_detail VALUES (103,'hasan','icst','Feni')
INSERT INTO dbo.Student_detail VALUES (104,'joherul','icst','Feni')

CREATE TABLE Student_attendance
(
Roll INT,
Attendance INT,
date DATE,
)

INSERT INTO dbo.Student_attendance
        ( Roll, Attendance, date )
VALUES  ( 105, -- Roll - int
          40, -- Attendance - int
          GETDATE()  -- date - date
          )



---------INNER JOIN

SELECT * FROM dbo.Student_detail
SELECT * FROM dbo.Student_attendance

SELECT dbo.Student_detail. Roll, Name,Institute, Address,Attendance 
FROM dbo.Student_detail INNER JOIN dbo.Student_attendance
ON dbo.Student_detail.Roll = dbo.Student_attendance.Roll

-------------LEFT JOIN

SELECT dbo.Student_detail. Roll, Name,Institute, Address,Attendance 
FROM dbo.Student_detail left JOIN dbo.Student_attendance
ON dbo.Student_detail.Roll = dbo.Student_attendance.Roll

--------- Right JOIN
SELECT dbo.Student_detail. Roll, Name,Institute, Address,Attendance 
FROM dbo.Student_detail Right JOIN dbo.Student_attendance
ON dbo.Student_detail.Roll = dbo.Student_attendance.Roll

----------Full JOIN
SELECT dbo.Student_detail. Roll, dbo.Student_attendance.Roll, Name,Institute, Address,Attendance 
FROM dbo.Student_detail FULL JOIN dbo.Student_attendance
ON dbo.Student_detail.Roll = dbo.Student_attendance.Roll


---Multiple Joining------------


CREATE TABLE District
(
DistId INT IDENTITY PRIMARY KEY,
DistName VARCHAR(20)
)

CREATE TABLE SubDistrict
(
SubDistId INT IDENTITY PRIMARY KEY,
SubDistName VARCHAR(25),
DistId INT
)

CREATE TABLE UnionWord
(
Uwid INT IDENTITY PRIMARY KEY ,
UwName VARCHAR(25),
SubDistId INT
)

---Multiple Joining------------


SELECT DistName,SubDistName,UwName FROM dbo.District D INNER JOIN dbo.SubDistrict sd
ON D.DistId=sd.SubDistId INNER JOIN dbo.UnionWord Un
ON sd.DistId=Un.Uwid


----Self Join-------------

CREATE TABLE Employee
(
Id INT IDENTITY (1,1) PRIMARY KEY,
Name VARCHAR(25),
ManagerID INT ,

)

INSERT INTO dbo.Employee  VALUES ('hasan',2)
INSERT INTO dbo.Employee  VALUES ('Rubel',3)
INSERT INTO dbo.Employee  VALUES ('Shohan',5)
INSERT INTO dbo.Employee  VALUES ('Shuvo',5)
INSERT INTO dbo.Employee  VALUES ('Milon',3)
INSERT INTO dbo.Employee  VALUES ('Saheen',1)
INSERT INTO dbo.Employee  VALUES ('parimal',1)
INSERT INTO dbo.Employee  VALUES ('pulak',4)
INSERT INTO dbo.Employee  VALUES ('ashik',4)


SELECT * FROM  dbo.Employee

SELECT E.id,E.Name EmployeeName,M.Name ManagerName FROM dbo.Employee E INNER JOIN dbo.Employee M
ON E.ManagerID =M.Id 

-----------Union------------

CREATE TABLE union2
(
id INT ,
Name VARCHAR(20)

)

INSERT INTO union2 VALUES (101,'shuvo')
INSERT INTO union2 VALUES (102,'rubel')
INSERT INTO union2 VALUES (103,'shohan')

------Union all-------------

SELECT * FROM dbo.union1
UNION ALL

SELECT * FROM dbo.union2

------UNION -----------Uniq data


SELECT * FROM dbo.union1
UNION 

SELECT * FROM dbo.union2





-------------------------------------------------------------Procedure--------------------
SELECT * FROM dbo.Student_detail


------- Procedure ---------

CREATE PROC information
AS
BEGIN
SELECT * FROM dbo.Student_detail

END


information
exec information
EXECUTE information

------parameter Procedure------

ALTER PROC EmployeeInfo
(
@Roll int,
@Name varchar(20)

)
AS
BEGIN

SELECT Name, Roll, Institute
FROM dbo.Student_detail WHERE Roll=@Roll AND Name=@Name
END

--------Select Query..........
EXECUTE EmployeeInfo 104,'joherul'

-----Declare.......
EXEC EmployeeInfo @Name = 'hasan' , @Roll= 103

-------View to the text store procedure...........

EXEC sp_helptext EmployeeInfo

-------- Alter Procedure or Update Procedure........

ALTER PROC EmployeeInfo

@Roll int,
@Name varchar(20)


AS
BEGIN

SELECT Name, Roll, Institute
FROM dbo.Student_detail WHERE Roll=@Roll AND Name=@Name
ORDER BY Roll
END




--------Encryption Procedure........---------------ok

CREATE PROC EmployeeInfo


@Roll int,
@Name varchar(20)
WITH encryption

As
BEGIN

SELECT Name, Roll, Institute
FROM dbo.Student_detail WHERE Roll=@Roll AND Name=@Name
ORDER BY Roll
END
---------------------------

SELECT * FROM Student_detail

EXEC EmployeeInfo  'joherulhoq', '101'

EXEC sp_helptext EmployeeInfo   -----------ok Encryption

-------Drop Procedure.......

DROP PROCEDURE EmployeeInfo



--------------  Insert Procedure------------------------------------
CREATE TABLE [dbo].[Student]
(
	[Id] [INT] IDENTITY(1,1) NOT NULL,
	[Fname] [VARCHAR](50) NULL,
	[MName] [VARCHAR](50) NULL,
	[Lastname] [VARCHAR](50) NULL
)

SELECT * FROM dbo.Student

ALTER PROCEDURE [dbo].[Studententry]  
(

@Fname VARCHAR(50),
@MName VARCHAR(50),
@Lastname VARCHAR(50)
)
AS
BEGIN

INSERT INTO Student (Fname,MName,Lastname) VALUES (@Fname,@MName,@Lastname) 

END
GO

---Insert Data.....Exmple--------

EXEC dbo.Studententry @Fname = 'Md', -- varchar(50)
    @MName = 'Rubel', -- varchar(50)
    @Lastname = 'Hossain' -- varchar(50)

--or...
	EXEC Studententry  'Joherul', 'Hoque', 'shuvo'
	----------


	-------Update  procedure------------------------------------

ALTER PROCEDURE [dbo].[Studententry_Update]  
(
@MName VARCHAR(50),
@Id INT

)
AS
BEGIN

UPDATE dbo.Student SET MName=@MName WHERE Id=@Id 

END
GO


 EXEC [Studententry_Update] 'shuvo' , '2'

 SELECT * FROM dbo.Student
 -------------------------------------------------------------------

----Output Parameter procedure-------------



CREATE PROC sp_outpuparameter
(
@Roll int,
@outputparameter int output
)
AS
BEGIN
SELECT @outputparameter = count(Roll)  FROM dbo.Student_detail WHERE Roll=@Roll

END


DECLARE @outputparameter INT
EXEC sp_outpuparameter '101', @outputparameter OUTPUT

PRINT @outputparameter
IF(@outputparameter IS NULL)
PRINT 'Output data is null'
ELSE
PRINT 'Output data is not null'


SELECT * FROM dbo.Student_detail


sp_depends 'sp_outpuparameter'
------------------------------------------------
CREATE PROC spwr_getcount
@totalcount INT OUTPUT
AS
BEGIN

SELECT @totalcount =  COUNT(Id) FROM dbo.Employee
END


DECLARE @totalcountEmployee INT
EXEC spwr_getcount @totalcountEmployee OUTPUT
SELECT @totalcountEmployee AS total_ID


----------------------

ALTER PROC spwr_Return_Count
AS
BEGIN

RETURN   (SELECT COUNT(*) FROM dbo.Employee)
END
GO




DECLARE @ReturnCount INT
EXEC @ReturnCount = spwr_Return_Count
SELECT @ReturnCount


--------Output Parameter-----------------


ALTER PROC spwr_getcount_outparameter
@Id int,
@Name varchar(25) OUT
AS
BEGIN


SELECT @Name = Name FROM dbo.Employee WHERE Id=@Id
END


DECLARE @EmName VARCHAR(20)
EXEC spwr_getcount_outparameter 2, @EmName OUTPUT
SELECT @EmName

--------------Rrturn Parameter-------------
---Error ---But --Return value output only 0/1 
--so this Name no Return string type

CREATE PROC spwr_getcount_Return_parameter
@Id int
AS
BEGIN
RETURN (SELECT Name FROM dbo.Employee WHERE Id=@Id)
END


DECLARE @Return_para_Name VARCHAR(25)
EXEC @Return_para_Name = spwr_getcount_Return_parameter 1
SELECT @Return_para_Name


------------Difference Between Return and output parameter-----------------------------------
--RETURN status value......
 --1. only integer datatype
 --2. Only one value
 --3. Use to convey success or failure
 
 ---------Output parameters-------
 
 --1. Any Datatype
 --2. More than one value
 --3. Use to retuen values like name , etc.....
 
 
 -------------------------------------------------------------------------------




---,Substring,LEN,ROUND,NOW,FORMAT----



---MID or- Substring ------

SELECT SUBSTRING(Name,2,5) AS Shortcity FROM dbo.Employee


---Length  Function-----

SELECT LEN(Name) AS LengthofName FROM dbo.Employee

---Round  Function--------

SELECT * FROM dbo.Employee

SELECT ROUND(ManagerID,2) AS DecemalType FROM dbo.Employee


------Now or system current date and time function.. Getdate-- Function-----------

SELECT GETDATE() AS currentDateTime


----Format Function-----------

SELECT FORMAT(GETDATE(),'MM-dd-yyyy') AS BDdate

----Convert FORMAT----------

SELECT CONVERT(VARCHAR(10),GETDATE(),103)AS UsaDate


----------------------------------------------------------------




---Build in Function-------String Functions----------

--ASCII, UPPER,LOWER, LTRIM, RTRIM, REVERSE,LEN, Left,Right,CharIndex----

SELECT ASCII('A') AS number


SELECT UPPER(Name) AS UppercaseName FROM dbo.Employee


SELECT LOWER(Name) AS UppercaseName FROM dbo.Employee

SELECT LTRIM(name)  FROM dbo.Employee

SELECT RTRIM(name)  FROM dbo.Employee

SELECT REVERSE(Name) FROM dbo.Employee

--Left ..First 2 digit neba......

SELECT LEFT(Name,2) FROM dbo.Employee


--Right ..Last 2 digit neba......


SELECT RIGHT(Name,5) FROM dbo.Employee

-- CharIndex a character ta kon index a aca........

SELECT CHARINDEX('a',name) FROM dbo.Employee



-------------------------------------------------------26 Number video.......
---Replicate..Function.....5 Result

SELECT REPLICATE('JOHERLHOQ', 5) AS NAME 

--Space ...

SELECT Name+ SPACE(5)+Name FROM dbo.Employee

---Replace com to net change.........

SELECT * FROM dbo.TblPerson 

SELECT Email , REPLACE(Email,'com','.net') FROM dbo.TblPerson;

----Stuff function-------

SELECT Name,Email, STUFF(Email,2,3,'****') FROM dbo.TblPerson





--Date Time Fuction -----------------

CREATE TABLE tblDateTime
(

c_time TIME,
c_date DATE,
c_smalldatetime SMALLDATETIME,
c_datetime DATETIME,
c_datetime2 DATETIME2,
c_datetimefset DATETIMEOFFSET

)
GO


INSERT INTO dbo.tblDateTime
        ( c_time ,
          c_date ,
          c_smalldatetime ,
          c_datetime ,
          c_datetime2 ,
          c_datetimefset
        )
VALUES  ( GETDATE() , -- c_time - time
          GETDATE() , -- c_date - date
           GETDATE() , -- c_smalldatetime - smalldatetime
          GETDATE() , -- c_datetime - datetime
          SYSDATETIME() , -- c_datetime2 - datetime2
          SYSDATETIMEOFFSET()  -- c_datetimefset - datetimeoffset
        )

		SELECT * FROM dbo.tblDateTime

		--------Cast and Convert Function----------------

		CREATE TABLE castconvert
		(
		id INT IDENTITY(1,1) PRIMARY KEY,
		Name VARCHAR(20),
		DOB DATE
		)

		INSERT INTO dbo.castconvert
		        ( Name, DOB )
		VALUES  ( 'SHUVO', -- Name - varchar(20)
		          GETDATE()  -- DOB - date
		          )

		SELECT * FROM dbo.castconvert

		
		SELECT CAST(GETDATE()AS DATE)

		SELECT CONVERT(VARCHAR(10),GETDATE(),103)


		-------------------------

		------Mathematical Fuction-----------

--ABS FUCTION--

SELECT ABS(-200)

--CEILING FUNCION- Uporer deka round kora

SELECT CEILING(15.2)

SELECT CEILING(-15.2)

--Flor FUNCION- Necar deka round kora

SELECT FLOOR(15.2)

SELECT FLOOR(-15.2)

--Power Fuction---Multification--2*3=8

SELECT POWER(2,3)  

---RAND Fuction --Random--

SELECT RAND()

SELECT RAND(1)


SELECT RAND(1)+4

SELECT FLOOR( RAND(1)+500000)

SELECT FLOOR( RAND(1)*500000)


DECLARE @counter INT
SET @counter = 1

WHILE (@counter < 10)
BEGIN
PRINT FLOOR(RAND()*100)
SET @counter= @counter + 1
END


---SQUARE Fuction----

SELECT SQUARE(9)

---SQRT Fuction ----

SELECT SQRT(81)


---Round Fuction---

SELECT ROUND(850.556,2,1)


--Deterministic and Nondeterministic Fuction------


--Deterministic Fuction------

SELECT SUM(200)

SELECT AVG(500)

SELECT SQUARE(3)

SELECT POWER(5,2)

SELECT COUNT(50)

---Nondeterministic Fuction

SELECT GETDATE()

SELECT CURRENT_TIMESTAMP




 
----------Scalar Function---------

CREATE FUNCTION PersonAge(@Dob DATE)
RETURNS INT
AS
BEGIN

DECLARE @age INT
SELECT @age = DATEDIFF(YEAR,@Dob,Getdate())
RETURN @age
END

--Execute---PersonAge

SELECT dbo.PersonAge('1998-06-03')


-----------------table function Age-----------
CREATE TABLE Scaler_Function
(
id INT PRIMARY KEY,
Name VARCHAR(25),
DBO DATE
)

INSERT INTO Scaler_Function VALUES (1,'shuvo','1998-06-03')
INSERT INTO Scaler_Function VALUES (2,'hasan','1996-06-03')

SELECT Name, DBO, dbo.PersonAge(DBO) AS Age FROM dbo.Scaler_Function

-------------------Compare age--------
CREATE FUNCTION PersonAge1(@Dob DATE, @compare date)
RETURNS INT
AS
BEGIN

DECLARE @age INT
SELECT @age = DATEDIFF(YEAR,@Dob,@compare)
RETURN @age
END
  

  SELECT dbo.PersonAge1(DBO,'2020-10-17') age FROM dbo.Scaler_Function
  WHERE dbo.PersonAge1(DBO,'2020-10-17') > 20

  -------------------


   ----TCL - Transaction Control Language..


   


CREATE TABLE Branch
(
bcode INT,
bname VARCHAR(20),
location VARCHAR(20)
)


INSERT INTO dbo.Branch
        ( bcode, bname, location )
VALUES  ( 1022, -- bcode - int
          'PNB', -- bname - varchar(20)
          'BANGLA'  -- location - varchar(20)
          )


		  SELECT * FROM dbo.Branch

		  BEGIN TRANSACTION

		  UPDATE dbo.Branch SET bcode=1023 WHERE bcode=1021
		  COMMIT;
		  
		  BEGIN TRANSACTION

		  SAVE TRANSACTION S1
		  DELETE dbo.Branch WHERE bcode=1001


		  BEGIN TRANSACTION
		  ROLLBACK 
		  
		  TRANSACTION S1





