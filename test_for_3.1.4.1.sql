show tables;

SELECT DISTINCT USER FROM information_schema.processlist;
SELECT CURRENT_USER();

INSERT INTO job (id, start_date, salary, position, edra, evaluator, announce_date, submission_date)
VALUES (NULL, '2023-01-15', 50000, 'Software Engineer', 'Athens', 'john_doe', '2022-12-01', '2022-12-15');

DELETE FROM job
WHERE id= 9;

UPDATE job
SET salary = 69
WHERE id = 10;


INSERT INTO user (username, password, name, lastname, reg_date, email) VALUES		
('mark_andersonhuh', 'marhihkpass123', 'Mark', 'Anderson', '2023-07-12 09:30:00', 'mark.anderson@example.com');

UPDATE user
SET email = 'lol@gmail.com'
WHERE username = 'mark_andersonhuh';

DELETE FROM user 
WHERE username = 'mark_andersonhuh';


INSERT INTO degree (titlos, idryma, bathmida) VALUES
('loll', 'University ', 'BSc');

UPDATE degree
SET titlos = 'haha'
WHERE titlos = 'loll';

DELETE FROM degree
WHERE titlos = 'haha';


select * from job;
SELECT * from user;
select * from degree;
select * from log;

