/*1*/
/*a */
select title as courses, dept_name as department, credits from course
where credits > 3;

/*b */
select building, room_number as classroom from classroom
where building = 'Watson'
or building = 'Packard';

/*c */
select course_id, title as courses, dept_name as department from course
where dept_name = 'Comp. Sci.';

/*d */
select section.course_id, dept_name as courses from section inner join course on section.course_id = course.course_id
where semester = 'Fall';

select section.course_id, dept_name from section inner join course c on section.course_id = c.course_id
where semester = 'Fall'
intersect
select course_id, dept_name from course;

/*select * from section cross join course - bad dor finding id == id*/
/*select * from section inner join course on section.course_id = course.course_id;*/

/*e*/
select name as students, tot_cred as credits from student
where tot_cred>45 and tot_cred<95;

/*f*/
select name from student
where right(name, 1) = 'a' or
      right(name, 1) = 'e' or
      right(name, 1) = 'i' or
      right(name, 1) = 'o' or
      right(name, 1) = 'u';

/*g*/
select prereq_id, '---->' as prereq_for, course.course_id, title from course inner join prereq on course.course_id = prereq.course_id
where prereq.prereq_id = 'CS-101';

/**/
select name, salary from instructor
order by instructor.salary desc
limit 5;
/*2*/
/*a*/
select dept_name as department, avg(salary) as avg_salary from instructor
group by dept_name
order by avg_salary nulls last;

/*b*//*
select building, capacity from classroom
order by capacity desc nulls last
limit 1;*/

select building, count(building) from section
group by building
order by count(building) desc nulls last
limit 1;
/*c*/
select dept_name as department, count(dept_name) as amount_of_corses from course
group by dept_name
having count(dept_name)<=count(dept_name)+1;


/*////////////////// */

select dept_name as department, count(dept_name) as amount_of_corses from course
where dept_name = 'Finance'
group by dept_name
having count(dept_name) < 5
order by count(dept_name) nulls last

/*d*/

select student.ID, name, count(takes.id) as ans from takes inner join student on takes.id = student.id
where left(course_id, 2) = 'CS'
group by student.ID, name
having count(takes.id)>3;


/*e*/
select name, dept_name as department from instructor
where dept_name = 'Biology' or
      dept_name = 'Philosophy' or
      dept_name = 'Music';

/*f*/
select distinct name, year, dept_name from instructor inner join teaches on instructor.id = teaches.id
where year = 2018 and year!=2017;


/*3*/
/*a*/
select distinct(student.name), student.id, dept_name, grade from takes inner join student on takes.id = student.id
where dept_name = 'Comp. Sci.' and grade like 'A%'
order by grade;

/*b*/
select instructor.name as advisor, i_id as advisor_id, student.name as student, student.id as student_id, course_id, grade as students_grade
from student
inner join advisor on student.id = advisor.s_id
inner join instructor on advisor.i_id = instructor.id
inner join takes on student.id = takes.id
where grade like 'C%' or grade like 'F' or grade is null;

/*select * from student
inner join advisor on student.id = advisor.s_id
inner join instructor on advisor.i_id = instructor.id
inner join takes on student.id = takes.id
where grade like 'C%' or grade like 'F'*/

/*or*/
/*simply without tryharding*/
select student.name as student, i_id as advisor,  student.id as student_id, grade
from student inner join takes t on student.id = t.id inner join advisor a on student.id = a.s_id
    except
select student.name as student, i_id as advisor, student.id, grade
from student inner join takes t on student.id = t.id inner join advisor a on student.id = a.s_id
where grade like 'B%' or grade like 'A%' or grade is null;

/*or*/

select instructor.name as advisor, i_id as advisor_id, student.name as student, student.id as student_id, course_id, grade as students_grade
from student
inner join advisor on student.id = advisor.s_id
inner join instructor on advisor.i_id = instructor.id
inner join takes on student.id = takes.id
    except
select instructor.name as advisor, i_id as advisor_id, student.name as student, student.id as student_id, course_id, grade as students_grade
from student
inner join advisor on student.id = advisor.s_id
inner join instructor on advisor.i_id = instructor.id
inner join takes on student.id = takes.id
where grade like 'B%' or grade like 'A%' or grade is null;

/*c*/
select dept_name from student inner join takes on student.id = takes.id
except
select dept_name from student inner join takes on student.id = takes.id
where grade like 'C%' or grade like 'F' or grade is  null;

/*d*/
select name from instructor inner join teaches on instructor.id = teaches.id
inner join takes on teaches.course_id = takes.course_id
except
select name from instructor inner join teaches on instructor.id = teaches.id
inner join takes on teaches.course_id = takes.course_id
where grade like 'A%';

/*e*/
select title, day, start_hr,start_min, end_hr,end_min from section inner join course on section.course_id = course.course_id
inner join time_slot ts on section.time_slot_id = ts.time_slot_id
where end_hr < 13 and end_min <= 59
order by case
    WHEN start_hr=8 THEN 1
    WHEN start_hr=9 THEN 2
    WHEN start_hr=10 THEN 3
    WHEN start_hr=11 THEN 4
    WHEN start_hr=12 THEN 5 end;