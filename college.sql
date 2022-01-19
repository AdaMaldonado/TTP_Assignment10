CREATE DATABASE college;

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
(1, 'American Pluralism to 1877', 3),
(2, 'Physics I', 4),
(3, 'Multivariable Calculus', 2),
(4, 'Analysis of Algorithms', 1),
(5, 'Probability', 2),
(6, 'Intro to Quantum Mechanics', 4);

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


SELECT students.student_name, courses.course_name FROM students
INNER JOIN attends ON students.student_id = attends.student_id
INNER JOIN courses ON attends.course_id = courses.course_id;

SELECT students.student_name, courses.course_name, professors.prof_name
FROM students
INNER JOIN attends ON students.student_id = attends.student_id
INNER JOIN courses ON attends.course_id = courses.course_id
INNER JOIN teaches ON courses.course_id = teaches.course_id
INNER JOIN professors ON teaches.prof_id = professors.prof_id;

SELECT students.student_name, courses.course_name, professors.prof_name, departments.dept_name
FROM students
INNER JOIN attends ON students.student_id = attends.student_id
INNER JOIN courses ON attends.course_id = courses.course_id
INNER JOIN teaches ON courses.course_id = teaches.course_id
INNER JOIN professors ON teaches.prof_id = professors.prof_id
INNER JOIN departments ON professors.prof_dept_id = departments.dept_id;
