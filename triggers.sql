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


DROP TRIGGER IF EXISTS Application_Status;
DELIMITER $
CREATE TRIGGER Application_Status
BEFORE INSERT ON applies
FOR EACH ROW
BEGIN
	DECLARE applications int;
    DECLARE job_start date;
    
    select count(*) into applications
    from applies
    where cand_usrname = new.cand_usrname;
    
    select job.start_date into job_start
    from job
    where job.id = new.job_id;
    
	IF(applications >= 3 OR DATEDIFF(job_start, DATE( NOW() ) ) > 15)
    THEN
		SIGNAL SQLSTATE '45000'        
		SET MESSAGE_TEXT = 'Employee cannot apply for this position';
	END IF;
END $
DELIMITER ;

				/* ta triggers gia to erotima 3.1.4.1.*/

-- SET @context_info = SUBSTRING_INDEX(CURRENT_USER(), '@', 1);
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
