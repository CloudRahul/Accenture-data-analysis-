-- creating the tables and columns in postgresql --
-- didn't include url coulmn beacuase it serves no purpose in this data analysis--
-- also removing the user_id it may seem important but for this data analysis questions it is not needed so we will remove it from content and reaction--

alter table content 
drop column user_id 

alter table reaction
drop column user_id 


select *
from content;

select * 
from reaction;

select *
from reaction_type;

-- adding froegin keys to connect the data --
alter table reaction
add constraint fk_content_reaction
foreign key (content_id)
REFERENCES content (content_id);

alter table reaction
add constraint fk_reactiontype_reaction
foreign key (type)
REFERENCES reaction_type (type);

-- data cleaning--
-- content table--
-- removing the url column as it serves no purpose in this data analysis --
ALTER TABLE content
  DROP COLUMN url;
  
select *
from content;

-- content removing null values from the table as they will be not useful to us --
select *
from content 
where category is null;

-- there are no null values in content after removing url which contend some null values --
-- reaction removing null values --
select *
from reaction
where datetime is null;

DELETE FROM reaction
WHERE user_id IS NULL;

-- data will be easy to understand now that the null values has been removed --

-- there are no null values in reaction_type column --
select *
from reaction_type
where type is null;

-- duplicate values and similar names in content category like "animal" = Animals combining the two --
select category , count(category) as c1
from (select category 
from content
where category like '"%"' ) a1
where category like '%'
group by 1

SELECT category, COUNT(*) as count
FROM content
GROUP BY category
order by 2


SELECT LOWER(category) as lower_case_column, COUNT(*) as count
FROM content
GROUP BY lower_case_column
HAVING COUNT(*) > 1;
-- for animals they are similar --
UPDATE content
SET category = '"animals"'
WHERE category = 'Animals';

UPDATE content
SET category = '"animals"'
WHERE category = 'animals';

-- for cooking 
UPDATE content
SET category = '"cooking"'
WHERE category = 'cooking';

-- for soccer
UPDATE content
SET category = '"soccer"'
WHERE category = 'Soccer';

UPDATE content
SET category = '"soccer"'
WHERE category = 'soccer';

-- combining culture 
UPDATE content
SET category = '"culture"'
WHERE category = 'Culture';

UPDATE content
SET category = '"culture"'
WHERE category = 'culture';

-- combining dogs
UPDATE content
SET category = '"dogs"'
WHERE category = 'dogs';

-- combining foods 
UPDATE content
SET category = '"food"'
WHERE category = 'Food';

UPDATE content
SET category = '"food"'
WHERE category = 'food';

-- combining public speaking
UPDATE content
SET category = '"public speaking"'
WHERE category = 'Public Speaking';

UPDATE content
SET category = '"public speaking"'
WHERE category = 'public speaking';

-- combining science
UPDATE content
SET category = '"science"'
WHERE category = 'Science';

UPDATE content
SET category = '"science"'
WHERE category = 'science';

-- studying --
UPDATE content
SET category = '"studying"'
WHERE category = 'Studying';

UPDATE content
SET category = '"studying"'
WHERE category = 'studying';

-- combining technology
UPDATE content
SET category = '"technology"'
WHERE category = 'Technology';

UPDATE content
SET category = '"technology"'
WHERE category = 'technology';

-- combining tennis
UPDATE content
SET category = '"tennis"'
WHERE category = 'tennis';

-- combining veganism
UPDATE content
SET category = '"veganism"'
WHERE category = 'Veganism';

UPDATE content
SET category = '"veganism"'
WHERE category = 'veganism';

-- combining education
UPDATE content
SET category = 'education'
WHERE category = 'Education';

-- combining healthy eating
UPDATE content
SET category = 'healthy eating'
WHERE category = 'Healthy Eating';

-- combining fitness 
UPDATE content
SET category = 'fitness'
WHERE category = 'Fitness';

-- combining travel
UPDATE content
SET category = 'travel'
WHERE category = 'Travel';

-- normalizing names
select upper(category),count(category)
from content
group by 1

UPDATE content
SET category = CASE
    WHEN category = '"technology"' THEN 'technology'
	when category = '"animals"' then 'animals'
	WHEN category = '"science"' THEN 'science'
	when category = '"culture"' then 'culture'
	WHEN category = '"soccer"' THEN 'soccer'
	when category = '"food"' then 'food'
	WHEN category = '"cooking"' THEN 'cooking'
	when category = '"tennis"' then 'tennis'
	when category = '"studying"' then 'studying'
	WHEN category = '"dogs"' THEN 'dogs'
	when category = '"veganism"' then 'veganism'
	when category = '"public speaking"' then 'public speaking'
    ELSE category
    END;


select category , count (*) from content
group by 1
order by 2 desc

select type , count(type)
from content
group by


-- score for all the category 
select c.category all_category , count (*) reaction_count ,sum(rt.score) score
from content c
join reaction r
on c.content_id = r.content_id
join reaction_type rt 
on rt.type = r.type
group by 1
order by 3 desc


select *
from reaction
-- top 5 category of content that people like on social buzz based on only count of catgeory not including reaction and type
-- top 5 are Animals , science, healthy eating , Technology , and food 
select c.category , count (*) category_count ,sum(rt.score) score
from content c
join reaction r
on c.content_id = r.content_id
join reaction_type rt 
on rt.type = r.type
group by 1
order by 3 desc
limit 5

h
select r.datetime,count(c.content_id) ,date_part('year' ,'2020', r.datetime) as date
from content c
join reaction r
on c.content_id = r.content_id
group by 1





-- top 5 category of content that people like on social buzz based on content id with most amount of reactions 
-- top 5 are technology , culture, food , healthy eating , and culture 
select c.content_id , c.category ,c.type content_form,r.type content_reaction, rt.sentiment, sum(rt.score) total_score
from content c
join reaction r
on c.content_id = r.content_id 
join reaction_type rt
on rt.type = r.type
group by 1,2,3,4,5
order by 6 desc
limit 5



/*top 5 category of content that people like on social buzz based on the content form meaning in which form of content
get most reaction photo gif or video audio according to this photo gets most amount of reaction by people*/ 
-- top 5 are Animals , technology, animals , education , and dogs 

select c.type , count (c.type) reaction_count ,sum(rt.score) score
from content c
join reaction r
on c.content_id = r.content_id
join reaction_type rt 
on rt.type = r.type
group by 1
order by 3 desc



/*top 5 category of content that people like on social buzz based on the most amount of reaction recived by a category */ 
-- top 5 are technology , animals, animals , science , and culture
select r.type ,c.category, count (r.type) reaction_count ,sum(rt.score) score
from content c
join reaction r
on c.content_id = r.content_id
join reaction_type rt 
on rt.type = r.type
group by 1,2
order by 4 desc
limit 5


