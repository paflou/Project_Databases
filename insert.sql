INSERT INTO etaireia (AFM, DOY, name, tel, street, num, city,country) VALUES
('111111111', 'Δ.Ο.Υ. Α ΠΑΤΡΩΝ', 'h gonia tou mpamph', '2610422055', 'konstantinou', 25, 'patras', 'Greece'),
('222222222', 'Δ.Ο.Υ. Α ΠΑΤΡΩΝ', 'geush', '2610451397', 'stratioth', 40, 'patras', 'Greece'),
('333333333', 'Δ.Ο.Υ. Α ΑΘΗΝΑΣ', 'crust', '2731098989', 'amerikhs', 107, 'athens', 'Greece'),
('444444444', 'Δ.Ο.Υ. Β ΑΘΗΝΑΣ', 'lux', '2731076543', 'agiou', 303, 'athens', 'Greece'),
('555555555', 'D.O.Y. G GERMANY', 'bruchten', '355567665', 'deuchspiel', 55, 'berlin', 'Germany'),
('666666666', 'D.O.Y. G SPAIN', 'the amazest hotel', '4653422436', 'elf street', 299, 'las palmas', 'Spain');
# select * from etaireia;

INSERT INTO etaireia VALUE
(777777777,'Δ.Ο.Υ. ΗΡΑΚΛΕΙΟΥ','RUNG','2810334006','SILICON VALLEY',11,'HERAKLION','GREECE'),
(888888888,'Δ.Ο.Υ. Α ΠΑΤΡΩΝ','YOUCHEWB','2610987665','EL. STRATIOTOU',33,'PATRAS','GREECE'),
(999999999,'Δ.Ο.Υ. Α ΖΑΚΥΝΘΟΥ','LEyesVO','2945033944','KORINTHOU',123,'ZAKINTHOS','GREECE');

INSERT INTO user (username, password, name, lastname, reg_date, email) VALUES		# for evaluator
('john_doe', 'password123', 'John', 'Doe', '2023-01-01 12:00:00', 'john.doe@example.com'),
('alice_smith', 'pass456', 'Alice', 'Smith', '2023-02-15 15:30:00', 'alice.smith@example.com'),
('bob_jones', 'secure789', 'Bob', 'Jones', '2023-03-20 10:45:00', 'bob.jones@example.com'),
('emma_wilson', 'emma123', 'Emma', 'Wilson', '2023-04-05 08:15:00', 'emma.wilson@example.com'),
('alex_miller', 'pass123', 'Alex', 'Miller', '2023-05-10 17:00:00', 'alex.miller@example.com'),
('sara_jackson', 'sara456', 'Sara', 'Jackson', '2023-06-25 14:20:00', 'sara.jackson@example.com');
#select * from user;

INSERT INTO user VALUES
('johnnyboy','1234','John','Adams','2023-11-14','johnny420@gmail.com'),
('jacko','4321','Jack','Jones','2021-01-14 12:11:59','jackOlantern@gmail.com'),
('Mucas1940','Di6nee','Amanda','Peters','2020-11-11 14:02:02','AmandaLPeters@armyspy.com'),
('Ancingingen','zah0Keg2c','Terry','Dodd','2023-12-05 17:05:02','TerryLDodd@armyspy.com'),
('Alke1996','taeKe3NieSh','Milton','McSherry','2021-02-11 14:13:55','MiltonSMcSherry@dayrep.com'),
('DreamyCoder', 'SecurePass789', 'Emma', 'Johnson', '1989-03-15', 'emma.johnson@example.com'),
('Fortume','biJ8lue7lah','Thomas','Martin','2019-11-26 20:45:34','ThomasTMartin@armyspy.com'),
('Yeepy','Eishi2Achae','Earl','Martin','2015-10-11 09:14:16','EarlRMartin@rhyta.com'),
('Pilve1984','naiCh6uph7','Martin','Gordon','2009-05-25 14:14:14','MadelineGordon@jourrapide.com'),
('Tord2003','YeeK0mi4','George','Alexander','2022-03-15 15:04:29','GeorgeAlexander@armyspy.com'),
('Alte1970','Beihoa3xoh','keir','Munro','2021-01-21 09:16:00','KeirMunro@rhyta.com'),
('Hunitesige','Hephae7ai','Drew','Moore','2020-06-30 16:30:46','DrewMoore@rhyta.com');


INSERT INTO user (username, password, name, lastname, reg_date, email) VALUES 		#for employee
('mark_smith', 'mark789', 'Mark', 'Smith', '2023-07-10 09:30:00', 'mark.smith@example.com'),
('lisa_jones', 'lisa456', 'Lisa', 'Jones', '2023-08-15 13:45:00', 'lisa.jones@example.com'),
('kevin_davis', 'kevin123', 'Kevin', 'Davis', '2023-09-20 18:00:00', 'kevin.davis@example.com'),
('natalie_white', 'natalie456', 'Natalie', 'White', '2023-10-05 11:15:00', 'natalie.white@example.com'),
('steve_martin', 'steve789', 'Steve', 'Martin', '2023-11-10 14:45:00', 'steve.martin@example.com'),
('emily_wilson', 'emily123', 'Emily', 'Wilson', '2023-12-25 20:30:00', 'emily.wilson@example.com');
#select * from user;

INSERT INTO user (username, password, name, lastname, reg_date, email) VALUES		# for dba
('mark_anderson', 'markpass123', 'Mark', 'Anderson', '2023-07-12 09:30:00', 'mark.anderson@example.com'),
('laura_white', 'laura789', 'Laura', 'White', '2023-08-18 13:45:00', 'laura.white@example.com'),
('kevin_martin', 'kevinpass', 'Kevin', 'Martin', '2023-09-22 11:00:00', 'kevin.martin@example.com'),
('natalie_green', 'natalie123', 'Natalie', 'Green', '2023-10-30 16:15:00', 'natalie.green@example.com'),
('michael_turner', 'mike456', 'Michael', 'Turner', '2023-11-05 20:00:00', 'michael.turner@example.com'),
('olivia_carter', 'olivia123', 'Olivia', 'Carter', '2023-12-15 18:30:00', 'olivia.carter@example.com');
#select * from user;

INSERT INTO evaluator (username, exp_years, firm) VALUES
('john_doe', 3, '111111111'),
('alice_smith', 5, '222222222'),
('bob_jones', 2, '333333333'),
('emma_wilson', 4, '444444444'),
('alex_miller', 6, '555555555'),
('sara_jackson', 1, '666666666');
# select * from evaluator;

INSERT INTO evaluator VALUE
('Ancingingen',1,'777777777'),
('johnnyboy',3,'888888888'),
('jacko',1,'999999999'),
('Mucas1940',6,'888888888'),
('Alke1996',2,'777777777'),
('DreamyCoder',11,'888888888');


INSERT INTO employee (username, bio, sistatikes, certificates) VALUES
('mark_smith', 'Experienced IT professional with a focus on technical support.', 'IT Support Specialist', 'CompTIA A+'),
('lisa_jones', 'Dedicated finance professional with expertise in financial analysis.', 'Financial Analyst', 'CFA Level 1'),
('kevin_davis', 'Detail-oriented individual with skills in manufacturing processes.', 'Production Coordinator', 'Six Sigma Green Belt'),
('natalie_white', 'Compassionate healthcare professional committed to patient care.', 'Registered Nurse', 'BLS, ACLS'),
('steve_martin', 'Creative marketing specialist with a proven track record of successful campaigns.', 'Marketing Specialist', 'Google Ads Certification'),
('emily_wilson', 'Passionate educator fostering a positive learning environment.', 'Teacher', 'Teaching Certification');
# select * from employee;

INSERT INTO employee VALUES
('Fortume','Software Engineer','John Smith','Certified in Software Engineering'),
('Yeepy','Digital Marketer','Jane Doe','Certified in Digital Marketing'),
('Pilve1984','Graphic Designer','Alex Johnson','Certified in Graphic Design'),
('Tord2003','UI/UX Designer','Emily Williams','Certified in UI/UX Design'),
('Alte1970','Front-end Developer','Michael Brown','Certified in JavaScript Frameworks'),
('Hunitesige','Web Developer','Sarah Miller','Certified in Full Stack Development');

INSERT INTO languages (candid, lang) VALUES
('mark_smith', 'EN,FR'),
('lisa_jones', 'SP'),
('kevin_davis', 'EN,CH'),
('natalie_white', 'EN'),
('steve_martin', 'FR,GE'),
('emily_wilson', 'SP,CH');
# select * from languages;

INSERT INTO languages VALUE
('Fortume','GR,EN'),
('Yeepy','FR,SP,GR'),
('Pilve1984','EN,CH,GR'),
('Alte1970','FR,SP,GR,EN');


INSERT INTO project (candid, num, descr, url) VALUES
('mark_smith', 1, 'IT Support System Upgrade', 'https://example.com/project1'),
('lisa_jones', 1, 'Financial Analysis Tool Development', 'https://example.com/project2'),
('kevin_davis', 1, 'Manufacturing Process Optimization', 'https://example.com/project3'),
('natalie_white', 1, 'Patient Care App Implementation', 'https://example.com/project4'),
('steve_martin', 1, 'Marketing Campaign for Product Launch', 'https://example.com/project5'),
('emily_wilson', 1, 'Educational Platform Enhancement', 'https://example.com/project6'),
('lisa_jones', 1, 'mysql projecgt', 'htps://example.com/project7');
 #select * from project;
 
 INSERT INTO project VALUES
('Hunitesige',1,'Web Development for XYZ Corp','www.xyzcorp.com'),
('Hunitesige',2,'Mobile App Design for ABC Inc','www.abcinc.com'),
('Hunitesige',3,'Data Analysis for DEF Company','www.defcompany.com'),
('Tord2003',1,'UI/UX Redesign for GHI Industries','www.ghiindustries.com'),
('Yeepy',1,'Marketing Campaign for JKL Enterprises','www.jklenterprises.com'),
('Fortume',1,'Software Development for MNO Ltd','www.mnoltd.com'),
('Pilve1984',1,'Graphic Design for PQR Co.','www.pqrco.com');



INSERT INTO job (id, start_date, salary, position, edra, evaluator, announce_date, submission_date) VALUES
(NULL, '2023-01-15', 50000.00, 'IT Support Specialist', 'Athens', 'john_doe', '2023-01-05 08:00:00', '2023-02-01'),
(NULL, '2023-02-20', 60000.00, 'Financial Analyst', 'Paris', 'alice_smith', '2023-02-10 10:30:00', '2023-03-01'),
(NULL, '2023-03-25', 70000.00, 'Production Coordinator', 'Berlin', 'bob_jones', '2023-03-15 12:45:00', '2023-04-01'),
(NULL, '2023-04-10', 55000.00, 'Registered Nurse', 'Madrid', 'emma_wilson', '2023-04-01 15:15:00', '2023-05-01'),
(NULL, '2023-05-15', 65000.00, 'Marketing Specialist', 'London', 'alex_miller', '2023-05-05 17:30:00', '2023-06-01'),
(NULL, '2023-06-20', 75000.00, 'Teacher', 'Barcelona', 'sara_jackson', '2023-06-10 20:45:00', '2023-07-01'),
(NULL, '2023-07-15', 80000.00, 'Software Developer', 'Munich', 'john_doe', '2023-07-05 08:30:00', '2023-08-01'),
(NULL, '2023-08-20', 90000.00, 'Data Scientist', 'Amsterdam', 'emma_wilson', '2023-08-10 11:00:00', '2023-09-01');
# select * from job;

INSERT INTO job VALUE
(DEFAULT,'2023-12-12', 60000.00, 'MECHANICAL ENGINEER','PATRAS','jacko','2015-12-13 08:15:34','2015-12-23'),
(DEFAULT,'2023-01-15', 50000.00, 'Software Engineer', 'New York', 'Ancingingen', '2023-01-10 08:00:00', '2023-02-28'),
(DEFAULT,'2023-02-20', 60000.00, 'Data Analyst', 'California', 'johnnyboy', '2023-02-15 10:30:00', '2023-04-15'),
(DEFAULT,'2023-03-10', 70000.00, 'Marketing Manager', 'Texas', 'jacko', '2023-03-05 12:45:00', '2023-05-30'),
(DEFAULT,'2023-04-05', 55000.00, 'Financial Advisor', 'Florida', 'Mucas1940', '2023-03-30 09:15:00', '2023-06-10'),
(DEFAULT,'2023-05-22', 65000.00, 'HR Specialist', 'Washington', 'Alke1996', '2023-05-15 11:00:00', '2023-07-20'),
(DEFAULT,'2023-06-30', 75000.00, 'Project Manager', 'Illinois', 'DreamyCoder', '2023-06-25 14:20:00', '2023-08-31'),
(DEFAULT,'2023-07-12', 58000.00, 'Sales Representative', 'Arizona', 'Ancingingen', '2023-07-05 09:45:00', '2023-09-25');


INSERT INTO applies (cand_usrname, job_id) VALUES
('mark_smith', 1),
('lisa_jones', 2),
('kevin_davis', 3),
('natalie_white', 1),
('steve_martin', 2),
('emily_wilson', 1);
# select * from applies;

INSERT INTO applies VALUE
('Tord2003',1),
('Pilve1984',2),
('Yeepy',3),
('Alte1970',4),
('Hunitesige',5),
('Fortume',6);


INSERT INTO degree (titlos, idryma, bathmida) VALUES
('Computer Science and Math', 'University of Athens', 'BSc'),
('Finance', 'Paris University', 'MSc'),
('Engineering', 'Berlin Technical University', 'PhD'),
('Nursing', 'Madrid Nursing School', 'BSc'),
('Marketing and Math', 'London Business School', 'MSc'),
('Education', 'Barcelona Education Institute', 'PhD');
# select * from degree;

INSERT INTO degree VALUE
('Computer Engineering', 'University of Patras', 'MSc'),
('Electrical Engineering', 'Massachusetts Institute of Technology', 'PhD'),
('Data Science', 'Stanford University', 'MSc'),
('Mechanical Engineering', 'University of Cambridge', 'PhD'),
('Civil Engineering', 'ETH Zurich', 'MSc'),
('Computer Science', 'Harvard University', 'PhD');


INSERT INTO has_degree (degr_title, degr_idryma, cand_usrname, etos, grade) VALUES
('Computer Science and Math', 'University of Athens', 'mark_smith', 2018, 3.5),
('Finance', 'Paris University', 'lisa_jones', 2020, 4.0),
('Engineering', 'Berlin Technical University', 'kevin_davis', 2015, 3.8),
('Nursing', 'Madrid Nursing School', 'natalie_white', 2019, 3.7),
('Marketing and Math', 'London Business School', 'steve_martin', 2022, 4.2),
('Education', 'Barcelona Education Institute', 'emily_wilson', 2017, 3.9);
# select * from has_degree;

INSERT INTO has_degree VALUE
('Computer Engineering', 'University of Patras','Fortume',2018,8.45),
('Electrical Engineering', 'Massachusetts Institute of Technology','Pilve1984',2020,7.45),
('Data Science', 'Stanford University','Hunitesige',2016,7.85),
('Computer Science', 'Harvard University','Yeepy',2020,9.50);


INSERT INTO subject (title, descr, belongs_to) VALUES
('Math', 'Mathematics', NULL),
('Algebra', 'Basic algebra concepts', 'Math'),
('Geometry', 'Geometry principles', 'Math'),	#for check
('Calculus', 'Calculus principles', 'Math'),
('Physics', 'Study of matter and energy', NULL),
('Mechanics', 'Study of motion and forces', 'Physics'),
('English', 'basic knowledge', NULL),
('Academic Skills', 'basic academic skills', NULL);
# select * from subject;

 #(parent rows)
INSERT INTO subject (title, descr,belongs_to) VALUES
('Web Development', 'Creating dynamic and responsive websites using modern technologies.',NULL),
('JavaScript Fundamentals', 'Fundamental concepts and syntax of JavaScript programming language.',NULL),
('CSS Styling', 'Cascading Style Sheets for web page styling and design.',NULL);

#(child rows)
INSERT INTO subject (title, descr, belongs_to) VALUES
('HTML Basics', 'Introduction to HTML tags, structure, and elements.', 'Web Development'),
('React Framework', 'Building interactive UIs using the React library.', 'JavaScript Fundamentals'),
('Node.js Backend', 'Building server-side applications using Node.js.', 'JavaScript Fundamentals'),
('Database Management', 'Introduction to SQL, database design, and management.', 'Web Development'),
('Responsive Design', 'Optimizing websites for various devices and screen sizes.', 'CSS Styling');


INSERT INTO requires (job_id, subject_title) VALUES
(1, 'Math'),
(1, 'Physics'),
(2, 'Math'),
(2, 'Algebra'),
(2, 'Mechanics'),
(3, 'Geometry'),	#for check
(1, 'Algebra'),
(2, 'Physics'),
(4,'Mechanics');
# select * from requires;

INSERT INTO requires VALUES
(1, 'Web Development'),
(2, 'HTML Basics'),
(3, 'CSS Styling'),
(4, 'JavaScript Fundamentals'),
(5, 'React Framework'),
(6, 'Node.js Backend'),
(7, 'Database Management'),
(8, 'Responsive Design');




INSERT INTO dba (username, start_date, end_date) VALUES
('mark_anderson', '2023-07-12', NULL),
('laura_white', '2023-08-18', NULL),
('kevin_martin', '2023-09-22', NULL),
('natalie_green', '2023-10-30', NULL),
('michael_turner', '2023-11-05', NULL),
('olivia_carter', '2023-12-15', NULL);
# select * from dba;


LOAD DATA INFILE "myFile0.csv" INTO TABLE applications_history
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

#select * from applications_history;
