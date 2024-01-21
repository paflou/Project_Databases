DROP PROCEDURE IF EXISTS auto_grading;
DROP PROCEDURE IF EXISTS result_extraction;
DROP PROCEDURE IF EXISTS evaluators_grade;
DROP PROCEDURE IF EXISTS application_handler;
DROP PROCEDURE IF EXISTS final_grading;
DROP PROCEDURE IF EXISTS search_a;
DROP PROCEDURE IF EXISTS search_b;


-- 3.1.3.1 -----------------------------------------------------------------------------
DELIMITER $
CREATE PROCEDURE auto_grading(
candidate varchar(30), OUT grade int)
BEGIN
	DECLARE level enum('BSc', 'MSc', 'PhD');
    DECLARE project_num INT DEFAULT 0;
    DECLARE languages INT DEFAULT 0;
    DECLARE flag INT;
    
	DECLARE bcursor CURSOR FOR
	SELECT bathmida
    FROM degree
    inner join has_degree ON titlos = degr_title AND degr_idryma = idryma
    WHERE cand_usrname = candidate;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag=1;
    set flag=0;
	
    set grade = 0;
    OPEN bcursor;
    
	FETCH bcursor INTO level;

	WHILE(flag=0)
    DO
    SET grade =
	CASE
		WHEN level = 'BSc' THEN  grade + 1
		WHEN level = 'MSc' THEN  grade + 2
		ELSE grade + 3
	END;

	FETCH bcursor INTO level;
    END WHILE;
    
    
    CLOSE bcursor;
    
	select MAX(num) INTO project_num
    FROM project WHERE candid = candidate;
    IF project_num IS NULL
    THEN 
		SET project_num = 0;
	END IF;
    
	SELECT LENGTH(lang) - LENGTH(REPLACE(lang, ',', '')) + 1 INTO languages
	FROM languages
	WHERE candid = candidate;

	set grade = grade + project_num;

    IF(languages >= 2)
	THEN
		set grade = grade + 1;
    END IF;
END$
DELIMITER ;

    
DELIMITER $
CREATE PROCEDURE evaluators_grade(
evaluator varchar(30), employee_username varchar(30), job int, OUT grade int)
BEGIN
	DECLARE grade_out int;
    
    SELECT grade1 INTO grade_out
    FROM applies 
    INNER JOIN job ON job_id = id
    WHERE evaluator_1 = evaluator AND employee = employee_username AND job_id = job;
    
    IF grade_out IS NULL THEN
		SELECT grade2 INTO grade_out
		FROM applies
		INNER JOIN job ON job_id = id
		WHERE evaluator_2 = evaluator AND employee = employee_username AND job_id = job;
	END IF;

    IF grade_out IS NULL THEN
		SET grade = 0;
	ELSEIF grade_out = -1 THEN
		call auto_grading(employee_username, grade);
	ELSE 
		SET grade = grade_out;
	END IF;	
END$
DELIMITER ;

-- TEST --
/*
select * from job;
select * from applies;
call evaluators_grade('john_doe', 'Alte1970', 1, @res);
select @res;
*/

-- 3.1.3.2 --------------------------------------------------------------------------------
DELIMITER $
CREATE PROCEDURE application_handler(
employee_username varchar(30), job int, operation char(1))
BEGIN
	DECLARE eval1 varchar(30);
    DECLARE eval2 varchar(30);
    
	IF operation = 'i' THEN
		SELECT evaluator_1, evaluator_2 INTO eval1, eval2
        FROM job
        WHERE id = job;
        
        IF eval1 IS NULL THEN
			UPDATE job
			SET evaluator_1 = (SELECT evaluator.username FROM evaluator 
						INNER JOIN job ON job.evaluator = evaluator.username
                        inner join evaluator AS parent_eval ON job.evaluator = parent_eval.username
                        WHERE evaluator.firm = parent_eval.firm
                        ORDER BY RAND()
                        LIMIT 0,1)
            WHERE id = job;
		END IF;
		IF eval2 IS NULL THEN
			UPDATE job
			SET evaluator_2 = (SELECT evaluator.username FROM evaluator 
						INNER JOIN job ON job.evaluator = evaluator.username
						inner join evaluator AS parent_eval ON job.evaluator = parent_eval.username
                        WHERE evaluator.firm = parent_eval.firm
						ORDER BY RAND()
                        LIMIT 0,1)
			WHERE id = job;
		END IF;
	INSERT INTO applies VALUES(employee_username, job, DEFAULT, NOW(), NULL, NULL, NULL);

    ELSEIF operation = 'c' THEN
		IF EXISTS(SELECT employee FROM applies WHERE employee = employee_username AND job_id = job AND application_status = 'active') THEN
			UPDATE applies
            SET application_status = 'canceled'
            WHERE employee = employee_username AND job_id = job AND application_status = 'active';
		    
        ELSE 
			SIGNAL SQLSTATE '45000'        
			SET MESSAGE_TEXT = 'Employee doesnt have active application or it has already been canceled';
		END IF;
	
    ELSEIF operation = 'a' THEN
		IF EXISTS(SELECT employee FROM applies WHERE employee = employee_username AND job_id = job AND application_status = 'canceled') THEN
			UPDATE applies
            SET application_status = 'active'
            WHERE employee = employee_username AND job_id = job AND application_status = 'canceled';
		ELSE 
			SIGNAL SQLSTATE '45000'        
			SET MESSAGE_TEXT = 'The application doesnt exist or employee already has active application for this position ';
		END IF;
	ELSE
		SIGNAL SQLSTATE '45000'        
		SET MESSAGE_TEXT = 'Wrong input! ';
    END IF;
	select 'Operation success! ' ;
END$
DELIMITER ;
/*
-- TEST FOR 3.1.3.2
delete from applies;
select * from applies;
select * from job;
INSERT INTO applies VALUES ('Alte1970',2,'active',NOW(), DEFAULT,DEFAULT,DEFAULT);
call application_handler('Alte1970', 2,'i');
call application_handler('Alte1970', 2,'c');
call application_handler('Alte1970', 2,'a');
*/

-- 3.1.3.3-----------------------------------------------------------------------------------
DELIMITER $
CREATE PROCEDURE final_grading (
candidate VARCHAR(30), job INT , status ENUM ('active', 'canceled', 'finished'))
BEGIN
    DECLARE grade1_result INT;
	DECLARE grade2_result INT;
	
    select grade1, grade2 INTO grade1_result, grade2_result
    FROM applies
    WHERE  candidate = employee AND job_id = job AND status = application_status;
    
	if(status != 'canceled')
	THEN
		IF(grade1_result = -1)
        THEN
			CALL auto_grading(candidate,grade1_result);
            UPDATE applies 
            SET grade1 = grade1_result
            WHERE candidate = employee AND job = job_id AND application_status = status;
        END IF;
        
		IF(grade2_result = -1)
        THEN
			CALL auto_grading(candidate,grade2_result);
            UPDATE applies 
            SET grade2 = grade2_result
            WHERE candidate = employee AND job = job_id AND application_status = status;        
		END IF;
        
		UPDATE applies 
        SET total_grade = (grade1_result + grade2_result) /  2
		WHERE candidate = employee AND job = job_id AND application_status = status;
	END IF;
END$
DELIMITER ;
/*
select * from applies where job_id =1;
call final_grading("Alte1970",1,"active");
*/

DELIMITER $
CREATE PROCEDURE result_extraction(
job int, OUT Results varchar(30))
BEGIN
	DECLARE flag INT;
    DECLARE candidate varchar(30);
	DECLARE state ENUM ('active', 'canceled', 'finished');
    DECLARE winner varchar(30);
    DECLARE grade INT;
    DECLARE evaluator1 varchar(30);
    DECLARE evaluator2 varchar(30);
    
	DECLARE bcursor CURSOR FOR
    SELECT employee FROM applies
    where job_id = job;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag=1;
    set flag=0;

    OPEN bcursor;
	FETCH bcursor INTO candidate;

    WHILE (flag=0)
    DO       
        select application_status into state
        from applies
        where employee = candidate AND job_id = job;
        
        SELECT evaluator_1, evaluator_2 INTO evaluator1, evaluator2
        FROM job
        WHERE id =job;
        
        call final_grading(candidate, job, state);
        
		SELECT total_grade INTO grade
        FROM applies
        WHERE employee = candidate AND job_id = job;
        
        IF( grade IS NULL ) THEN 
			set grade =0;
        END IF;
        
		INSERT INTO applications_history VALUES
		(evaluator1, evaluator2, candidate, job, 'finished', grade);
	
		FETCH bcursor INTO candidate;
	END WHILE;
	CLOSE bcursor;

	SELECT employee INTO winner
	FROM applies
	WHERE total_grade = (
    SELECT MAX(total_grade)
    FROM applies
    WHERE job_id = job AND application_status = 'active'
	)
	ORDER BY insertion_time DESC limit 0,1;

    set Results = winner;
    
     DELETE FROM applies WHERE job_id = job;
END$
DELIMITER ;

/*
 -- TEST FOR 3.1.3.3
select * from applies;
select * from applications_history;
call result_extraction(1,@res);
select @res; 
*/

############################################MyAdditionsFor 3.1.3.4##############################
-- 3.1.3.4.a-----------------------------------------------------------------------

DELIMITER $
CREATE PROCEDURE  search_a(
IN grade_1 INT, IN grade_2 INT
 )
BEGIN
DECLARE employee_username varchar(30);
DECLARE job int(11);

SELECT employee, job_id
FROM applications_history
WHERE grade > grade_1 AND grade < grade_2;
END$
DELIMITER ;
# CALL search_a(6,13);

-- 3.1.3.4.b---------------------------------------------------------------------
DELIMITER $
CREATE PROCEDURE search_b(
IN evaluator varchar(30)
)
BEGIN
DECLARE employee_username varchar(30);
DECLARE job int(11); 
SELECT employee, job_id
FROM applications_history
WHERE evaluator_1 = evaluator OR evaluator_2 = evaluator;

END$
DELIMITER ;
# CALL search_b('Edee');

# FOR MESURING TIMES OF EXECUTION WITH INDEXES 3.1.3.4
/*
set profiling=1;
CALL search_a(6,13);
CALL search_b('Edee');
show profiles;
*/

############################################EndOF MyAdditionsFor 3.1.3.4#########################
