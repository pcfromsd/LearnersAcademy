CREATE USER LAAdmin IDENTIFIED BY 'LAAdmin';
GRANT ALL PRIVILEGES ON * . * TO LAAdmin;

DROP DATABASE LearnersAcademy;
CREATE DATABASE LearnersAcademy;
USE LearnersAcademy;

--------------------------------------------------------------------------------------------------

/*
drop table Student_Class;
drop table Class_Teacher;
drop table ClassTeacher;
drop table Student;
drop table Classs;
drop table Teacher;
drop table Subject;
drop table StudentView_T;
drop table Studentv;
drop table ClassTeacherView;

drop TRIGGER after_ClassTeacher_insert;
drop TRIGGER after_Classs_insert;
drop TRIGGER after_Student_insert
drop TRIGGER after_Student_Class_insert;
drop TRIGGER after_Student_insert;
drop TRIGGER after_Student_update;
*/

CREATE TABLE Subject (
  SubjectId              int(5) NOT NULL AUTO_INCREMENT,
  SubjectName            varchar(100) NOT NULL,
  SubjectShortcut        varchar(10)  NOT NULL UNIQUE,
  PRIMARY KEY (SubjectId)
) ENGINE=InnoDB;

--------------------------------------------------------------------------------------------------

CREATE TABLE Teacher (
  TeacherId              int(5) NOT NULL AUTO_INCREMENT,
  TeacherName            varchar(100) NOT NULL,
  PRIMARY KEY (teacherId)
)  ENGINE=InnoDB;

--------------------------------------------------------------------------------------------------

CREATE TABLE Classs (
  ClassId              int(5) NOT NULL AUTO_INCREMENT,
  Section              char(1),
  SubjectId            int(5) NOT NULL,
  PRIMARY KEY (ClassId)
) ENGINE=InnoDB; 

--------------------------------------------------------------------------------------------------

CREATE TABLE Student (
  StudentId              int(5) NOT NULL AUTO_INCREMENT,
  StudentName            varchar(100) NOT NULL,
  StudentGrade           varchar(10) NOT NULL,
  PRIMARY KEY (StudentId)
);

--------------------------------------------------------------------------------------------------

CREATE TABLE ClassTeacher (
  Id                     int(5) NOT NULL AUTO_INCREMENT,
  ClassId                int(5) NOT NULL,
  TeacherId              int(5) NOT NULL,
  PRIMARY KEY (Id)
);

CREATE TABLE Class_Teacher (
  Id                     int(5) NOT NULL AUTO_INCREMENT,
  ClassId                int(5) NOT NULL,
  TeacherId              int(5) NOT NULL,
  PRIMARY KEY (Id)
);

--------------------------------------------------------------------------------------------------

CREATE TABLE Student_Class (
  Id                     int(5) NOT NULL AUTO_INCREMENT,
  StudentId              int(5) NOT NULL,
  ClassId                int(5) NOT NULL,
  PRIMARY KEY (Id)
);

--------------------------------------------------------------------------------------------------

create table Studentv 
(
  Id                     int(5) NOT NULL AUTO_INCREMENT,
  StudentId              int(5) NOT NULL,
  StudentName            varchar(100) NOT NULL,
  StudentGrade           varchar(10) NOT NULL,  
  ClassId                int(5) NOT NULL,
  Section                char(1),
  SubjectId              int(5) NOT NULL,
  SubjectName            varchar(100) NOT NULL,
  SubjectShortcut        varchar(10)  NOT NULL,
  TeacherId              int(5),
  TeacherName            varchar(100) NOT NULL,
  PRIMARY KEY (Id)
 ) ENGINE=InnoDB; 

create or replace view StudentView as 
select s.StudentId, s.StudentName, s.StudentGrade, sc.ClassID, c.Section, sb.subjectId, sb.SubjectName, sb.SubjectShortcut, t.TeacherId, t.TeacherName 
   from Student s
   inner join Student_Class sc on sc.studentId = s.studentid   
   inner join Classs c on c.ClassId = sc.ClassId
   inner join Subject sb on sb.SubjectId = c.SubjectID 
   inner join ClassTeacher ct on ct.ClassId = c.ClassId
   inner join Teacher t on t.TeacherId = ct.TeacherId; 

-- insert into Studentv 
--   (StudentId, StudentName, StudentGrade, ClassID, Section, subjectId, SubjectName, SubjectShortcut, TeacherId, TeacherName) 
--   select * from StudentView;
-- commit;
-- select * from Studentv;

--------------------------------------------------------------------------------------------------

create table StudentView_T 
(
  Id                     int(5) NOT NULL AUTO_INCREMENT,
  StudentId              int(5) NOT NULL,
  StudentName            varchar(100) NOT NULL,
  ClassId                int(5) NOT NULL,
  Section                char(1),
  SubjectId              int(5) NOT NULL,
  SubjectName            varchar(100) NOT NULL,
  SubjectShortcut        varchar(10)  NOT NULL,
  TeacherId              int(5),
  TeacherName            varchar(100) NOT NULL,
  PRIMARY KEY (Id)
 ) ENGINE=InnoDB; 
-- insert into StudentView_T 
--   (StudentId, StudentName, ClassID, Section, subjectId, SubjectName, SubjectShortcut, TeacherId, TeacherName) 
--   select * from StudentView;
-- commit;
-- select * from StudentView_T;

--------------------------------------------------------------------------------------------------

create table ClassTeacherView
( 
  ClassId                int(5) NOT NULL,
  Section                char(1),
  SubjectId              int(5) NOT NULL,
  SubjectName            varchar(100) NOT NULL,
  SubjectShortcut        varchar(10)  NOT NULL,
  TeacherId              int(5),
  TeacherName            varchar(100),
  PRIMARY KEY (ClassId)
) ENGINE=InnoDB; 

-- insert into ClassTeacherView
--   select * from ClassTeacherView_
-- ;
-- commit;
-- delete from ClassTeacherView where ClassId <> 0;
-- select * from ClassTeacherView;

--------------------------------------------------------------------------------------------------

create table StudentClassView
( 
  Id                     int(5) NOT NULL AUTO_INCREMENT,
  StudentId              int(5) NOT NULL,
  StudentName            varchar(100) NOT NULL,
  StudentGrade           varchar(10) NOT NULL,
  ClassId                int(5),
  Section                char(1),
  SubjectId              int(5),
  SubjectName            varchar(100),
  SubjectShortcut        varchar(10),
  PRIMARY KEY (Id)
) ENGINE=InnoDB; 


-------------------------------------------------------------------------------------------------

ALTER TABLE Classs ADD CONSTRAINT Class_FK2 FOREIGN KEY (SubjectId) REFERENCES Subject(SubjectId);
ALTER TABLE Student_Class ADD CONSTRAINT Students_Class_FK1 FOREIGN KEY (StudentId) REFERENCES Student (StudentId);
ALTER TABLE Student_Class ADD CONSTRAINT Students_Class_FK2 FOREIGN KEY (ClassId) REFERENCES Classs (ClassId);
ALTER TABLE ClassTeacher ADD CONSTRAINT ClassTeacher_FK1 FOREIGN KEY (ClassId) REFERENCES Classs (ClassId);
ALTER TABLE ClassTeacher ADD CONSTRAINT ClassTeacher_FK2 FOREIGN KEY (TeacherId) REFERENCES Teacher (TeacherId);


-------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE TRIGGER after_Classs_insert
AFTER INSERT
ON Classs FOR EACH ROW
BEGIN
	INSERT INTO ClassTeacherView(ClassId, Section, SubjectId, SubjectName, SubjectShortcut)
       select c.ClassId, c.Section, s.SubjectId, s.SubjectName, s.SubjectShortcut
         from Classs as c
         inner join Subject as s on s.SubjectId = c.SubjectId
         where c.classId = new.classId;
END$$

DELIMITER ;

-------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE TRIGGER after_ClassTeacher_insert
AFTER INSERT
ON ClassTeacher FOR EACH ROW
BEGIN
	update ClassTeacherView 
       set teacherId = new.teacherId,
           teacherName = (select teacherName from teacher where teacherid = new.teacherId)
         where classId = new.classId and teacherId is null;
END$$

DELIMITER ;

-------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE TRIGGER after_Student_Class_insert
AFTER INSERT
ON Student_Class FOR EACH ROW
BEGIN
	update StudentClassView 
       set ClassId = new.ClassId,
           section = (select section from classs where classid = new.classId),
		   subjectId = (select subjectId from classs where classId = new.classId),
		   subjectName = (select subjectName from subject where subjectId = (select subjectId from classs where classId = new.classId)),
		   subjectShortcut = (select subjectShortcut from subject where subjectId = (select subjectId from classs where classId = new.classId))
         where StudentId = new.StudentId;

END$$

DELIMITER ;

-------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE TRIGGER after_Student_insert
AFTER INSERT
ON Student FOR EACH ROW
BEGIN

	INSERT INTO StudentClassView(StudentId, StudentName, StudentGrade)
       select StudentId, StudentName, StudentGrade
         from Student as s
         where s.StudentId = new.StudentId;


	IF not exists (select 'x' from Studentv where StudentId = new.StudentId) THEN
		insert into Studentv 
			(StudentId, StudentName, StudentGrade, ClassID, Section, subjectId, SubjectName, SubjectShortcut, TeacherId, TeacherName) 
			select s.StudentId, s.StudentName, s.StudentGrade, sc.ClassID, c.Section, sb.subjectId, sb.SubjectName, sb.SubjectShortcut, t.TeacherId, t.TeacherName 
				from Student s
				inner join Student_Class sc on sc.studentId = s.studentid   
				inner join Classs c on c.ClassId = sc.ClassId
				inner join Subject sb on sb.SubjectId = c.SubjectID 
				inner join ClassTeacher ct on ct.ClassId = c.ClassId
				inner join Teacher t on t.TeacherId = ct.TeacherId
				where s.StudentId = new.StudentId
				  and not exists (select 'x' from Studentv where StudentId = new.StudentId);
	END IF;
END$$

DELIMITER ;

-------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE TRIGGER after_Student_update
AFTER UPDATE
ON Student FOR EACH ROW
BEGIN
	IF not exists (select 'x' from Studentv where StudentId = new.StudentId) THEN
		insert into Studentv 
			(StudentId, StudentName, StudentGrade, ClassID, Section, subjectId, SubjectName, SubjectShortcut, TeacherId, TeacherName) 
			select s.StudentId, s.StudentName, s.StudentGrade, sc.ClassID, c.Section, sb.subjectId, sb.SubjectName, sb.SubjectShortcut, t.TeacherId, t.TeacherName 
				from Student s
				inner join Student_Class sc on sc.studentId = s.studentid   
				inner join Classs c on c.ClassId = sc.ClassId
				inner join Subject sb on sb.SubjectId = c.SubjectID 
				inner join ClassTeacher ct on ct.ClassId = c.ClassId
				inner join Teacher t on t.TeacherId = ct.TeacherId
				where s.StudentId = new.StudentId
				  and not exists (select 'x' from Studentv where StudentId = new.StudentId);
	END IF;
END$$

DELIMITER ;

-------------------------------------------------------------------------------------------------

insert into Subject (SubjectName, SubjectShortcut) values ('Mathematics Basics', 'MATH01');
insert into Subject (SubjectName, SubjectShortcut) values ('Advanced History', 'HIST02');
commit;

-------------------------------------------------------------------------------------------------
insert into Teacher (TeacherName) values ('Teacher1 Chakraborty');
insert into Teacher (TeacherName) values ('Teacher2 Chakraborty');
commit;

-------------------------------------------------------------------------------------------------

insert into Classs (Section, SubjectId) values ('A', 1);
insert into Classs (Section, SubjectId) values ('B', 2);
insert into Classs (Section, SubjectId) values ('C', 1);
commit;

-- select * from Classs;
-- select * from ClassTeacher;
-- select * from ClassTeacherView;

-------------------------------------------------------------------------------------------------

insert into Student (StudentName, StudentGrade) values ('Purnendu Chakraborty', 'XII');
insert into Student (StudentName, StudentGrade) values ('Sumana Chakraborty', 'XI');
commit;

-------------------------------------------------------------------------------------------------

insert into ClassTeacher (ClassId, TeacherId) values (4, 1);
insert into ClassTeacher (ClassId, TeacherId) values (5, 2);
commit;

-------------------------------------------------------------------------------------------------

insert into Student_Class (StudentId, ClassId) values (1, 1);
insert into Student_Class (StudentId, ClassId) values (2, 2);
commit;

-------------------------------------------------------------------------------------------------

create or replace view ClassSubjectView as 
select c.ClassId, c.Section, s.SubjectId, s.SubjectName, s.SubjectShortcut 
   from Classs as c
   inner join Subject as s on s.SubjectId = c.SubjectId;

-------------------------------------------------------------------------------------------------

create or replace view ClassTeacherView_ as 
select c.ClassId, c.Section, s.SubjectId, s.SubjectName, s.SubjectShortcut, t.TeacherId, t.TeacherName
   from Classs as c
   inner join Subject as s on s.SubjectId = c.SubjectId
   left outer join ClassTeacher ct on ct.ClassId = C.ClassId
   left outer join Teacher as t on t.TeacherId = ct.TeacherId
;

-------------------------------------------------------------------------------------------------

/*
select * from Subject;
select * from Teacher;
select * from Classs;
select * from Student;
select * from ClassSubjectView;
select * from ClassView;
select * from StudentView;
select * from ClassTeacherView;
select * from ClassTeacherView_;
select * from ClassTeacher;

delete from Classs where classid >0;
commit;
*/

-------------------------------------------------------------------------------------------------

