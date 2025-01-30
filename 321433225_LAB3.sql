create database University_DB;
use University_DB; 

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
 `studentID` int NOT NULL,
 `firstName` varchar(50) NOT NULL,
 `lastName` varchar(50) NOT NULL,
 `email` varchar(100) NOT NULL,
 `phone` varchar(50) NOT NULL,
 `address` varchar(100) NOT NULL,
 `city` varchar(50) NOT NULL,
 `state` varchar(50) DEFAULT NULL,
 `postalCode` varchar(15) DEFAULT NULL,
 `country` varchar(50) NOT NULL,
 `advisorID` int DEFAULT NULL,
 `scholarshipAmount` decimal(10,2) DEFAULT NULL,
 PRIMARY KEY (`studentID`),
 KEY `advisorID` (`advisorID`),
 CONSTRAINT `students_ibfk_1` FOREIGN KEY (`advisorID`) REFERENCES `professors`
(`professorID`));

DROP TABLE IF EXISTS `course_enrollments`;
CREATE TABLE `course_enrollments` (
 `enrollmentID` int NOT NULL AUTO_INCREMENT,
 `courseCode` varchar(10) NOT NULL,
 `studentID` int NOT NULL,
 `enrollmentDate` date NOT NULL,
 `grade` varchar(2) DEFAULT NULL,
 PRIMARY KEY (`enrollmentID`),
 KEY `studentID` (`studentID`),
 KEY `courseCode` (`courseCode`),
 CONSTRAINT `course_enrollments_ibfk_1` FOREIGN KEY (`studentID`) REFERENCES
`students` (`studentID`),
 CONSTRAINT `course_enrollments_ibfk_2` FOREIGN KEY (`courseCode`) REFERENCES
`courses` (`courseCode`)
);

DROP TABLE IF EXISTS `scholarships`;
CREATE TABLE `scholarships` (
 `scholarshipID` varchar(10) NOT NULL,
 `scholarshipName` varchar(100) NOT NULL,
 `description` varchar(4000) DEFAULT NULL,
 `amount` decimal(10,2) NOT NULL,
 PRIMARY KEY (`scholarshipID`));
 
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
 `studentID` int NOT NULL,
 `paymentReference` varchar(50) NOT NULL,
 `paymentDate` date NOT NULL,
 `amount` decimal(10,2) NOT NULL,
 PRIMARY KEY (`studentID`, `paymentReference`),
 CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`studentID`) REFERENCES `students`
(`studentID`)
);

CREATE TABLE `departments` (
 `departmentCode` varchar(10) NOT NULL,
 `departmentName` varchar(50) NOT NULL,
 `location` varchar(50) NOT NULL,
 `phone` varchar(50) NOT NULL,
 PRIMARY KEY (`departmentCode`)
);

DROP TABLE IF EXISTS `professors`;
CREATE TABLE `professors` (
 `professorID` int NOT NULL,
 `firstName` varchar(50) NOT NULL,
 `lastName` varchar(50) NOT NULL,
 `email` varchar(100) NOT NULL,
 `phone` varchar(50) NOT NULL,
 `departmentCode` varchar(10) NOT NULL,
 `reportsTo` int DEFAULT NULL,
 `title` varchar(50) NOT NULL,
 PRIMARY KEY (`professorID`),
 KEY `reportsTo` (`reportsTo`),
 KEY `departmentCode` (`departmentCode`),
 CONSTRAINT `professors_ibfk_1` FOREIGN KEY (`reportsTo`) REFERENCES
`professors` (`professorID`),
 CONSTRAINT `professors_ibfk_2` FOREIGN KEY (`departmentCode`) REFERENCES
`departments` (`departmentCode`)
);

CREATE TABLE `courses` (
 `courseCode` varchar(10) NOT NULL,
 `courseName` varchar(100) NOT NULL,
 `startDate` date NOT NULL,
 `endDate` date NOT NULL,
 `professorID` int NOT NULL,
 `departmentCode` varchar(10) NOT NULL,
  PRIMARY KEY (`courseCode`),
 KEY `professorID` (`professorID`),
 KEY `departmentCode` (`departmentCode`),
 CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`professorID`) REFERENCES
`professors` (`professorID`),
 CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`departmentCode`) REFERENCES
`departments` (`departmentCode`)
);

DROP TABLE IF EXISTS `textbooks`;
CREATE TABLE `textbooks` (
 `isbn` varchar(13) NOT NULL,
 `title` varchar(100) NOT NULL,
 `author` varchar(50) NOT NULL,
 `publisher` varchar(50) NOT NULL,
 `price` decimal(10,2) NOT NULL,
 `courseCode` varchar(10) NOT NULL,
 PRIMARY KEY (`isbn`),
 KEY `courseCode` (`courseCode`),
 CONSTRAINT `textbooks_ibfk_1` FOREIGN KEY (`courseCode`) REFERENCES `courses`
(`courseCode`)
);

INSERT INTO `departments` (`departmentCode`, `departmentName`, `location`,
`phone`)
VALUES
('CS', 'Computer Science', 'Building A', '123-123-1234'),
('ENG', 'English', 'Building B', '234-234-2345'),
('MATH', 'Mathematics', 'Building C', '345-345-3456');

INSERT INTO `scholarships` (`scholarshipID`, `scholarshipName`, `description`,
`amount`)
VALUES
('SCH01', 'Merit Scholarship', 'Awarded for academic excellence', 2000.00),
('SCH02', 'Athletic Scholarship', 'Awarded for outstanding athletic performance', 1500.00),
('SCH03', 'Need-Based Scholarship', 'Awarded based on financial need', 3000.00),
('SCH04', 'Community Service Scholarship', 'Awarded for contributions to community
service', 1000.00);

INSERT INTO `professors` (`professorID`, `firstName`, `lastName`, `email`, `phone`,
`departmentCode`, `reportsTo`, `title`)
VALUES
(101, 'Richard', 'Anderson', 'randerson@example.com', '123-123-1234', 'CS', NULL,
'Department Chair'),
(102, 'Linda', 'Johnson', 'ljohnson@example.com', '234-234-2345', 'ENG', 101, 'Professor'),
(103, 'James', 'Williams', 'jwilliams@example.com', '345-345-3456', 'MATH', 101,
'Professor'),
(104, 'Barbara', 'Martinez', 'bmartinez@example.com', '456-456-4567', 'CS', 101, 'Assistant
Professor'),
(105, 'Michael', 'Garcia', 'mgarcia@example.com', '567-567-5678', 'ENG', 101, 'Professor'),
(106, 'Elizabeth', 'Davis', 'edavis@example.com', '678-678-6789', 'MATH', 103, 'Associate
Professor'),
(107, 'Robert', 'Rodriguez', 'rrodriguez@example.com', '789-789-7890', 'CS', 104, 'Professor'),
(108, 'Mary', 'Hernandez', 'mhernandez@example.com', '890-890-8901', 'ENG', 105,
'Lecturer'),
(109, 'David', 'Lopez', 'dlopez@example.com', '901-901-9012', 'MATH', 106, 'Professor'),
(110, 'Susan', 'Moore', 'smoore@example.com', '012-012-0123', 'CS', 104, 'Professor'),
(111, 'Charles', 'Taylor', 'ctaylor@example.com', '123-456-7890', 'CS', 101, 'Lecturer'),
(112, 'Donna', 'Harris', 'dharris@example.com', '234-567-8901', 'MATH', 103, 'Professor'),
(113, 'Thomas', 'Clark', 'tclark@example.com', '345-678-9012', 'ENG', 102, 'Associate
Professor'),
(114, 'Patricia', 'Lewis', 'plewis@example.com', '456-789-0123', 'MATH', 106, 'Lecturer'),
(115, 'George', 'Walker', 'gwalker@example.com', '567-890-1234', 'CS', 107, 'Professor'),
(116, 'Deborah', 'Hill', 'dhill@example.com', '678-901-2345', 'ENG', 105, 'Lecturer'),
(117, 'Jennifer', 'Scott', 'jscott@example.com', '789-012-3456', 'MATH', 109, 'Professor'),
(118, 'Steven', 'Adams', 'sadams@example.com', '890-123-4567', 'CS', 107, 'Assistant
Professor'),
(119, 'Kimberly', 'Baker', 'kbaker@example.com', '901-234-5678', 'ENG', 108, 'Lecturer'),
(120, 'Paul', 'Gonzalez', 'pgonzalez@example.com', '012-345-6789', 'MATH', 109, 'Associate
Professor');

INSERT INTO `courses` (`courseCode`, `courseName`, `startDate`, `endDate`,
`professorID`, `departmentCode`)
VALUES
('CS101', 'Introduction to Programming', '2024-01-10', '2024-05-20', 104, 'CS'),
('CS102', 'Data Structures', '2024-01-12', '2024-05-20', 107, 'CS'),
('MATH201', 'Calculus I', '2024-01-15', '2024-05-20', 103, 'MATH'),
('ENG301', 'English Literature', '2024-01-18', '2024-05-20', 102, 'ENG');

INSERT INTO `students` (`studentID`, `firstName`, `lastName`, `email`, `phone`,
`address`, `city`, `state`, `postalCode`, `country`, `advisorID`,
`scholarshipAmount`)
VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '123-456-7890', '123 Main St', 'New York', 'NY',
'10001', 'USA', 101, 2000.00),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-789-4561', '456 Oak Ave', 'Los Angeles',
'CA', '90001', 'USA', 102, 1500.00),
(3, 'Michael', 'Brown', 'michaelb@example.com', '777-234-5678', '789 Pine Rd', 'Chicago', 'IL',
'60601', 'USA', 101, 3000.00),
(4, 'Emily', 'Davis', 'emilyd@example.com', '234-567-1234', '987 Maple St', 'Houston', 'TX',
'77001', 'USA', 103, 1000.00),
(5, 'Chris', 'Wilson', 'chrisw@example.com', '345-678-1234', '654 Cedar Ln', 'Phoenix', 'AZ',
'85001', 'USA', 104, NULL),
(6, 'Sarah', 'Johnson', 'sarahj@example.com', '123-789-6543', '321 Birch St', 'Boston', 'MA',
'02108', 'USA', 105, 2500.00),
(7, 'David', 'Miller', 'davidm@example.com', '987-456-3210', '213 Elm St', 'Dallas', 'TX',
'75201', 'USA', 106, 3500.00),
(8, 'Laura', 'Clark', 'laurac@example.com', '567-234-8765', '432 Cherry Ln', 'Miami', 'FL',
'33101', 'USA', 104, 4000.00),
(9, 'Robert', 'Lewis', 'robertl@example.com', '678-123-4567', '789 Spruce Ave', 'San
Francisco', 'CA', '94101', 'USA', 103, NULL),
(10, 'Anna', 'Walker', 'annaw@example.com', '234-987-1234', '654 Cypress Dr', 'Seattle', 'WA',
'98101', 'USA', 102, 1800.00),
(11, 'Tom', 'Scott', 'tomscott@example.com', '123-456-7899', '1111 Willow Way', 'Austin', 'TX',
'73301', 'USA', 107, 500.00),
(12, 'Jessica', 'Young', 'jessicay@example.com', '222-333-4444', '2222 Palm Rd', 'Denver',
'CO', '80014', 'USA', 108, 4500.00),
(13, 'William', 'King', 'williamk@example.com', '999-888-7777', '3333 Oak Grove', 'Atlanta',
'GA', '30301', 'USA', 109, 1200.00),
(14, 'Patricia', 'Martinez', 'patriciam@example.com', '123-999-5555', '4444 Peach St', 'Las
Vegas', 'NV', '88901', 'USA', 110, NULL),
(15, 'Daniel', 'Harris', 'danielh@example.com', '444-555-6666', '5555 Sunset Blvd', 'Orlando',
'FL', '32801', 'USA', 104, 6000.00),
(16, 'Samantha', 'Roberts', 'samanthar@example.com', '333-222-1111', '6666 Desert Rd',
'Salt Lake City', 'UT', '84101', 'USA', 103, 1700.00),
(17, 'Joshua', 'Lee', 'joshl@example.com', '777-888-9999', '7777 Valley Dr', 'San Diego', 'CA',
'92101', 'USA', 107, 700.00),
(18, 'Olivia', 'White', 'oliviaw@example.com', '111-222-3333', '8888 Ocean Blvd',
'Sacramento', 'CA', '94203', 'USA', 102, NULL),
(19, 'Matthew', 'Hall', 'matth@example.com', '444-777-9999', '9999 Cliffside', 'Philadelphia',
'PA', '19019', 'USA', 109, 2500.00),
(20, 'Sophia', 'Allen', 'sophiaa@example.com', '222-111-4444', '1010 Canyon Dr', 'Portland',
'OR', '97201', 'USA', 108, 3500.00);

INSERT INTO `course_enrollments` (`enrollmentID`, `courseCode`, `studentID`,
`enrollmentDate`, `grade`)
VALUES
(1, 'CS101', 1, '2024-01-10', 'A'),
(2, 'CS102', 2, '2024-01-12', 'B'),
(3, 'MATH201', 3, '2024-01-15', 'A'),
(4, 'ENG301', 4, '2024-01-18', 'B+'),
(5, 'CS101', 5, '2024-01-10', 'C'),
(6, 'CS102', 6, '2024-01-12', 'B-'),
(7, 'MATH201', 7, '2024-01-15', 'A+'),
(8, 'ENG301', 8, '2024-01-18', 'B'),
(9, 'CS101', 9, '2024-01-10', 'A-'),
(10, 'CS102', 10, '2024-01-12', 'B+'),
(11, 'MATH201', 11, '2024-01-15', 'B-'),
(12, 'ENG301', 12, '2024-01-18', 'A'),
(13, 'CS101', 13, '2024-01-10', 'A'),
(14, 'CS102', 14, '2024-01-12', 'C+'),
(15, 'MATH201', 15, '2024-01-15', 'A'),
(16, 'ENG301', 16, '2024-01-18', 'B'),
(17, 'CS101', 17, '2024-01-10', 'A-'),
(18, 'CS102', 18, '2024-01-12', 'B'),
(19, 'MATH201', 19, '2024-01-15', 'B'),
(20, 'ENG301', 20, '2024-01-18', 'A');

INSERT INTO `payments` (`studentID`, `paymentReference`, `paymentDate`,
`amount`)
VALUES
(1, 'PAY2024001', '2024-02-01', 500.00),
(2, 'PAY2024002', '2024-02-01', 750.00),
(3, 'PAY2024003', '2024-02-02', 1000.00),
(4, 'PAY2024004', '2024-02-03', 1500.00),
(5, 'PAY2024005', '2024-02-04', 2000.00),
(6, 'PAY2024006', '2024-02-05', 500.00),
(7, 'PAY2024007', '2024-02-06', 750.00),
(8, 'PAY2024008', '2024-02-07', 1000.00),
(9, 'PAY2024009', '2024-02-08', 1500.00),
(10, 'PAY2024010', '2024-02-09', 2000.00),
(11, 'PAY2024011', '2024-02-10', 500.00),
(12, 'PAY2024012', '2024-02-11', 750.00),
(13, 'PAY2024013', '2024-02-12', 1000.00),
(14, 'PAY2024014', '2024-02-13', 1500.00),
(15, 'PAY2024015', '2024-02-14', 2000.00),
(16, 'PAY2024016', '2024-02-15', 500.00),
(17, 'PAY2024017', '2024-02-16', 750.00),
(18, 'PAY2024018', '2024-02-17', 1000.00),
(19, 'PAY2024019', '2024-02-18', 1500.00),
(20, 'PAY2024020', '2024-02-19', 2000.00);

INSERT INTO `textbooks` (`isbn`, `title`, `author`, `publisher`, `price`, `courseCode`)
VALUES
('9780135166307', 'C Programming Language', 'Brian Kernighan', 'Prentice Hall', 89.99,
'CS101'),
('9780131103627', 'Data Structures Using C', 'Reema Thareja', 'Oxford University Press',
75.50, 'CS102'),
('9780134767180', 'Calculus: Early Transcendentals', 'James Stewart', 'Cengage Learning',
120.00, 'MATH201'),
('9780393927641', 'The Norton Anthology of English Literature', 'Stephen Greenblatt', 'W. W.
Norton & Company', 65.00, 'ENG301');
 
-- Q1- 321433225-S92073225 --
-- Call the procedure to display results for  all courses a student is enrolled in --
DROP PROCEDURE IF EXISTS CountStudentCourses;
DELIMITER //
CREATE PROCEDURE GetStudentCourses(IN student_num INT)
BEGIN
    SELECT c.courseCode, c.courseName, e.enrollmentDate
    FROM Courses c
    JOIN Course_enrollments e ON c.courseCode = e.courseCode
    WHERE e.studentID = student_num;
END //

DELIMITER ;

CALL GetStudentCourses('11')

-- Q2- 321433225-S92073225 --
-- count the number of courses a student is enrolled in --
DELIMITER //

CREATE PROCEDURE CountStudentCourses(IN student_num INT, OUT course_count INT)
BEGIN
    SELECT COUNT(*) INTO course_count
    FROM courseEnrollments
    WHERE studentID = student_num;
END //

DELIMITER ;

-- Declare a variable to store the output and call the procedure --
SET @count = 0;
CALL CountStudentCourses('11', @count);
SELECT @count AS "Course Count";

-- Q3- 321433225-S92073225 --
-- get the maximum credits allowed in all courses and store it --
DROP PROCEDURE IF EXISTS GetMaxCredits;
DELIMITER //

CREATE PROCEDURE GetMaxCredits(INOUT max_credits INT)
BEGIN
    SELECT MAX(credits) INTO max_credits
    FROM Courses;
END //

DELIMITER ;

-- Initialize and call the procedure --
SET @max_credits = 60;
CALL GetMaxCredits(@max_credits);
SELECT @max_credits AS "Maximum Credits Allowed";

-- Q4- 321433225-S92073225 --
-- calculate the total credits a student has earned --

DROP FUNCTION IF EXISTS CalculateTotalCredits;

DELIMITER //

CREATE FUNCTION CalculateTotalCredits(student_num INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_credits INT;
    SELECT SUM(c.credits) INTO total_credits
    FROM Courses c
    JOIN course_Enrollments e ON c.courseCode = e.courseCode
    WHERE e.studentID = student_num;
    RETURN IFNULL(total_credits, 0);  -- Return 0 if no enrollments
END //

DELIMITER ;

-- Q5- 321433225-S92073225 --
-- total credits for all students in the Enrollments table --

SELECT studentID, CalculateTotalCredits(studentID) AS "Total Credits"
FROM course_Enrollments
GROUP BY studentID;

-- Q6- 321433225-S92073225 --
--  count how many students are advised by a given advisor ID --
DROP FUNCTION IF EXISTS CountAdvisedStudents;

DELIMITER //

CREATE FUNCTION CountAdvisedStudents(advisor_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE advised_count INT;
    SELECT COUNT(*) INTO advised_count
    FROM students
    WHERE advisorID = advisor_id;
    RETURN advised_count;
END //

DELIMITER ;

-- Q7- 321433225-S92073225 --
-- calculate the total credits a student has enrolled in --
DROP FUNCTION IF EXISTS TotalEnrolledCredits;
DELIMITER //

CREATE FUNCTION TotalEnrolledCredits(student_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE enrolled_credits INT;
    SELECT SUM(c.credits) INTO enrolled_credits
    FROM Courses c
    JOIN course_Enrollments e ON c.courseID = e.courseID
    WHERE e.studentID = student_id;
    RETURN IFNULL(enrolled_credits, 0);  -- Return 0 if no enrollments
END //

DELIMITER ;



