# College SQL Project 📊

This project is a simple relational database system for managing a college's student and subject data using **MySQL**.

It covers the following SQL concepts:
- ✅ Database & table creation (DDL)
- ✅ Data insertion and basic querying (DML)
- ✅ JOINs & aggregation functions
- ✅ Views and CTEs (Common Table Expressions)
- ✅ Stored Procedures
- ✅ DDL operations: ALTER, UPDATE, DELETE, TRUNCATE, DROP

## 📁 Tables Used
- `students` – stores student details like ID, name, age, gender, department
- `subjects` – stores subject details with department mapping
- `marks` – stores marks of students across subjects

## 🔧 Key Features
- Get student marks with stored procedure `GetStudentMarks()`
- View for student-subject-marks summary
- CTE to find students with high scores
- CASE statement for grading
- Aggregation: average marks by department, count of students

## 🚀 How to Use
1. Open your MySQL client
2. Run the `college_project.sql` script
3. Try out the provided sample queries
4. Use `CALL GetStudentMarks(student_id);` to get marks of a specific student

## 📌 Sample Query
```sql
SELECT s.name, sub.subject_name, m.marks
FROM students s

JOIN marks m ON s.student_id = m.student_id
JOIN subjects sub ON m.sub_id = sub.sub_id;
