-- a
select dept_name, avg (salary)
    from instructor
    group by dept_name
    ORDER BY avg(salary);

-- b


-- c
select dept_name,
       ( select count(*) from course
        where department.dept_name = course.dept_name)
        as num_courses
from department
order by num_courses; --it counts num of deps

-- d
select t.id, s.name
from takes as t, course as c, student as s
where c.course_id = t.course_id and c.dept_name = 'Comp. Sci.' and s.id = t.id
group by 1,2
having count(*) > 3;


-- e
SELECT name, dept_name FROM instructor
    WHERE dept_name = 'Biology'
       or dept_name = 'Music'
       or dept_name = 'Philosophy';

-- f
select distinct id
from teaches
where year = 2018 and
      id not in (select id
      from teaches
      where year= 2017);


