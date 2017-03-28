--1.1
select distinct title from movies
natural join showtimes
natural join tickets
where max_occupancy <= (select count(*) from tickets);

--1.2 
select name, count(showid)
 from theaters natural join showtimes 
 group by name
having count(showid) >= 3; 

--1.3 
 select name, theaterid
 from theaters natural join showtimes
 group by name, theaterid
 having count(distinct movieid) = (select count(*) from movies);

--1.4 
select email,age,title
from tickets natural join
(select userid
from tickets
group by userid
having count(showid) = 1) natural join
showtimes natural join
movies natural join
users;

--1.5 
select distinct title from movies
natural join showtimes
natural join movies
natural join
(select showid from
tickets natural join showtimes
natural join movies
natural join users
group by showid
having count(*) = 1);

--1.6 
select name from theaters
natural join
showtimes natural join
(select showid, sum(numberbookedsofar) as noOfBookings
from tickets natural join users
natural join showtimes
group by showid) where noOfBookings =
(select max(noOfBookings) from
theaters natural join
showtimes natural join
(select showid, sum(numberbookedsofar) as noOfBookings
from tickets natural join users
natural join showtimes
group by showid));

--1.7
Select userid,email,name from
(
select a.userid,a.theaterid,a.wentto
from
(select userid,theaterid,count(*) as wentto
from showtimes
natural join tickets
group by userid,theaterid) a
LEFT JOIN
(select userid, theaterid, count(*) as wentto
from showtimes
natural join tickets
group by userid,theaterid) b
ON (a.userid = b.userid) AND (a.wentto < b.wentto)
where b.userid IS NULL)
natural join users
natural join theaters;

--1.8
select movieid, AVG(avgusers)
from 
(select movieid,  count(userid) as avgusers,showtimes.showid from tickets
right outer join showtimes on tickets.showid = showtimes.showid
group by movieid,showtimes.showid)
group by movieid;

--1.9
select showid, (max_occupancy-seatsused) from tickets natural join showtimes
natural join 
(select count(userid) as seatsused, showid
from tickets natural join showtimes
group by showid);

--1.10
select userid, genre
from tickets natural join showtimes
natural join movies
where userid not in 
(select userid
from tickets natural join showtimes
natural join movies
group by userid
having count(*) > 1);


