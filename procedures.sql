DROP PROCEDURE IF EXISTS auto_grading;
DELIMITER $
CREATE PROCEDURE auto_grading(
candidate varchar(30), OUT grade int)
BEGIN
	DECLARE level enum('BSc', 'MSc', 'PhD');
    DECLARE project_num INT;
    DECLARE languages INT;
    

    SELECT bathmida INTO level
    FROM degree
    inner join has_degree ON titlos = degr_title AND degr_idryma = idryma
    WHERE cand_usrname = candidate;
	
    set grade = 0;
    
    SET grade =
	CASE
		WHEN level = 'BSc' THEN 1
		WHEN level = 'MSc' THEN 2
		ELSE 3
	END;

    
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
CALL auto_grading('mark_smith',@res);
select @res;
*//*
-- 3.1.2.2--
DROP PROCEDURE IF EXISTS grade_applications;
DELIMITER $
CREATE PROCEDURE grade_applications(
job int, eval1 varchar(30), eval2 varchar(30), OUT Results varchar(30))
BEGIN
	DECLARE flag INT;
    DECLARE candidate varchar(30);
    DECLARE state varchar(30);
    
	DECLARE bcursor CURSOR FOR
    SELECT cand_usrname FROM applies
    where job_id = job;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag=1;
    set flag=0;
    
    OPEN bcursor;
    WHILE (bcursor IS NOT NULL)
    DO
		FETCH bcursor INTO candidate;
        
        select application_status into state
        from applies
        where cand_usrname = candidate;
        
        if(state != 'canceled')
		THEN
			if(grade1 = 0)
            THEN
				
            END IF;
		END IF;
	END WHILE;
    CLOSE bcursor;
END$
DELIMITER ;*/
