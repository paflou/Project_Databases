DROP PROCEDURE IF EXISTS auto_grading;
DROP PROCEDURE IF EXISTS result_extraction;

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

-- 3.1.2.2-----------------------------------------------------------------------------------
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
        FROM application_eval
        WHERE job_id =job AND employee = candidate;
        
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
