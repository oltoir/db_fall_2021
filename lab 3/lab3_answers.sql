-- 1.a
SELECT course_id, title, dept_name, credits
FROM course
WHERE credits > 3;
-- 5 rows
-- BIO-101,Intro. to Biology,Biology,4
-- BIO-301,Genetics,Biology,4
-- CS-101,Intro. to Computer Science,Comp. Sci.,4
-- CS-190,Game Design,Comp. Sci.,4
-- PHY-101,Physical Principles,Physics,4

-- 1.b
SELECT *
FROM classroom
WHERE building = 'Watson'
   or building = 'Packard';
-- 3 rows
-- Packard,101,500
-- Watson,100,30
-- Watson,120,50


-- 1.c
SELECT course_id, title, dept_name, credits
FROM course
WHERE dept_name = 'Comp. Sci.';
-- 5 rows
-- CS-101,Intro. to Computer Science,Comp. Sci.,4
-- CS-190,Game Design,Comp. Sci.,4
-- CS-315,Robotics,Comp. Sci.,3
-- CS-319,Image Processing,Comp. Sci.,3
-- CS-347,Database System Concepts,Comp. Sci.,3

-- 1.d
SELECT DISTINCT s.course_id, title
FROM section s
left join course c on c.course_id = s.course_id
WHERE semester = 'Fall';
-- 3 rows
-- CS-101,Intro. to Computer Science
-- CS-347,Database System Concepts
-- PHY-101,Physical Principles


-- 1.e
SELECT *
FROM student
WHERE tot_cred BETWEEN 45 and 90;
-- 6 rows
-- 19991,Brandt,History,80
-- 44553,Peltier,Physics,56
-- 45678,Levy,Physics,46
-- 54321,Williams,Comp. Sci.,54
-- 76543,Brown,Comp. Sci.,58
-- 76653,Aoi,Elec. Eng.,60

-- 1.f
SELECT id, name, dept_name, tot_cred
FROM student
WHERE name ~ '^.*[aeiouAEIOU]$';
-- 2 rows
-- 76653,Aoi,Elec. Eng.,60
-- 98988,Tanaka,Biology,120

-- 1.g
SELECT p.course_id, title, prereq_id
FROM prereq p
left join course c on c.course_id = p.course_id
WHERE prereq_id = 'CS-101';
-- 4 rows
-- CS-190,Game Design,CS-101
-- CS-315,Robotics,CS-101
-- CS-319,Image Processing,CS-101
-- CS-347,Database System Concepts,CS-101


-- 2.a
SELECT dept_name, avg(salary) as avg_salary
FROM instructor
GROUP BY dept_name
ORDER BY avg_salary;
-- 7 rows
-- Music,40000
-- History,61000
-- Biology,72000
-- Comp. Sci.,77333.333333333333
-- Elec. Eng.,80000
-- Finance,85000
-- Physics,91000

-- 2.b
SELECT building, count(DISTINCT (course_id)) as cnt
FROM section
GROUP BY building
ORDER BY cnt DESC
LIMIT 1;
-- Taylor,4

-- 2.c
SELECT dept_name, count(course_id) as cnt
FROM course
GROUP BY dept_name
HAVING count(course_id) = 1;
-- 1 row
-- Finance,1
--  or
-- 5 rows
-- Finance,1
-- History,1
-- Physics,1
-- Music,1
-- Elec. Eng.,1

-- 2.d
SELECT DISTINCT s.id, s.name
FROM student s
         LEFT JOIN takes t on s.id = t.id
         LEFT JOIN course c on t.course_id = c.course_id
WHERE c.dept_name = 'Comp. Sci.'
GROUP BY (s.id, s.name)
HAVING count(*) > 3;
-- 1 rows
-- 12345,Shankar


-- 2.e
SELECT id, name, dept_name
FROM instructor
WHERE dept_name in ('Biology', 'Philosophy', 'Music');
-- 2 rows
-- 15151,Mozart,Music
-- 76766,Crick,Biology


-- 2.f
SELECT DISTINCT i.id, name
FROM teaches t
         LEFT JOIN instructor i on i.id = t.id
WHERE t.year = 2018
  AND t.id NOT IN (SELECT id FROM teaches WHERE year = 2017);
-- 4 rows
-- 12121,Wu
-- 15151,Mozart
-- 32343,El Said
-- 45565,Katz


-- 3a
select distinct s.id, s.name
from student s
         left join takes t on s.id = t.id
         left join course c on t.course_id = c.course_id
where t.grade in ('A', 'A-')
  and c.dept_name = 'Comp. Sci.'
order by s.name;
-- 4 rows, same ORDER
-- 76543,Brown
-- 12345,Shankar
-- 54321,Williams
-- 00128,Zhang

-- 3b
select distinct i.id, i.name
from instructor i
         left join advisor a on i.id = a.i_id
         left join student s on s.id = a.s_id
         left join takes t on s.id = t.id
where t.grade >= 'B-';
-- 4 rows
-- 10101,Srinivasan
-- 98345,Kim
-- 22222,Einstein
-- 76543,Singh


-- 3c
select distinct d.dept_name
from department d
where d.dept_name NOT IN (
    SELECT dept_name
    FROM student s
             left join takes t on s.id = t.id
    where t.grade IN ('F', 'C')
);
-- 4 rows
-- Finance
-- History
-- Music
-- Biology


-- 3d
select id, name
from instructor
where id not in (
    select distinct t.id
    from teaches t
             left join takes t2
                       on t.course_id = t2.course_id
                           and t.sec_id = t2.sec_id
                           and t.semester = t2.semester
                           and t.year = t2.year
    where t2.grade = 'A');
-- 9 rows
-- 12121,Wu
-- 15151,Mozart
-- 22222,Einstein
-- 32343,El Said
-- 33456,Gold
-- 45565,Katz
-- 58583,Califieri
-- 76543,Singh
-- 98345,Kim

-- 3e
select distinct c.course_id, c.title
from course c,
     section s,
     time_slot t
where c.course_id = s.course_id
  and s.time_slot_id = t.time_slot_id
  and t.end_hr < 13;
-- 10 rows
-- CS-347,Database System Concepts
-- PHY-101,Physical Principles
-- CS-319,Image Processing
-- CS-190,Game Design
-- FIN-201,Investment Banking
-- BIO-101,Intro. to Biology
-- BIO-301,Genetics
-- CS-101,Intro. to Computer Science
-- HIS-351,World History
-- EE-181,Intro. to Digital Systems

-- or t.end_hr <= 13
-- 12 rows
-- CS-347,Database System Concepts
-- PHY-101,Physical Principles
-- CS-319,Image Processing
-- CS-315,Robotics
-- CS-190,Game Design
-- FIN-201,Investment Banking
-- BIO-101,Intro. to Biology
-- MU-199,Music Video Production
-- BIO-301,Genetics
-- CS-101,Intro. to Computer Science
-- HIS-351,World History
-- EE-181,Intro. to Digital Systems

