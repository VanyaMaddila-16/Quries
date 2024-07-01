create database timesheet;
use timesheet;
CREATE TABLE divisions(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
	parent_id INT,
    foreign key (parent_id) references divisions(id)
);
insert into divisions(name,parent_id) values('Imaginnovate',null);
insert into divisions(name,parent_id) values('Fleet enable',1);
insert into divisiondivisionss(name,parent_id) values('Logistics Studio',1);
insert into divisions(name,parent_id) values('J.B hunt',1);
insert into divisions(name,parent_id) values('Data Science',3);
insert into divisions(name,parent_id) values('Learning and Developement',3);
CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F', 'T')),
    email VARCHAR(60) NOT NULL ,
    designation VARCHAR(30) NOT NULL,
    division_id INT NOT NULL,
    reports_to INT,
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (reports_to) REFERENCES employees(id) ON UPDATE CASCADE,
    FOREIGN KEY(division_id) REFERENCES divisions(id) ON UPDATE CASCADE
);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('vanya','maddila','developer',3,'F','vanyamaddila@imaginnovate.com','2020-05-01',null);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('vidya','sree','developer',2,'F','vidyasree@imaginnovate.com','2019-03-01','2021-06-01');
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('mahindra','reddy','manager',3,'M','mahindrareddy@imaginnovate.com','2015-04-05',null);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('virat','kohli','ceo',1,'M','viratkohli@imaginnovate.com','2014-03-05',null);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('arjun','kumar','manager',2,'M','arjunkumar@imaginnovate.com','2015-04-03',null);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('anushka','sharma','Team Lead',3,'F','anushkasharma@imaginnovate.com','2019-02-05',null);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('akshay','vedanth','director',4,'M','akshay@imaginnovate.com','2014-05-04',null);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('vidya','sree','senior developer',5,'F','vidyasree@imaginnovate.com','2024-05-14',null);
insert into employees(first_name,last_name,designation,division_id,gender,email,start_date,end_date) values('faf','duplessis','Hr',3,'M','fafduplessis@imaginnovate.com','2021-05-14',null);
update employees set reports_to=2 where id=1;
update employees set reports_to=5 where id=2;
update employees set reports_to=7 where id=3;
update employees set reports_to=null where id=4;
update employees set reports_to=7 where id=5;
update employees set reports_to=3 where id=6;
update employees set reports_to=4 where id=7;
update employees set reports_to=6 where id=8;
update employees set reports_to=4 where id=9;
-- Create division authority
CREATE TABLE employee_divisions (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    division_id INT NOT NULL,
    can_approve_timesheets BOOLEAN NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employees(id) ON UPDATE CASCADE,
    FOREIGN KEY (division_id) REFERENCES divisions(id) ON UPDATE CASCADE,
    UNIQUE KEY (employee_id, division_id)
);
insert into employee_divisions (employee_id,division_id,can_approve_timesheets) values(3,3,true);
insert into employee_divisions (employee_id,division_id,can_approve_timesheets) values(4,1,true);
insert into employee_divisions (employee_id,division_id,can_approve_timesheets) values(5,2,true);
insert into employee_divisions (employee_id,division_id,can_approve_timesheets) values(7,4,true);
insert into employee_divisions (employee_id,division_id,can_approve_timesheets) values(9,3,true);
-- Create projects table
CREATE TABLE projects (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(200),
    division_id INT NOT NULL,
    FOREIGN KEY(division_id) REFERENCES divisions(id) ON UPDATE CASCADE
);
insert into projects (name,description,division_id) values ('employee_info_system','project on employee details',3);
insert into projects (name,description,division_id) values ('flight_management_system','project on flight details',2);
insert into projects (name,description,division_id) values ('books catalog','project on book details',4);
insert into projects (name,description,division_id) values ('hotel_management_system','project on hms',5);
-- Create tasks table
CREATE TABLE tasks (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description VARCHAR(200) NOT NULL
);
insert into tasks(name,description) values('frontend','develop a frontend for this project');
insert into tasks(name,description) values('backend','develop a backend for this project');
insert into tasks(name,description) values('testing','check whether the application running better or not');
insert into tasks(name,description) values('meeting','about project status');
insert into tasks(name,description) values('Recruitment and Onboarding','Conduct interviews for peoject roles');
-- Create timesheet_status table
CREATE TABLE timesheet_status (
    id TINYINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL
);
insert into timesheet_status(name) values ('approved');
insert into timesheet_status(name) values ('pending');
insert into timesheet_status(name) values ('rejected');
CREATE TABLE employee_projects (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    can_approve_timesheets BOOLEAN NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON UPDATE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON UPDATE CASCADE,
    UNIQUE KEY (employee_id, project_id)
);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(1,1,False);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(1,2,False);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(2,2,False);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(6,1,False);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(8,4,False);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(9,1,False);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(9,2,False);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(3,1,True);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(3,2,True);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(5,2,True);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(5,4,True);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(7,1,True);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(7,2,True);
insert into employee_projects(employee_id,project_id,can_approve_timesheets) values(7,4,True);
CREATE TABLE project_tasks (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    task_id INT NOT NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON UPDATE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON UPDATE CASCADE,
    UNIQUE KEY (project_id, task_id)
);
	
insert into project_tasks(project_id,task_id) values(1,1);
insert into project_tasks(project_id,task_id) values(1,2);
insert into project_tasks(project_id,task_id) values(1,3);
insert into project_tasks(project_id,task_id) values(1,4);
insert into project_tasks(project_id,task_id) values(2,1);
insert into project_tasks(project_id,task_id) values(2,2);
insert into project_tasks(project_id,task_id) values(2,3);
insert into project_tasks(project_id,task_id) values(2,4);
insert into project_tasks(project_id,task_id) values(3,1);
insert into project_tasks(project_id,task_id) values(3,2);
insert into project_tasks(project_id,task_id) values(3,3);
insert into project_tasks(project_id,task_id) values(4,1);
insert into project_tasks(project_id,task_id) values(4,2);
insert into project_tasks(project_id,task_id) values(4,3);
insert into project_tasks(project_id,task_id) values(4,4);
CREATE TABLE timesheets (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_project_id INT NOT NULL,
    project_task_id INT NOT NULL,
    description VARCHAR(100),
    hours_worked SMALLINT NOT NULL,
    submitted_by INT NOT NULL,
    submitted_on DATETIME NOT NULL,
    status TINYINT NOT NULL,
    approved_by INT,
    FOREIGN KEY (project_task_id) REFERENCES project_tasks(id) ON UPDATE CASCADE,
    FOREIGN KEY (employee_project_id) REFERENCES employee_projects(id) ON UPDATE CASCADE,
    FOREIGN KEY (submitted_by) REFERENCES employees(id) ON UPDATE CASCADE,
    FOREIGN KEY (status) REFERENCES timesheet_status(id) ON UPDATE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES employees(id) ON UPDATE CASCADE
);
insert into timesheets(employee_project_id,project_task_id,description,hours_worked,submitted_by,submitted_on,status,approved_by) values(1,1,'completed creating Frontend for the project',420,1,NOW(),1,null);
insert into timesheets(employee_project_id,project_task_id,description,hours_worked,submitted_by,submitted_on,status,approved_by) values(2,4,'about meeting status',60,1,NOW(),1,null);
insert into timesheets(employee_project_id,project_task_id,description,hours_worked,submitted_by,submitted_on,status,approved_by) values(3,2,'completed creating backend',420,2,NOW(),1,null);
insert into timesheets(employee_project_id,project_task_id,description,hours_worked,submitted_by,submitted_on,status,approved_by) values(8,4,'meetings',120,3,NOW(),1,null);
insert into timesheets(employee_project_id,project_task_id,description,hours_worked,submitted_by,submitted_on,status,approved_by) values(12,4,'meetings',60,7,NOW(),1,null);
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(12) NOT NULL,
    reset_token VARCHAR(10) NOT NULL,
    reset_token_expires_at DATETIME,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);
insert into users(employee_id,username,password,reset_token,reset_token_expires_at) values (1,'V123','Vanya@123','1233',DATE_ADD(NOW(), INTERVAL 20 MINUTE));
insert into users(employee_id,username,password,reset_token,reset_token_expires_at) values (2,'VI123','Vidya@123','2345',DATE_ADD(NOW(), INTERVAL 20 MINUTE));
insert into users(employee_id,username,password,reset_token,reset_token_expires_at) values (3,'M123','mahindra@123','3214',DATE_ADD(NOW(), INTERVAL 20 MINUTE));
insert into users(employee_id,username,password,reset_token,reset_token_expires_at) values(4,'VIR@123','virat@123','4567',DATE_ADD(NOW(), INTERVAL 20 MINUTE));
insert into users(employee_id,username,password,reset_token,reset_token_expires_at) values(5,'A123','arjun@123','5678',DATE_ADD(NOW(), INTERVAL 20 MINUTE));
insert into users(employee_id,username,password,reset_token,reset_token_expires_at) values(6,'AN123','Anushka@123','8976',DATE_ADD(NOW(), INTERVAL 20 MINUTE));