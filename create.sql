DROP DATABASE IF EXISTS proparaskeuastiko;
CREATE DATABASE IF NOT EXISTS proparaskeuastiko;
USE proparaskeuastiko;
#Drop database proparaskeuastiko;


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

PRIMARY KEY (username),
UNIQUE(password)
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
sistatikes varchar(35) DEFAULT 'none' NOT NULL,
certificates varchar(35) DEFAULT 'none' NOT NULL,

PRIMARY KEY(username),
CONSTRAINT employ_con
FOREIGN KEY (username)
REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS langueges(
candid varchar(30) DEFAULT 'unknown' NOT NULL,
lang set('EN', 'FR', 'SP', 'GE', 'CH', 'GR') ,

PRIMARY KEY (candid,lang),
CONSTRAINT langueges_con
FOREIGN KEY(candid)
REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS project(		#to num den leitourgei sosta, diabase perigrafh.Eftaksa trigger pou to lunei ayto.
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

PRIMARY KEY( titlos, idryma)
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
evaluator varchar(30) NOT NULL,
announce_date datetime NOT NULL,
submission_date date NOT NULL,

PRIMARY KEY(id),
CONSTRAINT job_con
FOREIGN KEY(evaluator)
REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS applies(
cand_usrname varchar(30) NOT NULL,
job_id int(11) NOT NULL,

PRIMARY KEY(cand_usrname, job_id),
CONSTRAINT applies_con_1
FOREIGN KEY (cand_usrname)
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
evaluator_1 varchar(30) NOT NULL,
evaluator_2 varchar(30) NOT NULL,
employee varchar(30) NOT NULL,
job_id int(11) 	NOT NULL,
application_condition ENUM ('active', 'canceled', 'finished'),		#την κατάσταση (ολοκληρωμένη) ???
grade int DEFAULT '0' NOT NULL,

PRIMARY KEY (evaluator_1,evaluator_2,employee,job_id)
);

CREATE TABLE IF NOT EXISTS dba(
username varchar(30) NOT NULL,
start_date date NOT NULL,
end_date date,

PRIMARY KEY (username),
CONSTRAINT dba_con
FOREIGN KEY (username)
REFERENCES user(username)
);

CREATE TABLE IF NOT EXISTS log(
change_id int(11) 	NOT NULL AUTO_INCREMENT,
changes ENUM('insertion', 'update', 'deletion'),
changed_tables ENUM('job', 'user', 'degree'),
change_time datetime NOT NULL,
username varchar(30) NOT NULL,

PRIMARY KEY(change_id)
);





