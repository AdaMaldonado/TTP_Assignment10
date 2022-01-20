/* After starting psql in the shell, issuing the following commands will 
create and appropriately populate the database 'college':*/


/* Creating and switching to 'college' database */
CREATE DATABASE college;
\c college


/* Creating each table in the 'college' database:*/
CREATE TABLE students
(
    student_id integer NOT NULL UNIQUE,
    student_name text COLLATE pg_catalog."default" NOT NULL,
    student_dob date NOT NULL
);

CREATE TABLE departments
(
    dept_id integer NOT NULL,
    dept_name text COLLATE pg_catalog."default" NOT NULL
);

CREATE TABLE courses
(
    course_id integer NOT NULL,
    course_name text COLLATE pg_catalog."default" NOT NULL,
    dept_id integer NOT NULL
);

CREATE TABLE professors
(
    prof_id integer NOT NULL,
    prof_name text COLLATE pg_catalog."default" NOT NULL,
    prof_dob date NOT NULL,
    prof_dept_id integer NOT NULL
);

CREATE TABLE attends
(
    student_id integer NOT NULL,
    course_id integer NOT NULL
);

CREATE TABLE teaches
(
    prof_id integer NOT NULL,
    course_id integer NOT NULL
);

/* Insertion of dummy tuples into each table: */
INSERT INTO students(student_id, student_name, student_dob)
VALUES 
(1, 'John Doe', '1999-09-01'),
(2, 'Jane Doe', '1995-09-01'),
(3, 'Henry Fox', '1995-03-15'),
(4, 'Jack Smith', '1994-01-21');

INSERT INTO departments(dept_id, dept_name)
VALUES 
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'History'),
(4, 'Physics');

INSERT INTO professors(prof_id, prof_name, prof_dob, prof_dept_id)
VALUES 
(1, 'Gottfried Leibniz', '1960-3-15', 2),
(2, 'Alan Turing', '1970-1-23', 1),
(3, 'Erwin Schrödinger', '1951-9-3', 4),
(4, 'Norman Davies', '1951-11-19', 3);

INSERT INTO courses(course_id, course_name, dept_id)
VALUES 
(1, 'History I', 3),
(2, 'Physics I', 4),
(3, 'Calculus I', 2),
(4, 'Algorithms', 1),
(5, 'Probability', 2),
(6, 'Quantum Mechanics', 4);

INSERT INTO attends(student_id, course_id)
VALUES 
(1, 2), 
(2, 3),
(4, 6),
(4, 3),
(1, 4),
(3, 5),
(2, 2),
(3, 4);

INSERT INTO teaches(prof_id, course_id)
VALUES 
(1, 3), 
(1, 5), 
(2, 4), 
(3, 2), 
(3, 6), 
(4, 1);


/* INNER JOIN queries joining 2, 3, and all 4 main entities, respecitvely */
SELECT students.student_name, courses.course_name FROM students
INNER JOIN attends ON students.student_id = attends.student_id
INNER JOIN courses ON attends.course_id = courses.course_id;

/* Output:

college=# SELECT students.student_name, courses.course_name FROM students
college-# INNER JOIN attends ON students.student_id = attends.student_id
college-# INNER JOIN courses ON attends.course_id = courses.course_id ORDER by students.student_name asc;

 student_name |        course_name
--------------+----------------------------
 Henry Fox    | Algorithms
 Henry Fox    | Probability
 Jack Smith   | Quantum Mechanics
 Jack Smith   | Calculus I
 Jane Doe     | Calculus I
 Jane Doe     | Physics I
 John Doe     | Algorithms
 John Doe     | Physics I
(8 rows)*/

SELECT students.student_name, courses.course_name, professors.prof_name
FROM students
INNER JOIN attends ON students.student_id = attends.student_id
INNER JOIN courses ON attends.course_id = courses.course_id
INNER JOIN teaches ON courses.course_id = teaches.course_id
INNER JOIN professors ON teaches.prof_id = professors.prof_id;


/* Output: 

college=# SELECT students.student_name, courses.course_name, professors.prof_name
college-# FROM students
college-# INNER JOIN attends ON students.student_id = attends.student_id
college-# INNER JOIN courses ON attends.course_id = courses.course_id
college-# INNER JOIN teaches ON courses.course_id = teaches.course_id
college-# INNER JOIN professors ON teaches.prof_id = professors.prof_id ORDER BY students.student_name ASC;

 student_name |        course_name         |     prof_name
--------------+----------------------------+-------------------
 Henry Fox    | Algorithms                 | Alan Turing
 Henry Fox    | Probability                | Gottfried Leibniz
 Jack Smith   | Quantum Mechanics          | Erwin Schrödinger
 Jack Smith   | Calculus I                 | Gottfried Leibniz
 Jane Doe     | Calculus I                 | Gottfried Leibniz
 Jane Doe     | Physics I                  | Erwin Schrödinger
 John Doe     | Algorithms                 | Alan Turing
 John Doe     | Physics I                  | Erwin Schrödinger
(8 rows) */

SELECT students.student_name, courses.course_name, professors.prof_name, departments.dept_name
FROM students
INNER JOIN attends ON students.student_id = attends.student_id
INNER JOIN courses ON attends.course_id = courses.course_id
INNER JOIN teaches ON courses.course_id = teaches.course_id
INNER JOIN professors ON teaches.prof_id = professors.prof_id
INNER JOIN departments ON professors.prof_dept_id = departments.dept_id;

/* Output:

college=# SELECT students.student_name, courses.course_name, professors.prof_name, departments.dept_name
college-# FROM students
college-# INNER JOIN attends ON students.student_id = attends.student_id
college-# INNER JOIN courses ON attends.course_id = courses.course_id
college-# INNER JOIN teaches ON courses.course_id = teaches.course_id
college-# INNER JOIN professors ON teaches.prof_id = professors.prof_id
college-# INNER JOIN departments ON professors.prof_dept_id = departments.dept_id ORDER BY students.student_name ASC;

 student_name |        course_name         |     prof_name     |    dept_name
--------------+----------------------------+-------------------+------------------
 Henry Fox    | Algorithms                 | Alan Turing       | Computer Science
 Henry Fox    | Probability                | Gottfried Leibniz | Mathematics
 Jack Smith   | Quantum Mechanics          | Erwin Schrödinger | Physics
 Jack Smith   | Calculus I                 | Gottfried Leibniz | Mathematics
 Jane Doe     | Calculus I                 | Gottfried Leibniz | Mathematics
 Jane Doe     | Physics I                  | Erwin Schrödinger | Physics
 John Doe     | Algorithms                 | Alan Turing       | Computer Science
 John Doe     | Physics I                  | Erwin Schrödinger | Physics
(8 rows) */
