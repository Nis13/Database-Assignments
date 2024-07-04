create schema assignment_3

CREATE TABLE Students (
student_id INT PRIMARY KEY,
student_name VARCHAR(100),
student_major VARCHAR(100)
);

-- Create Courses table
CREATE TABLE Courses (
course_id INT PRIMARY KEY,
course_name VARCHAR(100),
course_description VARCHAR(255)
);

-- Create Enrollments table
CREATE TABLE Enrollments (
enrollment_id INT PRIMARY KEY,
student_id INT,
course_id INT,
enrollment_date DATE,
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert data into Students table
INSERT INTO Students (student_id, student_name, student_major) VALUES
(1, 'Alice', 'Computer Science'),
(2, 'Bob', 'Biology'),
(3, 'Charlie', 'History'),
(4, 'Diana', 'Mathematics');

-- Insert data into Courses table
INSERT INTO Courses (course_id, course_name, course_description) VALUES
(101, 'Introduction to CS', 'Basics of Computer Science'),
(102, 'Biology Basics', 'Fundamentals of Biology'),
(103, 'World History', 'Historical events and cultures'),
(104, 'Calculus I', 'Introduction to Calculus'),
(105, 'Data Structures', 'Advanced topics in CS');

-- Insert data into Enrollments table
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 101, '2023-01-15'),
(2, 2, 102, '2023-01-20'),
(3, 3, 103, '2023-02-01'),
(4, 1, 105, '2023-02-05'),
(5, 4, 104, '2023-02-10'),
(6, 2, 101, '2023-02-12'),
(7, 3, 105, '2023-02-15'),
(8, 4, 101, '2023-02-20'),
(9, 1, 104, '2023-03-01'),
(10, 2, 104, '2023-03-05');

--1. Inner Join:
--Question: Retrieve the list of students and their enrolled courses

select s.student_name, c.course_name 
from students s 
inner join enrollments e on e.student_id = s.student_id
inner join courses c on c.course_id = e.course_id 

--2. Left Join:
--Question: List all students and their enrolled courses, including those who haven't enrolled in
--any course.

select s.student_name, c.course_name 
from students s 
left join enrollments e on e.student_id = s.student_id
left join courses c on c.course_id = e.course_id 

--3. Right Join:
--Question: Display all courses and the students enrolled in each course, including courses with
--no enrolled students
select s.student_name, c.course_name 
from students s 
right join enrollments e on e.student_id = s.student_id
right join courses c on c.course_id = e.course_id 


-- Self Join:
-- Question: Find pairs of students who are enrolled in at least one common course.
SELECT DISTINCT 
  (SELECT s.student_name FROM students s WHERE s.student_id = e.student_id) AS student1, 
  (SELECT s.student_name FROM students s WHERE s.student_id = e2.student_id) AS student2
FROM enrollments e 
JOIN enrollments e2 ON e.course_id = e2.course_id AND e.student_id > e2.student_id;

--5. Complex Join:
--Question: Retrieve students who are enrolled in 'Introduction to CS' but not in 'Data Structures'.
select s.student_name
from students s 
join enrollments e on s.student_id =e.student_id 
join courses c on e.course_id = c.course_id 
where course_name = 'Introduction to CS' and course_name <> 'Data Structures';

--Windows function:
--1. Using ROW_NUMBER():
--Question: List all students along with a row number based on their enrollment date in
--ascending order.
SELECT s.student_name, e.enrollment_date, 
       ROW_NUMBER() OVER (ORDER BY e.enrollment_date) AS row_num
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id;

--2. Using RANK():
--Question: Rank students based on the number of courses they are enrolled in, handling ties by
--assigning the same rank.
select s.student_name, count(course_id) as course_count,
	rank() over (order by count(e.course_id) desc ) as rank
	from students s 
	join enrollments e on e.student_id = s.student_id 
	group by s.student_name ;

--3. Using DENSE_RANK():
--Question: Determine the dense rank of courses based on their enrollment count across all
--students
select c.course_name, count(e.student_id),
 dense_rank() over(order by count(e.student_id) desc ) as rank 
 from courses c 
 join enrollments e on e.course_id = c.course_id 
 group by c.course_name;
	







