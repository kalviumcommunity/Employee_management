
-- Create database
CREATE DATABASE Employee_management;

-- Using it 
USE Employee_management;

-- Create EmployeeProfile table
CREATE TABLE EmployeeProfile (
  EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  Email VARCHAR(255),
  ContactNumber VARCHAR(20),
  DateOfBirth DATE,
  EmployeeStatus VARCHAR(50),
  DepartmentName VARCHAR(255)
);
DESCRIBE EmployeeProfile;

-- Create SkillSet table
CREATE TABLE SkillSet (
  SkillID INT AUTO_INCREMENT PRIMARY KEY,
  EmployeeID INT,
  SkillName VARCHAR(255),
  ProficiencyLevel VARCHAR(50),
  FOREIGN KEY (EmployeeID) REFERENCES EmployeeProfile(EmployeeID)
);
DESCRIBE SkillSet;

-- Create Department table
CREATE TABLE Department (
  DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
  DepartmentName VARCHAR(255),
  TotalEmployees INT
);
DESCRIBE Department;

-- Create JobPosition table
CREATE TABLE JobPosition (
  PositionID INT AUTO_INCREMENT PRIMARY KEY,
  DepartmentID INT,
  Title VARCHAR(255),
  SalaryRange VARCHAR(100),
  IsDeptHead BOOLEAN,
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
DESCRIBE JobPosition;

-- Create TaskAssignment table
CREATE TABLE TaskAssignment (
  TaskID INT AUTO_INCREMENT PRIMARY KEY,
  EmployeeID INT,
  ManagerID INT,
  DueDate DATE,
  Priority VARCHAR(50),
  Status VARCHAR(50),
  FOREIGN KEY (EmployeeID) REFERENCES EmployeeProfile(EmployeeID),
  FOREIGN KEY (ManagerID) REFERENCES EmployeeProfile(EmployeeID)
);
DESCRIBE TaskAssignment;

-- Create PerformanceReview table
CREATE TABLE PerformanceReview (
  ReviewID INT AUTO_INCREMENT PRIMARY KEY,
  EmployeeID INT,
  reviewerID INT,
  ReviewDate DATE,
  Strengths TEXT,
  AreasForImprovement TEXT,
  FOREIGN KEY (EmployeeID) REFERENCES EmployeeProfile(EmployeeID),
  FOREIGN KEY (reviewerID) REFERENCES EmployeeProfile(EmployeeID)
);
DESCRIBE PerformanceReview;

SHOW tables; -- shows all the tables created


-- Alter EmployeeProfile table to add a new column
-- Example: Add a column 'Salary' to EmployeeProfile
ALTER TABLE EmployeeProfile
ADD COLUMN Salary DECIMAL(10, 2);
DESCRIBE EmployeeProfile;

-- Insert new employee records into the EmployeeProfile table
INSERT INTO EmployeeProfile (FirstName, LastName, Email, ContactNumber, DateOfBirth, EmployeeStatus, DepartmentName, Salary)
VALUES ('John', 'Doe', 'johndoe@example.com', '+1234567890', '1990-01-15', 'Active', 'HR'),
	   ('Pankhuri', 'Srivastava', 'panksri@gmail.com', '+1234567890', '1990-01-15', 'Active', 'HR', 60000),
       ('Tanishka', 'Dadhich', 'tandad@gmail.com', '+9876543210', '1995-03-20', 'Active', 'IT', 70000),
       ('Navaneeth', 'Arunkumar', 'navarun@gmail.com', '+1122334455', '1985-07-10', 'Active', 'HR', 55000),
       ('Dev', 'Pratap', 'devprat@gmail.com', '+9988776655', '1993-05-12', 'Active', 'IT', 75000);

UPDATE EmployeeProfile
SET Salary = 20000  -- Replace 60000 with the new salary value you want for John
WHERE FirstName = 'John' AND LastName = 'Doe';

INSERT INTO SkillSet (EmployeeID, SkillName, ProficiencyLevel)
VALUES (1, 'Java', 'Intermediate'),
       (1, 'SQL', 'Advanced'),
       (2, 'Java', 'Advanced'),
       (2, 'C++', 'Intermediate'),
       (3, 'SQL', 'Intermediate'),
       (4, 'Java', 'Intermediate'),
       (4, 'SQL', 'Advanced');

INSERT INTO Department (DepartmentName, TotalEmployees)
VALUES ('HR', 2),
       ('IT', 2);

INSERT INTO JobPosition (DepartmentID, Title, SalaryRange, IsDeptHead)
VALUES (1, 'HR Manager', '60000-80000', TRUE),
       (2, 'Software Engineer', '70000-90000', FALSE);

INSERT INTO TaskAssignment (EmployeeID, ManagerID, DueDate, Priority, Status)
VALUES (1, 2, '2023-11-30', 'High', 'Pending'),
       (2, 1, '2023-12-15', 'Medium', 'In Progress'),
       (3, 1, '2023-12-10', 'Low', 'Completed'),
       (4, 2, '2023-11-20', 'High', 'Pending');

INSERT INTO PerformanceReview (EmployeeID, reviewerID, ReviewDate, Strengths, AreasForImprovement)
VALUES (1, 2, '2023-10-15', 'Strong problem-solving skills', 'Communication skills need improvement'),
       (2, 1, '2023-09-20', 'Excellent team player', 'Enhance technical skills'),
       (3, 1, '2023-11-05', 'Highly organized', 'Improve time management'),
       (4, 2, '2023-10-25', 'Adapts well to new technologies', 'Improve code documentation');



-- Update an employee record in the EmployeeProfile table
UPDATE EmployeeProfile
SET EmployeeStatus = 'Inactive'
WHERE EmployeeID = 1;

-- Delete an employee record from the EmployeeProfile table
DELETE FROM EmployeeProfile
WHERE EmployeeID = 2;

describe SkillSet;

-- Select all employees in the HR department
SELECT * FROM EmployeeProfile WHERE DepartmentName = 'HR';


-- List all employees in the "HR" department along with their no. of skills:
SELECT EP.FirstName, EP.LastName, COUNT(S.ProficiencyLevel) as No_of_skills
FROM EmployeeProfile EP 
JOIN SkillSet S ON EP.EmployeeID = S.EmployeeID 
WHERE EP.DepartmentName = 'HR' 
GROUP BY EP.FirstName, EP.LastName;

--  Find the highest-paid employee in each department
SELECT D.DepartmentName, MAX(JP.SalaryRange) AS MaxSalary
FROM Department D
LEFT JOIN JobPosition JP ON D.DepartmentID = JP.DepartmentID
GROUP BY D.DepartmentName;

--  Calculate the average age of employees in the "IT" department
SELECT AVG(YEAR(NOW()) - YEAR(DateOfBirth)) AS AverageAge
FROM EmployeeProfile
WHERE DepartmentName = 'IT';

--  Retrieve all employees who have pending tasks
SELECT EP.FirstName, EP.LastName, TA.DueDate, TA.Priority
FROM EmployeeProfile EP
INNER JOIN TaskAssignment TA ON EP.EmployeeID = TA.EmployeeID
WHERE TA.Status = 'Pending';

--  Find employees who have both "Java" and "SQL" skills
SELECT EP.FirstName, EP.LastName
FROM EmployeeProfile EP
INNER JOIN SkillSet S ON EP.EmployeeID = S.EmployeeID
WHERE S.SkillName IN ('Java', 'SQL')
GROUP BY EP.EmployeeID
HAVING COUNT(DISTINCT S.SkillName) = 2;






