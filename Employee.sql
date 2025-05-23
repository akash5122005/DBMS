
Here's the full SQL solution including table creation, constraints, queries, and stored procedure:

1. Create Tables with Constraints
CREATE TABLE Dept (
    Deptno INT PRIMARY KEY,
    Dname VARCHAR(100),
    Loc VARCHAR(100),
    DeptmanagerId INT
);

CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,
    Empname VARCHAR(100),
    Sal DECIMAL(10, 2),
    Deptno INT,
    FOREIGN KEY (Deptno) REFERENCES Dept(Deptno)
);
consider adding a self-reference or making DeptmanagerId a foreign key to Employee(EmpId). Add this line in Dept table if required:

-- FOREIGN KEY (DeptmanagerId) REFERENCES Employee(EmpId)
2. a) Count of Employees and Average Salary per Department
SELECT 
    Deptno, 
    COUNT(*) AS Employee_Count, 
    AVG(Sal) AS Average_Salary
FROM 
    Employee
GROUP BY 
    Deptno;
3. b) Employee Name, Department Name, and Salary
SELECT 
    E.Empname, 
    D.Dname, 
    E.Sal
FROM 
    Employee E
JOIN 
    Dept D ON E.Deptno = D.Deptno;
4. c) Employee Name and Department Manager Name
Assuming DeptmanagerId references Employee(EmpId):

SELECT 
    E.Empname AS Employee_Name, 
    M.Empname AS Manager_Name
FROM 
    Employee E
JOIN 
    Dept D ON E.Deptno = D.Deptno
JOIN 
    Employee M ON D.DeptmanagerId = M.EmpId;
5. d) Procedure to Return Salary for Given EmpId
DELIMITER //

CREATE PROCEDURE GetSalaryByEmpId(IN eid INT, OUT salary DECIMAL(10, 2))
BEGIN
    SELECT Sal INTO salary
    FROM Employee
    WHERE EmpId = eid;
END //

DELIMITER ;
To call this procedure:

CALL GetSalaryByEmpId(101, @salary);
SELECT @salary;
Let me know if you want sample data to go with this schema.

You said:
2.	Create the following tables with given attributes having appropriate data type and specify the necessary primary and foreign key constraints:  
Employee (EmpId, Empname, Sal, Deptno)  Dept (Deptno, Dname, Loc,DeptmanagerId)  
a)	List the count of Employees and average salary of each department. 
b)	List the employee name, department name and the salary of all the employees. 
c)	Display the Employee name and the respective department manager name. 
d)	Create a procedure to return the salary of the employee when Empid is given as input parameter
ChatGPT said:
Here is the complete SQL code to address your request:

1. Table Creation with Keys
-- Create Dept table
CREATE TABLE Dept (
    Deptno INT PRIMARY KEY,
    Dname VARCHAR(100),
    Loc VARCHAR(100),
    DeptmanagerId INT
);

-- Create Employee table
CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,
    Empname VARCHAR(100),
    Sal DECIMAL(10,2),
    Deptno INT,
    FOREIGN KEY (Deptno) REFERENCES Dept(Deptno)
);

-- Add foreign key constraint to DeptmanagerId after Employee table exists
ALTER TABLE Dept
ADD CONSTRAINT fk_manager FOREIGN KEY (DeptmanagerId) REFERENCES Employee(EmpId);
2. a) Count of Employees and Average Salary per Department
SELECT 
    Deptno, 
    COUNT(*) AS EmployeeCount, 
    AVG(Sal) AS AverageSalary
FROM 
    Employee
GROUP BY 
    Deptno;
3. b) Employee Name, Department Name, and Salary
SELECT 
    E.Empname, 
    D.Dname, 
    E.Sal
FROM 
    Employee E
JOIN 
    Dept D ON E.Deptno = D.Deptno;
4. c) Employee Name and Their Department Manager Name
SELECT 
    E.Empname AS EmployeeName,
    M.Empname AS ManagerName
FROM 
    Employee E
JOIN 
    Dept D ON E.Deptno = D.Deptno
JOIN 
    Employee M ON D.DeptmanagerId = M.EmpId;
5. d) Procedure to Return Salary by EmpId
DELIMITER //

CREATE PROCEDURE GetEmployeeSalary (
    IN emp_id INT,
    OUT emp_salary DECIMAL(10,2)
)
BEGIN
    SELECT Sal INTO emp_salary
    FROM Employee
    WHERE EmpId = emp_id;
END //

DELIMITER ;
To call this procedure:

CALL GetEmployeeSalary(101, @salary);
SELECT @salary;
