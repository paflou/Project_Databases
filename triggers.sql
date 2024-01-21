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
    where employee = new.employee AND application_status = 'active';
    
    select job.start_date into job_start
    from job
    where job.id = new.job_id;
    
	IF(applications >= 3 OR DATEDIFF(job_start, DATE( NOW() ) ) < 15)
    THEN
		SIGNAL SQLSTATE '45000'        
		SET MESSAGE_TEXT = 'ERROR: Employee cannot apply for this position ';
	END IF;
END $
DELIMITER ;

/*
-- make a job less than 15 days away
INSERT INTO job VALUES 
(NULL, DATE_ADD(DATE(NOW()), INTERVAL 14 DAY), 50000.00, 'TEST', 'TEST', 'john_doe', 'alice_smith', '2025-01-05 08:00:00', '2025-02-01');
-- see the job id
select id from job order by id DESC limit 1;

-- try to insert an application for this job
INSERT INTO applies VALUES
('mark_smith', 17, DEFAULT, NOW(), 15, 18, DEFAULT);

-- see how many active applicaitons hunitesige has 
select employee, job_id, application_status from applies where employee = "Hunitesige";
-- try to insert another
INSERT INTO applies VALUES
('Hunitesige', 8, DEFAULT, NOW(), 15, 18, DEFAULT);
*/



-- 3.1.4.3 --------------------------------------------
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
    where employee = new.employee AND application_status = 'active';

    
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
/*
 -- TEST FOR 3.1.4.3
 -- create a job
 INSERT INTO job VALUES
(NULL, '2024-03-11', 50000.00, 'IT Support Specialist', 'Athens', 'john_doe', 'alice_smith', '2023-01-05 08:00:00', '2024-01-15');

-- see the job_id
select id from job order by id DESC limit 1;
-- Make an application for this job
call application_handler('Alte1970', 18,'i'); 

-- make it so the job starts in less than 10 days
update job
SET start_date = DATE_ADD(DATE(NOW()), INTERVAL 9 DAY)
WHERE id =18;
-- try to cancel his application
call application_handler('Alte1970', 18,'c'); 

-- see active applications for x employee
select employee, job_id, application_status from applies where employee = "Hunitesige";
-- cancel his third application
call application_handler('Hunitesige', 4,'c');
-- make a new one
call application_handler('Hunitesige', 7,'i');
-- try to activate his canceled application
call application_handler('Hunitesige', 4,'a');
*/


