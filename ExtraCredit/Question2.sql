use company;


-- Question 2 Part 1
CREATE VIEW PROJ_EMPS as select project.Pname, employee.Lname, employee.Fname, works_on.Hours from employee, project, works_on where employee.Dno = project.Dnum and project.Pnumber = works_on.Pno ORDER BY project.Pname,employee.Lname, employee.Fname ASC;
Select * from PROJ_EMPS;
Select count(*) from PROJ_EMPS;

-- Question 2 Part 2
Select COUNT(*) as 'No. of employee working' , project.Pname, project.Pnumber from employee, project where employee.Dno = project.Dnum GROUP BY project.Pnumber, project.Pname;