-- Part A – Basic Views
-- Level 01
-- Task 01
CREATE VIEW Highest_Income AS
SELECT *
FROM INCOME_RECORD
WHERE Amount = (SELECT MAX(Amount)
				FROM income_record);
SELECT * 
FROM Highest_Income;
DROP VIEW Lowest_Income;
-- Task 02
CREATE VIEW Lowest_Income AS
SELECT *
FROM INCOME_RECORD
WHERE Amount = (SELECT MIN(Amount)
				FROM income_record);
SELECT *
FROM Lowest_Income;
-- Task 03
CREATE VIEW IncGreaterThanAverage AS
SELECT *
FROM INCOME_RECORD
WHERE AMOUNT > (SELECT AVG(Amount)
				FROM INCOME_RECORD);
SELECT * 
FROM IncGreaterThanAverage;
-- Task 04
CREATE VIEW IncomeRecGreaterEqualToHighestInc AS
SELECT *
FROM INCOME_RECORD
WHERE AMOUNT = (SELECT MAX(Amount)
				FROM INCOME_RECORD);
SELECT * 
FROM IncomeRecGreaterEqualToHighestInc;
-- Task 05
CREATE VIEW TaxpayersOccupationBusinessOwner As
SELECT * 
FROM Taxpayer
WHERE Occupation IN (SELECT Occupation
					FROM Taxpayer
					WHERE Occupation = "Business Owner"
					);
SELECT *
FROM TaxpayersOccupationBusinessOwner;


-- Level 2 – Application
-- Task 01
CREATE VIEW TaxpayersHavingAtleastOneIncomeRecord AS
SELECT * 
FROM taxpayer 
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					  FROM INCOME_RECORD
					  );
SELECT *
FROM TaxpayersHavingAtleastOneIncomeRecord;

-- Task 02
CREATE VIEW TaxpayersHavingIncomeInBusiness AS
SELECT *
FROM Taxpayer
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					  FROM INCOME_RECORD
                      WHERE Category_Id IN (SELECT Category_Id
											FROM INCOME_CATEGORY
                                            WHERE Category_Name = 'Business'
												)
						);
SELECT *
FROM TaxpayersHavingIncomeInBusiness;

-- Task 03
CREATE VIEW IncomeRecordsBelongToSameFinancialYear AS
SELECT * 
FROM INCOME_RECORD
WHERE Year_Id IN (SELECT Year_Id
				  FROM financial_year
                  WHERE Year_Label = '2025-2026'
					);
SELECT *
FROM IncomeRecordsBelongToSameFinancialYear;

-- Task 04
CREATE VIEW IncomeRecordsAmountGreaterThanMinimumBusinessIncome AS
SELECT *
FROM INCOME_RECORD
WHERE Amount > (SELECT MIN(Amount)
				FROM INCOME_RECORD
                WHERE Category_Id IN (SELECT Category_Id
									  FROM INCOME_CATEGORY
                                      WHERE Category_Name = 'Business'
									 )); 
SELECT *
FROM IncomeRecordsAmountGreaterThanMinimumBusinessIncome;

-- Task 05
CREATE VIEW IncomeRecordsAmountLessThanMaximumSalaryIncome AS
SELECT * 
FROM INCOME_RECORD
WHERE Amount < (SELECT MAX(Amount)
				 FROM INCOME_RECORD
                 WHERE Category_Id IN (SELECT Category_Id
									   FROM INCOME_CATEGORY
                                       WHERE Category_Name = 'Salary'
									));
SELECT *
FROM IncomeRecordsAmountLessThanMaximumSalaryIncome;

-- Task06
CREATE VIEW IncomeRecordsGreaterThanAverageIncome AS
SELECT *
FROM Taxpayer
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					 FROM INCOME_RECORD
                     WHERE Amount > (SELECT AVG(Amount)
									FROM INCOME_RECORD
								     )
						); 
SELECT * 
FROM IncomeRecordsGreaterThanAverageIncome;

-- Task 07
CREATE VIEW IncomeCategoryAtleastOneIncomeRecord As
SELECT *
FROM INCOME_CATEGORY
WHERE Category_Id IN (SELECT Category_Id
					  FROM INCOME_RECORD
						);  
SELECT *
FROM IncomeCategoryAtleastOneIncomeRecord;

-- Task 08
CREATE VIEW TaxpayerHaveNoIncomeRecordsInInvestment AS
SELECT * 
FROM Taxpayer
WHERE Taxpayer_Id NOT IN (SELECT Taxpayer_Id
						  FROM INCOME_RECORD
                          WHERE Category_Id IN (SELECT Category_Id
												FROM INCOME_CATEGORY
                                                WHERE Category_Name = 'Investment'
												)
							) ;
SELECT *
FROM TaxpayerHaveNoIncomeRecordsInInvestment;

--  Level 03 – Medium to Advanced 

--  Task 01
CREATE VIEW TaxpayerHavingHighestRecordedIncome AS
SELECT * 
FROM Taxpayer
WHERE taxpayer_Id IN (SELECT taxpayer_Id
					  FROM INCOME_RECORD
                      WHERE Amount IN (SELECT MAX(Amount)
									   FROM INCOME_RECORD
										)
						);   
SELECT *
FROM TaxpayerHavingHighestRecordedIncome;

-- Task 02 
CREATE VIEW IncomeRecordsHavingIncomeRecordsGreaterThanAverageBusinessIncome AS
SELECT * 
FROM INCOME_RECORD
WHERE Amount > (SELECT AVG(Amount)
				FROM INCOME_RECORD
                WHERE Category_Id IN (SELECT Category_Id
									  FROM INCOME_CATEGORY
                                      WHERE Category_Name = 'Business'
										)
                
				);
SELECT *
FROM IncomeRecordsHavingIncomeRecordsGreaterThanAverageBusinessIncome;

-- Task 03
CREATE VIEW TaxpayerIncomeGreaterThanAverageOfAllTaxpayers AS
SELECT * 
FROM Taxpayer
WHERE Taxpayer_Id IN (SELECT Taxpayer_Id
					  FROM INCOME_RECORD
                      WHERE Amount > (SELECT AVG(Amount)
									  FROM INCOME_RECORD)
						); 
SELECT *
FROM TaxpayerIncomeGreaterThanAverageOfAllTaxpayers;

-- Task 04
CREATE VIEW IncomeRecordsAmountGreaterThan AS
SELECT * 
FROM INCOME_RECORD
WHERE Amount > ANY (SELECT Amount
					FROM INCOME_RECORD
                    WHERE Category_Id IN (SELECT Category_Id
										  FROM INCOME_CATEGORY
                                          WHERE Category_Name = 'Investment'
											)
					); 
SELECT *
FROM IncomeRecordsAmountGreaterThan;

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
CREATE VIEW IncomeCategoryContainsHighestIncomeRecord AS
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
SELECT * 
FROM IncomeCategoryContainsHighestIncomeRecord;

-- Task 08
CREATE VIEW TaxpayersIncomeGreaterThanAverageAllIncomeTaxpayers AS
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
SELECT *
FROM TaxpayersIncomeGreaterThanAverageAllIncomeTaxpayers;




































