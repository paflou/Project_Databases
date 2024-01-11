DROP TRIGGER IF EXISTS project_trigger;
DROP TRIGGER IF EXISTS Application_Status;
DROP TRIGGER IF EXISTS job_trigger_1;
DROP TRIGGER IF EXISTS job_trigger_2;
DROP TRIGGER IF EXISTS job_trigger_3;
DROP TRIGGER IF EXISTS user_trigger_1;
DROP TRIGGER IF EXISTS user_trigger_2;
DROP TRIGGER IF EXISTS user_trigger_3;
DROP TRIGGER IF EXISTS degree_trigger_1;
DROP TRIGGER IF EXISTS degree_trigger_2;
DROP TRIGGER IF EXISTS degree_trigger_3;
DROP TRIGGER IF EXISTS evaluation;
DROP TRIGGER IF EXISTS auto_applies;
DROP TRIGGER IF EXISTS cancel_enable_prevention;

DELIMITER $
CREATE TRIGGER project_trigger
BEFORE INSERT ON project
FOR EACH ROW
BEGIN
DECLARE max_num INT;

# Get the maximum num for the current employee
SELECT MAX(num) INTO max_num
FROM project
WHERE candid= NEW.candid;

# Set the new num value
SET NEW.num = COALESCE(max_num, 0) + 1;

END $
DELIMITER ;

-- 3.1.4.2 ----------------------------------------------
DELIMITER $
CREATE TRIGGER Application_Status
BEFORE INSERT ON applies
FOR EACH ROW
BEGIN
	DECLARE applications int;
    DECLARE job_start date;
    
    select count(*) into applications
    from applies
    where cand_usrname = new.cand_usrname AND application_status = 'active';
    
    select job.start_date into job_start
    from job
    where job.id = new.job_id;
    
	IF(applications >= 3 OR DATEDIFF(job_start, DATE( NOW() ) ) > 15)
    THEN
		SIGNAL SQLSTATE '45000'        
		SET MESSAGE_TEXT = 'ERROR: Employee cannot apply for this position ';
	END IF;
END $
DELIMITER ;

				/* ta triggers gia to erotima 3.1.4.1.*/

DELIMITER $
CREATE TRIGGER job_trigger_1
AFTER INSERT ON job
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
SET t_username = SUBSTRING_INDEX(USER(),'@',1);


IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('INSERT', 'job', now(), t_username);
END IF;

END $
DELIMITER ;
---------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER job_trigger_2
AFTER DELETE ON job
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('DELETE', 'job', now(), t_username);
END IF;

END $
DELIMITER ;
---------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER job_trigger_3
AFTER UPDATE ON job
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('UPDATE', 'job', now(), t_username);
END IF;

END $
DELIMITER ;
----------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER user_trigger_1
AFTER INSERT ON user
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('INSERT', 'user', now(), t_username);
END IF;

END $
DELIMITER ;
---------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER user_trigger_2
AFTER DELETE ON user
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('DELETE', 'user', now(), t_username);
END IF;

END $
DELIMITER ;
---------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER user_trigger_3
AFTER UPDATE ON user
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('UPDATE', 'user', now(), t_username);
END IF;

END $
DELIMITER ;
----------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER degree_trigger_1
AFTER INSERT ON degree
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('INSERT', 'degree', now(), t_username);
END IF;

END $
DELIMITER ;
---------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER degree_trigger_2
AFTER DELETE ON degree
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('DELETE', 'degree', now(), t_username);
END IF;

END $
DELIMITER ;
---------------------------------------------------------------------------
DELIMITER $
CREATE TRIGGER degree_trigger_3
AFTER UPDATE ON degree
FOR EACH ROW
BEGIN
DECLARE t_username VARCHAR(30);
    
SET t_username = SUBSTRING_INDEX(USER(),'@',1);

-- Now t_username contains the extracted username

IF t_username <> 'root' THEN
INSERT INTO log (changes, changed_tables, change_time, username)
VALUES('UPDATE', 'degree', now(), t_username);
END IF;

END $
DELIMITER ;

-- 3.1.2.2 ---------------------------------------------------------------
DELIMITER $
CREATE TRIGGER evaluation
BEFORE UPDATE ON application_eval
FOR EACH ROW
BEGIN
	DECLARE state ENUM ('active', 'canceled', 'finished');
    DECLARE grade1_result INT;
	DECLARE grade2_result INT;
        

	
	if(OLD.application_status != 'canceled')
	THEN
		IF(OLD.grade1 = 0)
        THEN
			CALL auto_grading(NEW.employee,grade1_result);
            set NEW.grade1 = grade1_result;
        END IF;
        
		IF(OLD.grade2 = 0)
        THEN
			CALL auto_grading(NEW.employee,grade2_result);
            set NEW.grade2 = grade2_result;
        END IF;
        
        SET NEW.total_grade = (NEW.grade1 + NEW.grade2) / 2;
        
	ELSE
		SET NEW.total_grade = 0;
	END IF;
END$
DELIMITER ;

DELIMITER $
CREATE TRIGGER cancel_enable_prevention
BEFORE UPDATE ON applies
FOR EACH ROW
BEGIN
	DECLARE starting_date DATE;
    DECLARE applications INT;
    

	SELECT start_date INTO starting_date
    FROM job 
    WHERE job.id = old.job_id;

    select count(*) into applications
    from applies
    where cand_usrname = new.cand_usrname;

    
	IF(applications >= 3 AND new.application_status = 'active')
    THEN
		SIGNAL SQLSTATE '45000'        
		SET MESSAGE_TEXT = 'ERROR: Employee already has 3 active applications ';
	END IF;
    
	IF new.application_status = 'canceled' and old.application_status !='canceled' THEN
		IF starting_date - CURDATE() < 10 THEN
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'ERROR: Starting date is less than 10 days away ';
		END IF;
    END IF;
END$
DELIMITER ;


INSERT INTO job VALUES
(NULL, '2023-01-15', 50000.00, 'IT Support Specialist', 'Athens', 'john_doe', 'alice_smith', '2023-01-05 08:00:00', '2024-01-15');
select * from job

/*
call application_handler('Alte1970', 17,'i');
call application_handler('Alte1970', 17,'c');
call application_handler('Alte1970', 3,'a');
call application_handler('emily_wilson', 2,'a');
select * from applies;
*/




/* -- PROBABLY NOT NEEDED
DELIMITER $
CREATE TRIGGER auto_applies
BEFORE INSERT ON application_eval
FOR EACH ROW
BEGIN
	DECLARE flag int;
    
    SELECT job_id INTO flag
    FROM applies
    WHERE new.employee = cand_usrname AND applies.job_id = new.job_id;
    
    IF ( flag IS NULL )
	THEN
		INSERT INTO applies VALUES
        (new.employee, new.job_id, new.application_status, NOW());
    END IF;
END $
DELIMITER ;

*/