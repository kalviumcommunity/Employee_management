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

-- Create SkillSet table
CREATE TABLE SkillSet (
  SkillID INT AUTO_INCREMENT PRIMARY KEY,
  EmployeeID INT,
  SkillName VARCHAR(255),
  ProficiencyLevel VARCHAR(50),
  FOREIGN KEY (EmployeeID) REFERENCES EmployeeProfile(EmployeeID)
);

-- Create Department table
CREATE TABLE Department (
  DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
  DepartmentName VARCHAR(255),
  TotalEmployees INT
);

-- Create JobPosition table
CREATE TABLE JobPosition (
  PositionID INT AUTO_INCREMENT PRIMARY KEY,
  DepartmentID INT,
  Title VARCHAR(255),
  SalaryRange VARCHAR(100),
  IsDeptHead BOOLEAN,
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

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

-- Create PerformanceReview table
CREATE TABLE PerformanceReview (
  ReviewID INT AUTO_INCREMENT PRIMARY KEY,
  EmployeeID INT,
  ReviewerID INT,
  ReviewDate DATE,
  Strengths TEXT,
  AreasForImprovement TEXT,
  FOREIGN KEY (EmployeeID) REFERENCES EmployeeProfile(EmployeeID),
  FOREIGN KEY (ReviewerID) REFERENCES EmployeeProfile(EmployeeID)
);

-- Update EmployeeProfile table to change the data
-- Example: Change the EmployeeStatus of an employee with EmployeeID = 1
UPDATE EmployeeProfile
SET EmployeeStatus = 'Inactive'
WHERE EmployeeID = 1;

-- Alter EmployeeProfile table to add a new column
-- Example: Add a column 'Salary' to EmployeeProfile
ALTER TABLE EmployeeProfile
ADD COLUMN Salary DECIMAL(10, 2);