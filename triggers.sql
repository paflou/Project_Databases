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


DELIMITER $
CREATE TRIGGER subject_trigger
BEFORE INSERT ON subject
FOR EACH ROW
BEGIN
DECLARE x int;				#x =0 tote start_Date - curdate < 15
DECLARE Start_Date date;		#Sart_Date eiani to start _date poy pairno apo ton pinaka job

SELECT j.start_date
INTO Start_Date
FROM applies a
LEFT JOIN job j ON a.job_id = j.id
WHERE a.cand_usrname = NEW.cand_usrname;

IF DATE_ADD ( Start_Date, INTERVAL 15



