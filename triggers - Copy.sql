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






