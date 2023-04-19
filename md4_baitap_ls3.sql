create database md4_ls3_baitap;
use md4_ls3_baitap;
CREATE TABLE Class (
	classId int primary key auto_increment,
    className varchar(255) unique not null,
    startDate datetime default now(),
    statusClass tinyint 
);
insert into Class(className,startDate,statusClass)  values 
("A1", '2008/12/20', 1),
("A2", '2008/12/22', 1),
("A3",'2008/12/12', 0)
;
create table studentmanage(
	studentId int primary key auto_increment, 
    studenName varchar(255)  not null,
	address text,
	phoneNumber varchar(255),
	statusStd tinyint,
    classId int ,
    foreign key (classId) references Class (classId)
);
insert into studentmanage values 
(null, "Hung", "Ha Noi", "0389373739287",  1,1),
(null, "Hoa ", "Hai phong", null,  1,1),
(null, "Manh", "HCM", null, 0,2 );

create table `subject`(
	subjectId int primary key  auto_increment ,
    subjectName varchar(255) not null,
    credit int ,
    status1 tinyint 
);

-- nhap du lieu vao cho bang  subject
insert into `subject` (subjectname, credit,status1) values
("CF", 5, 1),
("C", 6,1 ),
("HDJ", 5,1),
("RDBMS", 10,1);
-- nhap du lieu vao cho bang  student
create table Mark (
	markId int primary key auto_increment,
    subId int ,
    foreign key (subId) references `subject`(subjectId),
    studentId int ,
    foreign key (subId) references studentmanage(studentId),
    mark tinyint ,
	examTimes time 
);
insert into Mark (subId,studentId,mark,examTimes) values 
	(1,1,8,1), (1,2,10,2),(2,1,12,1);
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from studentmanage where studenName like "h%";
select * from Class where month(startdate) = 12;
select * from `subject` where credit between 3 and 5;
update studentmanage
set classId = 2
where studenName = "Hung";
-- Select u.fullName , od.productName, od.quantity, o.createDtate from ((users u join order o on u.id = o.user_id)join order_detail od on od.id = od.order_id);
-- •	Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.

select studentmanage.studenName, `subject`.subjectName, mark.mark
from studentmanage join mark on studentmanage.studentId = mark.studentId 
	join `subject` on `subject`.subjectId = mark.subid
    order by mark.mark desc, studentmanage.studenName asc
