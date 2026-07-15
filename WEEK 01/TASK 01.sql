CREATE DATABASE Taxation_db;
USE Taxation_db;
CREATE TABLE Taxpayer(Taxpayer_Id INT PRIMARY KEY,
				Pan_Number VARCHAR(10) NOT NULL UNIQUE,
				FullName VARCHAR(100) NOT NULL,
                DateOfBirth DATE NOT NULL, 
                Occupation VARCHAR (50) NOT NULL,
                Annual_Income DECIMAL(12,2) NOT NULL,
                Email VARCHAR(100) UNIQUE,
                Is_active BOOLEAN);
INSERT INTO Taxpayer VALUES 
							 (101,"ABCDE1234F","Ravi Kumar","1995-06-15","Software Engineer",850000.00,"ravikumar@example.com",TRUE),
							 (102,"BCDEfF234G","Priya Sharma","1992-11-22","Doctor",1200000.00,"priya.sharma@example.com",TRUE),
							 (103,"CDEFG3456H","Arjun Reddy","1988-03-10","Business Owner",1800000.00,"arjun.reddyr@example.com",TRUE),
							 (104,"DEFGH1234I","Sneha Patel","1998-08-05","Teacher",620000.00,"sneha.patel@example.com",TRUE),
							 (105,"EFGHJ1234J","Kiran Rao","1990-01-18","FreeLancer",875000.00,"kiran.rao@example.com",TRUE),
							 (106,"FGHJK1234K","Meera Singh","1985-12-30","Consultant",1500000.00,"meera.singh@example.com",FALSE);

SET SQL_SAFE_UPDATES=0;
INSERT INTO Taxpayer
VALUES (107,"GHIJK7890M","Sylveon","1996-03-25","ML Engineer",1800000.00,"sylveon@example.com",TRUE);

UPDATE Taxpayer 
SET Annual_Income = 950000.00
WHERE FullName = "Ravi Kumar" ;

UPDATE Taxpayer
SET Occupation = "Software Consultant"
WHERE FullName = "Kiran rao";

UPDATE Taxpayer
SET  Is_active = TRUE 
WHERE FullName = "Meera Singh";

DELETE FROM Taxpayer
WHERE Taxpayer_Id = 107;

ALTER TABLE Taxpayer
ADD COLUMN Phone_Number INT NOT NULL;

ALTER TABLE Taxpayer
MODIFY Occupation VARCHAR(100);

INSERT INTO Taxpayer
VALUES (101,"GHIJ7890M","Sylveon","1996-03-25","ML Engineer",1800000.00,"sylveon@example.com",TRUE);
/*Error Code: 1062. Duplicate entry '101' for key 'tax_payer_Id.PRIMARY'	0.000 sec*/
INSERT INTO Taxpayer
VALUES (107,"ABCDE1234F","Pikatchu","1999-04-14","DS Engineer",100000.00,"pikatchu@example.com",TRUE);
INSERT INTO Taxpayer
VALUES (110,"BASJ7890M","Infernape","1986-03-25","Engineer",1700000.00,"infernape@example.com",TRUE);
SELECT *FROM Taxpayer;





CREATE TABLE INCOME_CATEGORY(Category_ID INT PRIMARY KEY,
							Category_Name VARCHAR(50) NOT NULL UNIQUE,
                            description1 VARCHAR(200) NOT NULL,
                            Taxable BOOLEAN NOT NULL);
INSERT INTO INCOME_CATEGORY VALUES   
									 (1,"Salary","Income received from employmnet", TRUE),
									 (2,"Business","Income earned from business activities.",TRUE),
									 (3,"House Property","Income received form property or rent.",TRUE),
									 (4,"Capital Gains","Income from transfer of eligible assets.",TRUE),
									 (5,"Other Resources","Income such as bank interest.",TRUE),
									 (6,"Agricultural Income","Income from eligible agricultural activities.",FALSE);
SELECT *FROM INCOME_CATEGORY;
INSERT INTO INCOME_CATEGORY
VALUES (7,"Rental Income","Income is generating through rental.",TRUE);
                            
CREATE TABLE FINANCIAL_YEAR(Year_Id INT PRIMARY KEY,
							Year_Label VARCHAR(9) NOT NULL UNIQUE,
                            Start_Date DATE NOT NULL,
                            End_Date DATE NOT NULL,
                            Filing_Deadline DATE ,
                            Is_Current BOOLEAN NOT NULL);
INSERT INTO FINANCIAL_YEAR VALUES   
									(1,"2020-2021","2020-04-01","2021-03-31","2021-07-31", FALSE),
									(2,"2021-2022","2021-04-01","2022-03-31","2022-07-31", FALSE),
									(3,"2022-2023","2022-04-01","2023-03-31","2023-07-31", FALSE),
									(4,"2023-2024","2023-04-01","2024-03-31","2024-07-31", FALSE),
									(5,"2024-2025","2024-04-01","2025-03-31","2025-07-31", FALSE),
									(6,"2025-2026","2025-04-01","2026-03-31","2026-07-31", TRUE); 
SELECT *FROM FINANCIAL_YEAR;                    
                            

CREATE TABLE INCOME_RECORD(Income_Id INT PRIMARY KEY,
							Taxpayer_Id INT NOT NULL,
                            Income_Source VARCHAR(100) NOT NULL,
                            Category_Name VARCHAR(50) NOT NULL,
                            Amount DECIMAL(12,2) NOT NULL,
                            Recieve_Date DATE NOT NULL,
                            Financial_Year VARCHAR(9) NOT NULL);
                            
ALTER TABLE INCOME_RECORD 
ADD CONSTRAINT fk_taxpayer
FOREIGN KEY (Taxpayer_Id) REFERENCES Taxpayer(Taxpayer_Id);

						
INSERT INTO INCOME_RECORD VALUES 
								 (1001,101,"TechNovaSolutions","Salary",850000.00,"2026-03-31","2025-2026"),
								 (1002,102,"City Care Hospital","Salary",1200000.00,"2026-03-31","2025-2026"),
								 (1003,103,"Reddy Enterprises","Business",1800000.00,"2026-03-31","2025-2026"),
								 (1004,104,"Sunrise School","Salary",620000.00,"2026-03-31","2025-2026"),
								 (1005,105,"Web Design Projects","Business",750000.00,"2026-03-31","2025-2026"),
								 (1006,106,"Professional Consultating","Business",1500000.00,"2026-03-31","2025-2026");
ALTER TABLE INCOME_RECORD
ADD COLUMN Remarks INT NOT NULL;

SELECT *FROM INCOME_RECORD;


CREATE TABLE Tax_Office  (Office_Id INT PRIMARY KEY,
						  Office_Name VARCHAR(50) NOT NULL,
                          City VARCHAR(100) NOT NULL);
INSERT INTO Tax_Office VALUES
(111,"Microsoft","Washington"),
(222,"Meta","California");

TRUNCATE TABLE Tax_Office;
DROP TABLE Tax_Office;
SELECT *FROM Tax_Office;








