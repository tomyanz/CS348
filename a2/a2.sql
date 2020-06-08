-- Q1
select distinct snum, firstname from student \
where year >= 2 and exists ( \
  select * from enrollment e1, enrollment e2 \
  where \
    student.snum = e1.snum and \
    student.snum = e2.snum and \
    (e1.cnum != e2.cnum or \
      e1.term != e2.term or \
      e1.section != e2.section) and \
    substr(e1.cnum, 3, 1) = year-1 and \
    substr(e2.cnum, 3, 1) = year-1 and \
    e1.grade > 90 and \
    e2.grade > 90 )

-- Q2
select distinct pnum, lastname from professor \
where not exists ( \
  select * from class \
  where \
    (cnum = 'CS348' or \
    cnum = 'CS234') and \
    class.pnum = professor.pnum and \
    term != 'S2020')

-- Q3
select distinct pnum, lastname from professor \
where exists ( \
  select * from class c, enrollment e \
  where \
    c.pnum = professor.pnum and \
    c.cnum = 'CS245' and \
    e.cnum = 'CS245' and \
    c.term = e.term and \
    c.section = e.section and \
    grade >= all ( \
      select grade from enrollment e2 where e2.cnum = 'CS245' ) )

-- Q4
select distinct e1.grade as mingrade, e2.grade as maxgrade, \
  lastname, c.cnum \
  from enrollment e1, enrollment e2, professor p, class c \
where dept = 'CS' and exists ( \
  select * from officehour o \
  where \
    o.pnum = p.pnum and \
    p.pnum = c.pnum and \
    o.cnum = c.cnum and \
    o.day = 'Monday' and \
    substr(o.time, 1, 2) < 12 ) and exists ( \
  select * from officehour o \
  where \
    o.pnum = p.pnum and \
    o.cnum = c.cnum and \
    o.day = 'Friday' and \
    substr(o.time, 1, 2) >= 12 ) and \
  e1.cnum = c.cnum and \
  e2.cnum = c.cnum and \
  e1.grade <= all ( \
    select grade from enrollment e3 where e3.cnum = e1.cnum) and \
  e2.grade >= all ( \
    select grade from enrollment e3 where e3.cnum = e2.cnum)

-- Q5
select c.cnum, c.term, count(e.snum) as scnt from class c, enrollment e \
where c.cnum = e.cnum and \
  c.term = e.term and \
  c.section = e.section and not exists ( \
    select * from professor, class c2 \
    where \
      c.cnum = c2.cnum and \
      (dept = 'CS' or dept = 'AM') and \
      c2.pnum = professor.pnum ) \
group by c.term, c.cnum

-- Q6
select count(p1.pnum) * 100 / (select count(*) from professor) as pct from professor p1 \
where not exists ( \
  select c1.cnum, c2.cnum from class c1, class c2 \
  where \
    c1.pnum = p1.pnum and \
    c2.pnum = p1.pnum and \
    c1.cnum != c2.cnum and \
    c1.term = c2.term and \
    c1.term != 'S2020' )
