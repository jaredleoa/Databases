--1
select title
from book b
left join recommends r on b.isbn = r.isbn
where r.isbn is null;

--2
select title
from book b
left join recommends r on b.isbn = r.isbn
join module m on r.mod_code = m.mod_code
GROUP BY b.title
HAVING COUNT(r.mod_code) > 1;

--3
select title
from book b
left join recommends r on b.isbn = r.isbn
join module m on r.mod_code = m.mod_code
GROUP BY b.title
having count(r.mod_code) = (select count(*) from module); 

--4
select author_name
from author a
left join authors a2 on a.author_id = a2.author_id 
join book b on a2.isbn = b.isbn
join recommends r on b.isbn = r.isbn
join module m on r.mod_code = m.mod_code
group by a.author_name
having count(r.mod_code) > 1; 

--5
SELECT mod_name
FROM module m
LEFT JOIN recommends r ON m.mod_code = r.mod_code
LEFT JOIN book b ON r.isbn = b.isbn
WHERE b.title = 'SQL Cookbook'
except
SELECT mod_name
FROM module m
LEFT JOIN recommends r ON m.mod_code = r.mod_code
LEFT JOIN book b ON r.isbn = b.isbn
WHERE b.title != 'SQL Cookbook';

--6
select author_name
from author a 
left join authors a2 on a.author_id = a2.author_id 
join book b on a2.isbn = b.isbn
join recommends r on b.isbn = r.isbn
join module m on r.mod_code = m.mod_code
where m.mod_name = 'Databases 1'
union
select author_name
from author a
left join authors a2 on a.author_id = a2.author_id 
join book b on a2.isbn = b.isbn
join recommends r on b.isbn = r.isbn
join module m on r.mod_code = m.mod_code
where m.mod_name = 'Machine Learning'
except
select author_name
from author a 
left join authors a2 on a.author_id = a2.author_id 
join book b on a2.isbn = b.isbn
join recommends r on b.isbn = r.isbn
join module m on r.mod_code = m.mod_code
where m.mod_name = 'Databases 1'
intersect
select author_name
from author a
left join authors a2 on a.author_id = a2.author_id 
join book b on a2.isbn = b.isbn
join recommends r on b.isbn = r.isbn
join module m on r.mod_code = m.mod_code
where m.mod_name = 'Machine Learning';

--7
select mod_name, count(r.isbn) as num_recs 
from module m
left join recommends r on m.mod_code = r.mod_code 
join book b on r.isbn = b.isbn
group by m.mod_name
order by count(r.isbn) DESC
limit 1;

--8
select title,
yearofpublication, rank() over (partition by author_name order by yearofpublication),
author_name
from book b 
join authors a2 on b.isbn = a2.isbn 
join author a on a2.author_id = a.author_id; 