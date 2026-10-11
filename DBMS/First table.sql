CREATE DATABASE first;
USE first;
CREATE TABLE PopulationData(SNO INT PRIMARY KEY,CountryName VARCHAR(20) NOT NULL);
ALTER TABLE PopulationData ADD (PopulationSize VARCHAR(10) NOT NULL);
INSERT Into PopulationData values (1,'India', '130 Crores');
INSERT Into PopulationData values (2,'Japan', '10 Crores');
UPDATE PopulationData SET CountryName = 'Japan' where SNO=1;  
SELECT *FROM PopulationData;