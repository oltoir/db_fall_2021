-- a
SELECT distinct name
from student as s, takes as t
WHERE dept_name = 'Comp. Sci.' and (t.id = s.id and grade LIKE 'A%')
ORDER BY name;

-- b
SELECT distinct name
FROM takes, advisor, instructor
WHERE NOT grade LIKE 'A%' and takes.id = advisor.s_id and advisor.i_id = instructor.id;

-- c


-- d

-- e
SELECT distinct time_slot.time_slot_id, title
from time_slot, course, section
where end_hr < 13 and section.time_slot_id = time_slot.time_slot_id and course.course_id = section.course_id
order by time_slot.time_slot_id;



