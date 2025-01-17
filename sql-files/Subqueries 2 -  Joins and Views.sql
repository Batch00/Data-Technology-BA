/* Subqueries in JOINs */
/* Say you want to get the businesses that have star ratings higher than 
the average star rating across all businesses in the state */

SELECT state, AVG(stars) as avg_stars 
FROM business
GROUP BY 
state;


SELECT  -- count(*) 
name, state, stars 
FROM 
business 
;
 -- 150346

SELECT   -- count(*) 
 name, state, stars, avg_stars as state_avg 
FROM 
   business b
   INNER JOIN
   ( SELECT state, AVG(stars) as avg_stars 
     FROM business
	 GROUP BY 
	 state ) av
    USING (state) 
    WHERE stars > avg_stars;
    -- 150346 without the WHERE clause
    -- 78220 with the WHERE clause
    
## ******************* Views ***********************##

/*Subqueries can be substituted with Views, Note that the SQL 
for creating the view is what we used a subquery in the previous step*/

CREATE OR REPLACE VIEW avg_rating_by_state AS
SELECT state, AVG(stars) as avg_stars 
     FROM business
	 GROUP BY 
	 state;
# Refresh and verify in the left panel that the new view 'avg_rating_by_state' has been created
# Now you can use the view you created in the subquery to get the same result

SELECT name, state, stars, avg_stars as state_avg 
FROM 
   business b
   INNER JOIN
   /*( SELECT state, AVG(stars) as avg_stars 
     FROM business
	 GROUP BY 
	 state ) */   -- Replacing this with the view 
	avg_rating_by_state av 
    USING (state) 
    WHERE stars > avg_stars;
   
   # Exercise 8.3          
/*List out all the businesses in the cities in PA and FL that have the highest ratings in their city.
If there are multiple businesses with equal ratings, which are the highest in the city, list all of them. 
The output should show, the business name, city and the star rating*/

# write your code here


CREATE OR REPLACE VIEW max_rated AS
SELECT city, MAX(stars) as max_rating
FROM business
GROUP BY city;


SELECT b.name as business_name, city, stars
FROM business b
INNER JOIN
max_rated m
USING(city)
WHERE state in ('PA', 'FL')
AND b.stars = m.max_rating;

# Exercise 8.4
/* Repeat the previous exercise, but only include 'Restaurant' businesses */
# write your code here

CREATE OR REPLACE VIEW max_rated_restaurants AS
SELECT city, MAX(stars) as max_rating
FROM business
INNER JOIN
Category
USING(business_id)
WHERE category_name = 'Restaurants'
GROUP BY city;


SELECT b.name as business_name, city, stars
FROM business b
INNER JOIN
max_rated_restaurants m
USING(city)
INNER JOIN category
USING(business_id)
WHERE category_name = 'Restaurants'
AND state in ('PA', 'FL')
AND b.stars = m.max_rating ORDER BY city;


# Doing the same thing using RANK() which is a Window function:
SELECT * FROM (          
               SELECT b.name as business_name, city, stars, 
			   RANK() OVER(PARTITION BY city ORDER BY stars DESC) as rating_rank
			   FROM 
                 business b
			   INNER JOIN
				 category c
               USING(business_id) 
			   WHERE
               category_name = 'Restaurants'
               AND state IN ('FL', 'PA')
			   ) X
WHERE rating_rank = 1























