
-- =====================================================
-- CYBERSECURITY INCIDENT MANAGEMENT SYSTEM
-- DBMS PROJECT
-- =====================================================

-- 1. DATABASE CREATION

DROP DATABASE IF EXISTS Cybersecurity_Incident_Management;

CREATE DATABASE Cybersecurity_Incident_Management;

USE Cybersecurity_Incident_Management;

-- 2. CREATE USERS TABLE

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50)
);

-- 3. CREATE INCIDENT TYPES TABLE

CREATE TABLE Incident_Types (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL
);

-- 4. CREATE SEVERITY LEVELS TABLE

CREATE TABLE Severity_Levels (
    severity_id INT AUTO_INCREMENT PRIMARY KEY,
    severity_name VARCHAR(50) NOT NULL
);

-- 5. CREATE INCIDENTS TABLE

CREATE TABLE Incidents (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type_id INT NOT NULL,
    severity_id INT NOT NULL,
    incident_description TEXT,
    incident_date DATE,
    status VARCHAR(50) DEFAULT 'Pending',

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (type_id) REFERENCES Incident_Types(type_id),
    FOREIGN KEY (severity_id) REFERENCES Severity_Levels(severity_id)
);

-- 6. CREATE INCIDENT RESPONSES TABLE

CREATE TABLE Incident_Responses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_id INT NOT NULL,
    response_description TEXT,
    response_date DATE,

    FOREIGN KEY (incident_id) REFERENCES Incidents(incident_id)
);

-- 7. INSERT DATA INTO USERS

INSERT INTO Users (full_name, email, department)
VALUES
('Rachel Saygbeh', 'rachel@example.com', 'Computer Science'),
('John Smith', 'john@example.com', 'Administration'),
('Mary Johnson', 'mary@example.com', 'Finance'),
('David Brown', 'david@example.com', 'IT Department'),
('Sarah Wilson', 'sarah@example.com', 'Human Resources');

-- 8. INSERT DATA INTO INCIDENT TYPES

INSERT INTO Incident_Types (type_name)
VALUES
('Phishing Attack'),
('Malware Infection'),
('Unauthorized Access'),
('Data Breach'),
('Ransomware Attack');

-- 9. INSERT DATA INTO SEVERITY LEVELS

INSERT INTO Severity_Levels (severity_name)
VALUES
('Low'),
('Medium'),
('High'),
('Critical');

-- 10. INSERT DATA INTO INCIDENTS

INSERT INTO Incidents
(user_id, type_id, severity_id, incident_description, incident_date, status)
VALUES
(1, 1, 3, 'Suspicious phishing email received', '2026-10-20', 'Pending'),
(2, 2, 4, 'Malware detected on office computer', '2026-10-21', 'In Progress'),
(3, 3, 2, 'Unauthorized login attempt detected', '2026-10-22', 'Resolved'),
(4, 4, 4, 'Sensitive company information exposed', '2026-10-23', 'In Progress'),
(5, 5, 3, 'Ransomware attack reported', '2026-10-24', 'Pending');

-- 11. INSERT DATA INTO INCIDENT RESPONSES

INSERT INTO Incident_Responses
(incident_id, response_description, response_date)
VALUES
(1, 'Suspicious email blocked and reported', '2026-10-20'),
(2, 'Infected computer isolated for investigation', '2026-10-21'),
(3, 'Unauthorized login blocked and password reset', '2026-10-22'),
(4, 'Exposed information secured and access restricted', '2026-10-23'),
(5, 'Affected system isolated for security investigation', '2026-10-24');

-- 12. DISPLAY ALL TABLES

SHOW TABLES;

-- 13. DISPLAY TABLE STRUCTURES

DESCRIBE Users;
DESCRIBE Incident_Types;
DESCRIBE Severity_Levels;
DESCRIBE Incidents;
DESCRIBE Incident_Responses;

-- 14. DISPLAY ALL TABLE RECORDS

SELECT * FROM Users;

SELECT * FROM Incident_Types;

SELECT * FROM Severity_Levels;

SELECT * FROM Incidents;

SELECT * FROM Incident_Responses;

-- 15. SELECT INCIDENTS BY STATUS

SELECT *
FROM Incidents
WHERE status = 'Pending';

-- 16. SELECT INCIDENTS BY SEVERITY

SELECT *
FROM Incidents
WHERE severity_id = 4;

-- 17. ORDER INCIDENTS BY DATE

SELECT *
FROM Incidents
ORDER BY incident_date DESC;

-- 18. UPDATE INCIDENT STATUS

UPDATE Incidents
SET status = 'Resolved'
WHERE incident_id = 1;

UPDATE Incidents
SET status = 'Resolved'
WHERE incident_id = 5;

-- 19. DISPLAY UPDATED INCIDENT STATUS

SELECT incident_id, incident_description, status
FROM Incidents;

-- 20. JOIN USERS AND INCIDENTS

SELECT
    Users.full_name,
    Users.department,
    Incidents.incident_description,
    Incidents.incident_date,
    Incidents.status
FROM Users
INNER JOIN Incidents
ON Users.user_id = Incidents.user_id;

-- 21. COUNT INCIDENTS BY SEVERITY

SELECT
    Severity_Levels.severity_name,
    COUNT(Incidents.incident_id) AS total_incidents
FROM Severity_Levels
LEFT JOIN Incidents
ON Severity_Levels.severity_id = Incidents.severity_id
GROUP BY Severity_Levels.severity_name;

-- 22. COUNT INCIDENTS BY TYPE

SELECT
    Incident_Types.type_name,
    COUNT(Incidents.incident_id) AS total_incidents
FROM Incident_Types
LEFT JOIN Incidents
ON Incident_Types.type_id = Incidents.type_id
GROUP BY Incident_Types.type_name;

-- 23. DISPLAY INCIDENT RESPONSES

SELECT
    Incidents.incident_id,
    Incidents.incident_description,
    Incident_Responses.response_description,
    Incident_Responses.response_date
FROM Incidents
INNER JOIN Incident_Responses
ON Incidents.incident_id = Incident_Responses.incident_id;

-- 24. COMBINED INCIDENT REPORT USING ALL FIVE TABLES

SELECT
    Incidents.incident_id,
    Users.full_name,
    Users.department,
    Incident_Types.type_name,
    Severity_Levels.severity_name,
    Incidents.incident_description,
    Incidents.incident_date,
    Incidents.status,
    Incident_Responses.response_description,
    Incident_Responses.response_date
FROM Incidents
INNER JOIN Users
ON Incidents.user_id = Users.user_id
INNER JOIN Incident_Types
ON Incidents.type_id = Incident_Types.type_id
INNER JOIN Severity_Levels
ON Incidents.severity_id = Severity_Levels.severity_id
INNER JOIN Incident_Responses
ON Incidents.incident_id = Incident_Responses.incident_id
ORDER BY Incidents.incident_id;

-- 25. COUNT RECORDS IN EACH TABLE

SELECT 'Users' AS Table_Name, COUNT(*) AS Total_Records
FROM Users

UNION ALL

SELECT 'Incident_Types', COUNT(*)
FROM Incident_Types

UNION ALL

SELECT 'Severity_Levels', COUNT(*)
FROM Severity_Levels

UNION ALL

SELECT 'Incidents', COUNT(*)
FROM Incidents

UNION ALL

SELECT 'Incident_Responses', COUNT(*)
FROM Incident_Responses;

-- 26. VERIFY FOREIGN KEY RELATIONSHIPS

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'Cybersecurity_Incident_Management'
AND REFERENCED_TABLE_NAME IS NOT NULL;

-- 27. FINAL DATABASE VERIFICATION

SHOW TABLES;

SELECT * FROM Users;
SELECT * FROM Incident_Types;
SELECT * FROM Severity_Levels;
SELECT * FROM Incidents;
SELECT * FROM Incident_Responses;

-- =====================================================
-- END OF CYBERSECURITY INCIDENT MANAGEMENT SYSTEM
-- =====================================================
