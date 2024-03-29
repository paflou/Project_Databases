CREATE DATABASE IF NOT EXISTS proparaskeuastiko;
USE proparaskeuastiko;

-- Tables with constraints
DROP TABLE IF EXISTS applications_history;
DROP TABLE IF EXISTS requires;
DROP TABLE IF EXISTS applies;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS has_degree;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS applications_history;

-- Tables with no constraints
DROP TABLE IF EXISTS job;
DROP TABLE IF EXISTS log;
DROP TABLE IF EXISTS dba;
DROP TABLE IF EXISTS degree;
DROP TABLE IF EXISTS subject;
DROP TABLE IF EXISTS evaluator;
DROP TABLE IF EXISTS etaireia;
DROP TABLE IF EXISTS user;



CREATE TABLE IF NOT EXISTS etaireia(
AFM char(9) NOT NULL,
DOY varchar(30) DEFAULT 'unknown' NOT NULL,
name varchar(35) DEFAULT 'unknown' NOT NULL,
tel varchar(10) DEFAULT 'unknown' NOT NULL,
street varchar(15) DEFAULT 'unknown' NOT NULL,
num int(11) DEFAULT '0' NOT NULL,
city varchar(45) DEFAULT 'unknown' NOT NULL,
country varchar(15) DEFAULT 'unknown' NOT NULL,

PRIMARY KEY (AFM),
UNIQUE (tel)
);

CREATE TABLE IF NOT EXISTS user(
username varchar(30) NOT NULL,
password varchar(20) DEFAULT 'unknown' NOT NULL,
name varchar(25) DEFAULT 'unknown' NOT NULL,
lastname varchar(35) DEFAULT 'unknown' NOT NULL,
reg_date datetime NOT NULL,
email varchar(30) DEFAULT 'unknown' NOT NULL,

PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS evaluator(
username varchar(30) NOT NULL,
exp_years tinyint(4) DEFAULT '0' NOT NULL,
firm char(9) DEFAULT 'unknown' NOT NULL,

PRIMARY KEY (username),
CONSTRAINT username_con_1
FOREIGN KEY (firm)
REFERENCES etaireia(AFM)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT username_con_2
FOREIGN KEY (username)
REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS employee(
username varchar(30) NOT NULL,
bio text  NOT NULL,
diakriseis varchar(35) DEFAULT 'none' NOT NULL,
certificates varchar(35) DEFAULT 'none' NOT NULL,

PRIMARY KEY(username),
CONSTRAINT employ_con
FOREIGN KEY (username)
REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS languages(
candid varchar(30) DEFAULT 'unknown' NOT NULL,
lang set('EN', 'FR', 'SP', 'GE', 'CH', 'GR') ,

PRIMARY KEY (candid,lang),
CONSTRAINT languages_con
FOREIGN KEY(candid)
REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS project(	
candid varchar(30) DEFAULT 'unknown' NOT NULL,
num tinyint(4) NOT NULL,
descr text  NOT NULL,
url varchar(60) DEFAULT 'unknown' NOT NULL,

PRIMARY KEY(candid,num),
CONSTRAINT project_con
FOREIGN KEY(candid)
REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS degree(
titlos varchar(150) DEFAULT 'unknown' NOT NULL,
idryma  varchar(150) DEFAULT 'unknown' NOT NULL,
bathmida enum('BSc', 'MSc', 'PhD'),

PRIMARY KEY( titlos, idryma,bathmida)
);

CREATE TABLE IF NOT EXISTS has_degree(
degr_title varchar(150) DEFAULT 'unknown' NOT NULL,
degr_idryma varchar(150) DEFAULT 'unknown' NOT NULL,
cand_usrname varchar(30) DEFAULT 'unknown' NOT NULL,
etos year(4) NOT NULL,
grade float DEFAULT '0' NOT NULL,

PRIMARY KEY(degr_title, degr_idryma, cand_usrname),
CONSTRAINT has_degree_con_1
FOREIGN KEY (cand_usrname)
REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT has_degree_con_2
FOREIGN KEY(degr_title, degr_idryma)
REFERENCES degree(titlos, idryma)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS job(
id int(11) 	NOT NULL AUTO_INCREMENT,
start_date date NOT NULL,
salary float DEFAULT '0' NOT NULL,
position varchar(60) DEFAULT 'unknown' NOT NULL,
edra varchar(60) DEFAULT 'unknown' NOT NULL,
evaluator_1 varchar(30) DEFAULT NULL,
evaluator_2 varchar(30) DEFAULT NULL,
announce_date datetime NOT NULL,
submission_date date NOT NULL,

PRIMARY KEY(id),
CONSTRAINT job_con
FOREIGN KEY(evaluator_1)
REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT job_con2
FOREIGN KEY(evaluator_2)
REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

-- applies ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS applies(
employee varchar(30) NOT NULL,
job_id int(11) NOT NULL,
application_status ENUM ('active', 'canceled', 'finished') DEFAULT 'active',
insertion_time DATETIME DEFAULT NOW(),
grade1 int DEFAULT -1,
grade2 int DEFAULT -1,
total_grade int DEFAULT 0,

PRIMARY KEY(employee, job_id,application_status),
CONSTRAINT applies_con_1
FOREIGN KEY (employee)
REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT applies_con_2
FOREIGN KEY(job_id)
REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS subject(
title varchar(36) DEFAULT 'unknown' NOT NULL,
descr tinytext NOT NULL,
belongs_to varchar(36) DEFAULT 'unknown',
#katastash ENUM ('active', 'canceled', 'finished'),	

PRIMARY KEY(title),
CONSTRAINT subject_con
FOREIGN KEY (belongs_to)
REFERENCES subject(title)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS requires(
job_id int(11) NOT NULL,
subject_title varchar(36) DEFAULT 'unknown' NOT NULL,

PRIMARY KEY (job_id, subject_title),
CONSTRAINT requires_con_1
FOREIGN KEY (job_id)
REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT requires_con_2
FOREIGN KEY (subject_title)
REFERENCES subject(title)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS applications_history(
evaluator_1 varchar(30),
evaluator_2 varchar(30),
employee varchar(30) NOT NULL,
job_id int(11) 	NOT NULL,
application_status ENUM ('active', 'canceled', 'finished'),		#την κατάσταση (ολοκληρωμένη) ???  orthografiko gia na tairiazei me csv
grade int DEFAULT '0' NOT NULL,

PRIMARY KEY (employee, job_id, application_status)
);

##################################3.1.3.4 MyPartForIndexes#############################
#DROP INDEX idx_grade ON applications_history;
#DROP INDEX idx_evaluator_1 ON applications_history;
#DROP INDEX idx_evaluator_2 ON applications_history;
#SHOW INDEXES FROM applications_history;

CREATE INDEX idx_grade On applications_history(grade);
CREATE INDEX idx_evaluator_1 On applications_history(evaluator_1);
CREATE INDEX idx_evaluator_2 On applications_history(evaluator_2);
##################################EndOf 3.1.3.4 MyPartForIndexes########################

CREATE TABLE IF NOT EXISTS dba(
username varchar(30) NOT NULL,
start_date date NOT NULL,
end_date date,

PRIMARY KEY (username),
CONSTRAINT dba_con
FOREIGN KEY (username)
REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS log(
change_id int(11) 	NOT NULL AUTO_INCREMENT,
changes ENUM('INSERT', 'UPDATE', 'DELETE'),		#allagh se kefalaia
changed_tables ENUM('job', 'user', 'degree'),
change_time datetime NOT NULL,
username varchar(30),

PRIMARY KEY(change_id),
CONSTRAINT log_con
foreign key (username)
REFERENCES dba(username)
ON DELETE SET NULL ON UPDATE CASCADE
);
