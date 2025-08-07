create database college;   -- created a database called "college"
use college;  -- we have to use the database to enable tables and let values in them

create table students(
student_id int primary key, -- to have unique id for each student
name varchar(20),           -- we use varchar when we don't know how many charachters we insert to avoid wastage of memory as it reuses
gender char(1),             -- when we know how many we insert  
age int,
department varchar(20)
);

create table subjects(
subject_id int primary key,
subject_name varchar(20),
department varchar(20)
);

create table marks(
mark_id int primary key,
student_id int,  
subject_id int,
marks int,
foreign key (student_id) references students(student_id),  -- used to connect the students table student_id and marks table student_id
foreign key (subject_id ) references subjects(subject_id )    -- used to connect the subjects table subject_id and marks table subject_id
);

-- inserting values into students table

INSERT INTO students (student_id, name, gender, age, department) VALUES
(1, 'Alice', 'F', 20, 'Computer Science'),
(2, 'Bob', 'M', 21, 'Mechanical'),
(3, 'Carol', 'F', 19, 'Electrical'),
(4, 'Dave', 'M', 22, 'Civil'),
(5, 'Eva', 'F', 20, 'Computer Science'),
(6, 'Frank', 'M', 23, 'Mechanical'),
(7, 'Grace', 'F', 21, 'Electrical'),
(8, 'Henry', 'M', 22, 'Civil'),
(9, 'Ivy', 'F', 20, 'Computer Science'),
(10, 'Jack', 'M', 19, 'Mechanical'),
(11, 'Kira', 'F', 21, 'Electrical'),
(12, 'Leo', 'M', 22, 'Civil'),
(13, 'Mona', 'F', 20, 'Computer Science'),
(14, 'Nick', 'M', 21, 'Mechanical'),
(15, 'Olive', 'F', 19, 'Electrical');

-- inserting values into subjects table

INSERT INTO subjects (subject_id, subject_name, department) VALUES
(1, 'Maths', 'Computer Science'),
(2, 'Physics', 'Mechanical'),
(3, 'Circuits', 'Electrical'),
(4, 'Structures', 'Civil'),
(5, 'Data Structures', 'Computer Science'),
(6, 'Thermodynamics', 'Mechanical'),
(7, 'Electronics', 'Electrical'),
(8, 'Surveying', 'Civil'),
(9, 'Algorithms', 'Computer Science'),
(10, 'Fluid Mechanics', 'Mechanical'),
(11, 'Power Systems', 'Electrical'),
(12, 'Concrete Tech', 'Civil'),
(13, 'Operating Systems', 'Computer Science'),
(14, 'Machine Design', 'Mechanical'),
(15, 'Digital Logic', 'Electrical');

-- insert values into marks table

INSERT INTO marks (mark_id, student_id, subject_id, marks) VALUES
(1, 1, 1, 85),
(2, 2, 2, 78),
(3, 3, 3, 90),
(4, 4, 4, 88),
(5, 5, 5, 95),
(6, 6, 6, 70),
(7, 7, 7, 82),
(8, 8, 8, 75),
(9, 9, 9, 89),
(10, 10, 10, 80),
(11, 11, 11, 91),
(12, 12, 12, 77),
(13, 13, 13, 94),
(14, 14, 14, 73),
(15, 15, 15, 87);


-- to retrive all the data from tables

select * from students;

select * from subjects;

select * from marks;

select distinct name,age from students;  -- distinct is used to take only the unique values and removes the duplicates

select * from students where department ='Computer Science'; -- is used to filter the records who belongs to 'Computer Science' department

select * from students where age > 20; -- is used to filter the records who age is greater than  20

select * from marks where marks > 85; -- is used to filter who scored more than 85 marks

select * from students order by name desc; -- is used to sort the names in the descending order i.e.,big to small

select * from marks order by marks desc; -- is used to sort the names in the descending order i.e.,big to small

select * from marks limit 5; -- Top 5 highest scores

select *  from students order by name desc limit 10; -- First 10 students alphabetically

describe students; -- it is a schema representation where schema will tell us how the data in a table has been stored in table students
describe subjects; -- schema in table subjects
describe marks; -- schema in table marks

-- List of names of students along with the subjects offered in their department.
select s.name,sub.subject_name from 
students s
join
subjects sub
on s.department = sub.department;

-- the average marks scored by students in each department.
select s.department,avg(m.marks) as avg_marks from
students s
join
marks m
on s.student_id = m.student_id
Group by s.department;

-- departments where the average marks of students are less than 60.
select s.department,avg(m.marks) as avg_marks from
students s
join
marks m
on s.student_id = m.student_id
Group by s.department
Having avg_marks < 80;

-- Labelling students based on their marks.
select s.name,m.marks,
CASE
     when m.marks > 80 THEN 'Excellent'
     when m.marks > 50 or m.marks < 80 THEN 'Good'
     ELSE 'Need improvement'
     END 
from
students s
join
marks m
on s.student_id = m.student_id;

-- Max Marks per Department
select department,max(marks) from 
students s
join
marks m
on s.student_id = m.student_id
Group by department;

-- Count of Students per Department
select department,count(*) from 
students 
Group by department;

-- Subjects per Department
select s.department,count(*) from 
students s
join
subjects sub
on s.department = sub.department
Group by s.department;

-- cte (common table Expression) are used to store temperory results
WITH dept_avg AS (
    SELECT s.department, AVG(m.marks) AS avg_marks
    FROM students s
    JOIN marks m ON s.student_id = m.student_id
    GROUP BY s.department
)
SELECT * FROM dept_avg
WHERE avg_marks > 80;

-- views are virtual tables which doesn't exists 
CREATE VIEW department_summary AS
SELECT s.department, COUNT(DISTINCT s.student_id) AS total_students,
       AVG(m.marks) AS avg_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.department;

-- procedures are like functions in sql like in other programming Language
DELIMITER //                                      -- it is used to tell that the query has started from here we give "//" as a symbol it is our wish
CREATE PROCEDURE GetStudentMarks (IN sid INT)
BEGIN
  SELECT s.name, sub.subject_name, m.marks
  FROM students s
  JOIN marks m ON s.student_id = m.student_id
  JOIN subjects sub ON m.subject_id = sub.subject_id
  WHERE s.student_id = sid;
END //
DELIMITER ;                                            -- end the query

-- we call it 
CALL GetStudentMarks(2);

-- Add a new column 'email' to students table it basically changes the structure of a table.
ALTER TABLE students ADD email VARCHAR(50); -- we can add/modify/drop the existing rows


-- Update a student's department it basically changes the data of a table.
UPDATE students 
SET department = 'Information Technology' 
WHERE name = 'Alice';

-- Delete a student by ID or we can remove the required rows from table
DELETE FROM students 
WHERE student_id = 15;

-- truncate is used to remove the records from the table.
truncate table students;

-- to remove the table completely from the database.
Drop table students;
-- also we can remove the database aswell.
Drop database college;