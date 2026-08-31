-- PART A 
-- Level 1 Basic subqueries
SELECT *
FROM INCOME_RECORD
WHERE AMOUNT IN (SELECT MAX(Amount)
				FROM INCOME_RECORD);

SELECT *
FROM INCOME_RECORD
WHERE AMOUNT IN (SELECT MIN(Amount)
				FROM INCOME_RECORD);
                
SELECT *
FROM INCOME_RECORD
WHERE AMOUNT > (SELECT AVG(Amount)
				FROM INCOME_RECORD);
                
SELECT *
FROM INCOME_RECORD
WHERE AMOUNT = (SELECT MAX(Amount)
				FROM INCOME_RECORD);
                
SELECT * 
FROM Taxpayer
WHERE Occupation IN (SELECT Occupation
					FROM Taxpayer
					WHERE Occupation = "Business Owner"
					);
                    
-- Level 02
-- Task 01 
SELECT * 
FROM taxpayer 
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					  FROM INCOME_RECORD
					  );
-- Task 02
SELECT * 
FROM taxpayer
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					  FROM INCOME_RECORD
                      WHERE Category_ID IN (SELECT Category_Id
											FROM INCOME_CATEGORY
                                            WHERE Category_Name = 'Business'
											));
-- Task 03
SELECT * 
FROM INCOME_RECORD
WHERE Year_Id IN (SELECT Year_Id
				  FROM financial_year
                  WHERE Year_Label = '2025-2026'
					);
-- Task 04
SELECT *
FROM INCOME_RECORD
WHERE Amount > (SELECT MIN(Amount)
				FROM INCOME_RECORD
                WHERE Category_Id IN (SELECT Category_Id
									  FROM INCOME_CATEGORY
                                      WHERE Category_Name = 'Business'
									 ));
-- Task 05
SELECT * 
FROM INCOME_RECORD
WHERE Amount < (SELECT MAX(Amount)
				 FROM INCOME_RECORD
                 WHERE Category_Id IN (SELECT Category_Id
									   FROM INCOME_CATEGORY
                                       WHERE Category_Name = 'Salary'
									));
-- Task 06
SELECT *
FROM Taxpayer
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					 FROM INCOME_RECORD
                     WHERE Amount > (SELECT AVG(Amount)
									FROM INCOME_RECORD
								     )
						); 
-- Task 07
SELECT *
FROM INCOME_CATEGORY
WHERE Category_Id IN (SELECT Category_Id
					  FROM INCOME_RECORD
						); 
-- Task 08
SELECT * 
FROM Taxpayer
WHERE Taxpayer_Id NOT IN (SELECT Taxpayer_Id
						  FROM INCOME_RECORD
                          WHERE Category_Id IN (SELECT Category_Id
												FROM INCOME_CATEGORY
                                                WHERE Category_Name = 'Investment'
												)
							); 

--  Level 03
--  Task 01
SELECT * 
FROM Taxpayer
WHERE taxpayer_Id IN (SELECT taxpayer_Id
					  FROM INCOME_RECORD
                      WHERE Amount IN (SELECT MAX(Amount)
									   FROM INCOME_RECORD
										)
						);                        
-- Task 02 
SELECT * 
FROM INCOME_RECORD
WHERE Amount > (SELECT AVG(Amount)
				FROM INCOME_RECORD
                WHERE Category_Id IN (SELECT Category_Id
									  FROM INCOME_CATEGORY
                                      WHERE Category_Name = 'Business'
										)
                
				);
-- Task 03
SELECT * 
FROM Taxpayer
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					  FROM INCOME_RECORD
                      WHERE Amount > (SELECT AVG(Amount)
									  FROM INCOME_RECORD)
						); 
-- Task 04
SELECT * 
FROM INCOME_RECORD
WHERE Amount > ANY (SELECT Amount
					FROM INCOME_RECORD
                    WHERE Category_Id IN (SELECT Category_Id
										  FROM INCOME_CATEGORY
                                          WHERE Category_Name = 'Investment'
											)
					); 
-- Task 05
 SELECT * 
FROM INCOME_RECORD
WHERE Amount > ALL (SELECT Amount
					FROM INCOME_RECORD
                    WHERE Category_Id IN (SELECT Category_Id
										  FROM INCOME_CATEGORY
                                          WHERE Category_Name = 'Investment'
											)
					); 
-- Task 06
SELECT * 
FROM INCOME_CATEGORY
WHERE Category_Id IN (SELECT Category_Id
					  FROM INCOME_CATEGORY
                      WHERE Category_Id IN (SELECT Category_Id
											FROM INCOME_RECORD
                                            WHERE Amount IN (SELECT MAX(Amount)
															FROM INCOME_RECORD
															)
											)
						); 
-- Task 08
SELECT * 
FROM taxpayer
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					  FROM INCOME_RECORD
                      WHERE Amount > (SELECT AVG(Amount)
									  FROM INCOME_CATEGORY
                                      WHERE Amount = (SELECT SUM(Amount)
													  FROM INCOME_CATEGORY
														)
										)
						);                         










