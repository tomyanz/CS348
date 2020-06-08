connect to cs348

--
--  Schema definition for ENROLLMENT database, with sample data.
--

echo "dropping old tables"

drop table enrollment
drop table officehour
drop table class
drop table course
drop table student
drop table professor

echo "creating new tables"

create table professor ( \
   pnum     integer not null, \ 
   lastname varchar(30) not null, \
   office   char(6) not null, \
   dept     char(2) not null, \
   primary key (pnum))

insert into professor values (1, 'Weddell', 'DC3346', 'CS')
insert into professor values (2, 'Gao', 'DC1234', 'CS')
insert into professor values (3, 'Goldberg', 'DC3000', 'CO')

create table student ( \
   snum      integer not null, \
   firstname varchar(30) not null, \
   year      integer not null,  \
   primary key (snum))

insert into student values (1, 'Mary', 3)
insert into student values (2, 'Fred', 2)
insert into student values (3, 'Bob', 1)
insert into student values (4, 'Alice', 4)

create table course ( \
   cnum      char(5) not null, \
   cname     varchar(50) not null, \
   primary key (cnum))

insert into course values ('CS348', 'Intro to Databases')
insert into course values ('CS234', 'Data Types and Structures')
insert into course values ('CS245', 'Logic and Computation')
insert into course values ('CO487', 'Applied Cryptography')

create table class ( \
   cnum      char(5) not null, \
   term      char(5) not null, \
   section   integer not null, \
   pnum      integer not null, \
   primary key (cnum,term,section), \
   foreign key (cnum) references course(cnum), \
   foreign key (pnum) references professor(pnum))

insert into class values ('CS348', 'F2018', 1, 1)
insert into class values ('CS348', 'F2018', 2, 1)
insert into class values ('CS234', 'F2018', 1, 1)
insert into class values ('CS348', 'S2020', 1, 1)
insert into class values ('CS348', 'S2020', 2, 1)
insert into class values ('CS234', 'W2020', 1, 2)
insert into class values ('CS234', 'W2020', 2, 2)
insert into class values ('CS245', 'F2019', 1, 2)
insert into class values ('CS245', 'F2019', 2, 2)
insert into class values ('CO487', 'F2019', 1, 3)
-- insert into class values ('CO487', 'F2019', 2, 2)

create table officehour ( \
   cnum      char(5) not null, \
   term      char(5) not null, \
   pnum      integer not null, \
   day       varchar(10) not null, \
   time      char(5) not null, \
   primary key (cnum,term,pnum,day,time), \
   foreign key (cnum) references course(cnum), \
   foreign key (pnum) references professor(pnum))

insert into officehour values ('CS348', 'S2020', 1, 'Tuesday', '09:00')
insert into officehour values ('CS348', 'S2020', 1, 'Thursday', '14:30')
insert into officehour values ('CS245', 'F2019', 2, 'Monday', '11:59')
insert into officehour values ('CS245', 'F2019', 2, 'Friday', '17:00')

create table enrollment ( \
   snum      integer not null, \
   cnum      char(6) not null, \
   term      char(5) not null, \
   section   integer not null, \
   grade     integer, \
   primary key (snum,cnum,term,section), \
   foreign key (snum) references student(snum), \
   foreign key (cnum,term,section) references class(cnum,term,section))

insert into enrollment values (1, 'CS348', 'F2018', 1, 88)
insert into enrollment values (2, 'CS348', 'S2020', 1, null)
insert into enrollment values (1, 'CS245', 'F2019', 1, 95)
insert into enrollment values (1, 'CS234', 'W2020', 1, 91)
insert into enrollment values (2, 'CS245', 'F2019', 1, 69)
insert into enrollment values (3, 'CS245', 'F2019', 2, 98)
insert into enrollment values (4, 'CS245', 'F2019', 2, 81)
insert into enrollment values (4, 'CO487', 'F2019', 1, 85)
insert into enrollment values (3, 'CO487', 'F2019', 1, 90)
