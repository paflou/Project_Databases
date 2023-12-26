DROP PROCEDURE IF EXISTS auto_grading;
DROP PROCEDURE IF EXISTS grade_applications;

DELIMITER $
CREATE PROCEDURE auto_grading(
candidate varchar(30), OUT grade int)
BEGIN
	DECLARE level enum('BSc', 'MSc', 'PhD');
    DECLARE project_num INT;
    DECLARE languages INT;
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



/*
-- 3.1.2.2--
DELIMITER $
CREATE PROCEDURE result_extraction(
job int, OUT Results varchar(30))
BEGIN
	DECLARE flag INT;
    DECLARE candidate varchar(30);
	DECLARE state ENUM ('active', 'canceled', 'finished');
    DECLARE winner varchar(30);
    
	DECLARE bcursor CURSOR FOR
    SELECT cand_usrname FROM applies
    where job_id = job;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag=1;
    set flag=0;

    OPEN bcursor;
	FETCH bcursor INTO candidate;

    WHILE (bcursor IS NOT NULL)
    DO       
        select application_status into state
        from applies
        where cand_usrname = candidate;
        
        UPDATE application_eval
        SET total_grade = (grade1 / grade2)/2
        WHERE cand_usrname = candidate;
        
		select grade1 from applies
        where cand_usrname = candidate
        
		FETCH bcursor INTO candidate;
	END WHILE;
    
		
	if(state != 'canceled')
	THEN

		SELECT cand_usrname INTO winner 
		FROM application_eval
        INNER JOIN applies ON applies.job_id = applications_eval.job_id
		WHERE total_grade = MAX(total_grade)
		ORDER BY insertion_time ASC limit 0,1;
	END IF;
    CLOSE bcursor;
END$
DELIMITER ;
*/