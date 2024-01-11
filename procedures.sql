DROP PROCEDURE IF EXISTS auto_grading;
DROP PROCEDURE IF EXISTS result_extraction;
DROP PROCEDURE IF EXISTS evaluators_grade;
DROP PROCEDURE IF EXISTS application_handler;

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

-- 3.1.3.1 -----------------------------------------------------------------------------
DELIMITER $
CREATE PROCEDURE evaluators_grade(
evaluator varchar(30), employee_username varchar(30), job int, OUT grade int)
BEGIN
	DECLARE grade_out int;
    
    SELECT grade1 INTO grade_out
    FROM application_eval
    INNER JOIN job ON job_id = id
    WHERE evaluator_1 = evaluator AND employee = employee_username AND job_id = job;
    
    IF grade_out IS NULL THEN
		SELECT grade2 INTO grade_out
		FROM application_eval
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
call evaluators_grade('john_doe', 'Alte1970', 1, @res);
select @res;
select * from application_eval;
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
	INSERT INTO applies VALUES(employee_username, job, DEFAULT, NOW());

    ELSEIF operation = 'c' THEN
		IF EXISTS(SELECT cand_usrname FROM applies WHERE cand_usrname = employee_username AND job_id = job AND application_status = 'active') THEN
			UPDATE applies
            SET application_status = 'canceled'
            WHERE cand_usrname = employee_username AND job_id = job AND application_status = 'active';
		    
        ELSE 
			SIGNAL SQLSTATE '45000'        
			SET MESSAGE_TEXT = 'Employee doesnt have active application or it has already been canceled';
		END IF;
	
    ELSEIF operation = 'a' THEN
		IF EXISTS(SELECT cand_usrname FROM applies WHERE cand_usrname = employee_username AND job_id = job AND application_status = 'canceled') THEN
			UPDATE applies
            SET application_status = 'active'
            WHERE cand_usrname = employee_username AND job_id = job AND application_status = 'canceled';
		ELSE 
			SIGNAL SQLSTATE '45000'        
			SET MESSAGE_TEXT = 'The application doesnt exist or employee already has active application for this position ';
		END IF;
	ELSE
		SIGNAL SQLSTATE '45000'        
		SET MESSAGE_TEXT = 'Wrong input! ';
    END IF;
    
	select 'Operation success! ';
END$
DELIMITER ;

/*
delete from applies;
select * from applies;
select * from job;
INSERT INTO application_eval VALUES ('Alte1970',2,'active',DEFAULT,DEFAULT,DEFAULT);
call application_handler('Alte1970', 2,'i');
call application_handler('Alte1970', 2,'c');
call application_handler('Alte1970', 2,'a');
call application_handler('Alte1970', 12,'c');
*/
-- 3.1.3.3-----------------------------------------------------------------------------------
DELIMITER $
CREATE PROCEDURE result_extraction(
job int, OUT Results varchar(30))
BEGIN
	DECLARE flag INT;
    DECLARE candidate varchar(30);
	DECLARE state ENUM ('active', 'canceled', 'finished');
    DECLARE winner varchar(30);
    DECLARE grade_1 int;
    DECLARE grade_2 int;
    DECLARE grade int;
    DECLARE evaluator1 varchar(30);
    DECLARE evaluator2 varchar(30);
    
	DECLARE bcursor CURSOR FOR
    SELECT cand_usrname FROM applies
    where job_id = job;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag=1;
    set flag=0;

    OPEN bcursor;
	FETCH bcursor INTO candidate;

    WHILE (flag=0)
    DO       
        select application_status into state
        from applies
        where cand_usrname = candidate AND job_id = job;
        
        SELECT evaluator_1, evaluator_2 INTO evaluator1, evaluator2
        FROM job
        WHERE id =job;
        
		UPDATE application_eval
		SET total_grade = total_grade
		WHERE employee = candidate AND job_id = job;
	
		SELECT total_grade INTO grade
        FROM application_eval
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
	FROM application_eval
	INNER JOIN applies ON applies.job_id = application_eval.job_id
	WHERE total_grade = (
    SELECT MAX(total_grade)
    FROM application_eval
	)
	ORDER BY insertion_time DESC limit 0,1;

    set Results = winner;
    
     DELETE FROM application_eval WHERE job_id = job;
     DELETE FROM applies WHERE job_id = job;
END$
DELIMITER ;

/*
select * from applies;
select * from application_eval;
select * from applications_history;
call result_extraction(2,@res);
select @res;
*/