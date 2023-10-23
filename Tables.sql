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

-- Create a new test table
CREATE TABLE TestTable (
  TestID INT AUTO_INCREMENT PRIMARY KEY,
  TestName VARCHAR(255)
);

SHOW tables; -- shows all the tables created
DROP TABLE IF EXISTS TestTable; -- deletes the test table
SHOW tables; -- shows the updated tables details



-- Update EmployeeProfile table to change the data
-- Example: Change the EmployeeStatus of an employee with EmployeeID = 1
UPDATE EmployeeProfile
SET EmployeeStatus = 'Inactive'
WHERE EmployeeID = 1;

-- Alter EmployeeProfile table to add a new column
-- Example: Add a column 'Salary' to EmployeeProfile
ALTER TABLE EmployeeProfile
ADD COLUMN Salary DECIMAL(10, 2);

-- Insert new employee records into the EmployeeProfile table
INSERT INTO EmployeeProfile (FirstName, LastName, Email, ContactNumber, DateOfBirth, EmployeeStatus, DepartmentName)
VALUES ('John', 'Doe', 'johndoe@example.com', '+1234567890', '1990-01-15', 'Active', 'HR');

-- Update an employee record in the EmployeeProfile table
UPDATE EmployeeProfile
SET EmployeeStatus = 'Inactive'
WHERE EmployeeID = 1;

-- Delete an employee record from the EmployeeProfile table
DELETE FROM EmployeeProfile
WHERE EmployeeID = 2;

-- Select all employees in the HR department
SELECT * FROM EmployeeProfile WHERE DepartmentName = 'HR';

