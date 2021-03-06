
create database company;
use company;
show tables;
create table Employee(
    Fname varchar(50),
    Minit varchar (5),
    Lname varchar(50),
    Ssn int(100),
    Bdate date,
    Address varchar(200),
    Sex varchar(5),
    Salary int(200),
    Super_ssn int(200),
    Dno int(50),
    PRIMARY KEY(Ssn)
);

describe Employee;


show databases;
use company;

create table department(
Dname varchar(200),
Dnumber int(200) primary key,
Mgr_ssn int(200),
Mgr_start_date date,
UNIQUE (Dname),
FOREIGN KEY (Mgr_ssn) REFERENCES Employee(Ssn)
);

describe department;

create table dept_locations (
Dnumber int(200),
Dlocation varchar(200),
PRIMARY KEY(Dnumber, Dlocation),
FOREIGN KEY(Dnumber) REFERENCES department(Dnumber) ON DELETE CASCADE
);

describe dept_locations;

create table project(
Pname varchar(200),
Pnumber int(200) PRIMARY KEY,
Plocation varchar(200),
Dnum int(200),
UNIQUE (Pname),
FOREIGN KEY (Dnum) REFERENCES Department (Dnumber)
);


create table works_on (
Essn int (200),
Pno int (200),
Hours decimal (4,2),
PRIMARY KEY(Essn,Pno),
FOREIGN KEY(Essn) REFERENCES Employee(Ssn) ON DELETE CASCADE,
FOREIGN KEY(Pno) REFERENCES project(Pnumber) ON DELETE CASCADE
);

insert into employee values ('James', 'U', 'Miller', 906218888, '1978-05-27', '13 Fifth St,Seattle,WA', 'M', 75000, 999999999, 5);

insert into department values ('QA', 11, 913323708, '2010-02-02'); 

insert into dept_locations values (11, 'Austin');

insert into project values ('DataMining', 13, 'Sacramento',6);

insert into works_on values ('122344668', 30, 25.0);



select * from employee;
select * from department;


-- Anser 4 : Method 1
SET @dno = (select Dnumber as DNO from Department where Dname = 'Sales');
Select Fname, Minit, Lname,Salary from Employee where Dno = @dno;

-- Anser 4 : Method 2
Select Fname, Minit, Lname,Salary from Employee where Dno = (select Dnumber as DNO from Department where Dname = 'Sales');

-- Answer 4 : Method 3
Select Fname, Minit, Lname, Salary from Employee LEFT JOIN Department ON Employee.Dno = Department.Dnumber where Department.Dname = 'Sales';


-- Answer 5 : Method 1
Select Pname as ProjectName, Hours as HoursPerWeek from Project JOIN works_on ON Project.Pnumber = works_on.Pno where Project.Dnum = (Select Dno from Employee where Fname = 'Alex' and Lname = 'Yu');


-- Answer 6:
Select sum(Salary) as TotalSalary from Employee LEFT JOIN Department ON Employee.Dno = Department.Dnumber where Department.Dname = 'Sales';

-- Answer 7:
Select Dname as DepartmentName, COUNT(*) as TotalEmployees from Department 
INNER JOIN Employee ON Employee.Dno = Department.Dnumber
GROUP BY Department.Dnumber, Department.Dname ORDER BY TotalEmployees DESC;

-- Answer 8:
Select b.Fname, b.Lname, Count(*) as EmployeesSupervised from Employee as a, Employee as b
where a.Super_ssn = b.Ssn
GROUP BY b.Fname, b.Lname ORDER BY EmployeesSupervised DESC;