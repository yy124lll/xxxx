--book表拆分为三个表   图书表  出版社表  作家
--属性自拟 类型自拟  画出 E-R图,设定表关系,进行创建
create table 作家(
id int primary key auto_increment,
name varchar(30),
sex char
);

create table 出版社(
id int primary key auto_increment,
pname varchar(30),
address varchar(256)
);

create table 图书(
id int primary key auto_increment,
bname varchar(30),
price float,
author_id int,
publish_id int,
foreign key (author_id) references 作家(id),
foreign key (publish_id) references 出版社(id)
);

create table 作家_出版社(
id int primary key auto_increment,
a_id int,
p_id int,
foreign key (a_id) references 作家(id),
foreign key (p_id) references 出版社(id)
);

--综合查找练习
--1. 查询每位老师教授的课程数量
select tname,count(teacher_id) as 授课数量
from teacher left join course
on teacher.tid = course.teacher_id
group by tname;

--2. 查询学生的信息及学生所在班级信息
select sid,sname,gender,caption
from student left join class
on student.class_id = class.cid;

--3. 查询各科成绩最高和最低的分数,形式 : 课程ID  课程名称 最高分  最低分
select cid as 课程ID,cname as 课程名称,
max(number) as 最高分,min(number) as 最低分
from course left join score
on course.cid = score.course_id
group by cid,cname;

--4. 查询平均成绩大于85分的所有学生学号,姓名和平均成绩
select s.sid,sname,avg(number)
from student as s left join score
on s.sid = score.student_id
group by s.sid,sname
having avg(number)>85;

--5. 查询课程编号为2且课程成绩在80以上的学生学号和姓名
select student.sid,student.sname
from student left join score
on student.sid = score.student_id
where  course_id=2 and number>=80;

--6. 查询各个课程及相应的选修人数
select course.cname,count(student_id)
from course left join score
on course.cid = score.course_id
group by course.cname;


--视图操作
create or replace view good_stu as
select * from cls where score>=85;

alter view good_stu as
select id,name,score from cls where score>=90;

--函数
1. 函数内部不能直接写查询语句
2. 执行函数会顺次执行内部sql语句
delimiter $$

create function st1() returns int
begin
update cls set score=100 where id=1;
delete from cls where score>100;
return (select score from cls order by score desc limit 1);
end $$

delimiter ;

--变量的定义
1. 变量名不要和查询的字段重名
create function st2() returns int
begin
declare score_1 float;
declare score_2 float;
set score_1=(select score from cls where id=1);
select score from cls where id=2 into score_2;
return score_1+score_2;
end $$

--含参数函数
create function queryNameById(uid int)
returns varchar(20)
begin
return  (select name from cls where id=uid);
end $$

select queryNameById(1)
















