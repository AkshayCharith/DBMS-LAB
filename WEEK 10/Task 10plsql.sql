DELIMITER //

CREATE PROCEDURE cursor_tax_assessment()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);

    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN taxpayer_cursor;

    read_loop: LOOP

        FETCH taxpayer_cursor
        INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        SELECT
            v_name AS full_name,
            v_income AS Annual_Income,
            v_category AS Income_Category,
            v_tax AS Tax_Amount,
            v_net AS Net_Income;

    END LOOP;
    CLOSE taxpayer_cursor;
END //
DELIMITER ;

--Ques2
DELIMITER //
CREATE PROCEDURE cursor_conditional_assessment()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_category VARCHAR(50);

    DECLARE c_taxpayers CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN c_taxpayers;

    read_loop: LOOP

        FETCH c_taxpayers INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        IF v_income <= 500000 THEN

            SET v_tax = 0;
            SET v_category = 'NO TAX';

        ELSEIF v_income <= 1000000 THEN

            SET v_tax = (v_income - 500000) * 0.10;
            SET v_category = 'Standard Assessment';

        ELSE

            SET v_tax = calculate_tax(v_income);
            SET v_category = 'High Income Assessment';

        END IF;

        SELECT
            v_name AS full_name,
            v_income AS Annual_Income,
            v_tax AS Tax_Amount,
            v_category AS Assessment_Category;

    END LOOP;

    CLOSE c_taxpayers;
END //


DELIMITER ;
-- Ques4
DELIMITER //
CREATE PROCEDURE update_taxpayer_income(
    IN p_taxpayer_id INT,
    IN p_new_income DECIMAL(12,2)
)
BEGIN

    DECLARE v_name VARCHAR(100);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    IF p_new_income < 0 THEN
        SELECT 'Invalid income. Income cannot be negative.' AS Message;
    ELSE

        SELECT full_name
        INTO v_name
        FROM Taxpayer
        WHERE taxpayer_id = p_taxpayer_id;

        IF v_not_found THEN

            SELECT 'Taxpayer not found' AS Message;

        ELSE

            UPDATE Taxpayer
            SET annual_income = p_new_income
            WHERE taxpayer_id = p_taxpayer_id;

            SELECT
                'Income updated successfully' AS Message,
                v_name AS full_name,
                p_new_income AS New_Income;

        END IF;

    END IF;
END //
DELIMITER ;


--Ques4.
DELIMITER //
CREATE PROCEDURE exception_tax_assessment(
    IN p_taxpayer_id INT
)
BEGIN

    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SELECT 'An SQL error occurred.' AS Message;

    SELECT annual_income
    INTO v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN

        SELECT 'Taxpayer not found.' AS Message;

    ELSE

        SET v_tax = calculate_tax(v_income);

        SELECT
            v_income AS annual_Income,
            v_tax AS Tax_Amount;

    END IF;
END //










--level3
--Ques1
DELIMITER ;
DELIMITER //
CREATE PROCEDURE complete_tax_assessment(IN p_taxpayer_id INT)
BEGIN

    DECLARE v_name VARCHAR(100);
    DECLARE v_pan VARCHAR(20);
    DECLARE v_occupation VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);

    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);

    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    SELECT
        full_name,
        pan_number,
        occupation,
        annual_income
    INTO
        v_name,
        v_pan,
        v_occupation,
        v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN

        SELECT 'Taxpayer not found.' AS Message;

    ELSE

        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        SELECT
            v_name AS full_name,
            v_pan AS PAN_Number,
            v_occupation AS Occupation,
            v_income AS Annual_Income,
            v_category AS Income_Category,
            v_tax AS Tax_Amount,
            v_net AS Net_Income;

    END IF;
END //
DELIMITER ;
CALL complete_tax_assessment(103);

-- Ques2
DELIMITER //
CREATE PROCEDURE process_income_records()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_income_id INT;
    DECLARE v_taxpayer_id INT;
    DECLARE v_source VARCHAR(100);
    DECLARE v_category VARCHAR(50);
    DECLARE v_amount DECIMAL(12,2);
    DECLARE v_received_date DATE;
    DECLARE v_financial_year VARCHAR(30);
    DECLARE v_classification VARCHAR(30);

    DECLARE c_records CURSOR FOR
        SELECT
            ir.income_id,
            ir.taxpayer_id,
            ir.income_source,
            ic.category_name,
            ir.amount,
            ir.received_date,
            fy.financial_year
        FROM Income_Record ir
        JOIN Income_Category ic
            ON ir.category_id = ic.category_id
        JOIN Financial_Year fy
            ON ir.year_id = fy.year_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN c_records;

    read_loop: LOOP

        FETCH c_records
        INTO v_income_id,
             v_taxpayer_id,
             v_source,
             v_category,
             v_amount,
             v_received_date,
             v_financial_year;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        IF v_amount <= 50000 THEN
            SET v_classification = 'Small Income Record';

        ELSEIF v_amount <= 200000 THEN
            SET v_classification = 'Medium Income Record';

        ELSE
            SET v_classification = 'Large Income Record';
        END IF;

        SELECT
            v_income_id AS Income_ID,
            v_taxpayer_id AS Taxpayer_ID,
            v_source AS Income_Source,
            v_category AS Category,
            v_amount AS Amount,
            v_received_date AS Received_Date,
            v_financial_year AS Financial_Year,
            v_classification AS Classification;

    END LOOP;

    CLOSE c_records;
END //
DELIMITER ;

--Ques3
DELIMITER //
CREATE PROCEDURE combined_tax_assessment()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);

    DECLARE c_taxpayers CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN c_taxpayers;

    read_loop: LOOP

        FETCH c_taxpayers INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        SELECT
            v_name AS full_name,
            v_income AS Annual_Income,
            v_category AS Income_Category,
            v_tax AS Tax_Amount,
            v_net AS Net_Income;

    END LOOP;
    CLOSE c_taxpayers;
END //
DELIMITER ;

