USE yelp;

-- Q1
SELECT DISTINCT category_name 
FROM yelp.category 
ORDER BY category_name ASC;

-- Q2
SELECT state, COUNT(*) as business_count
FROM yelp.business
GROUP BY state
ORDER BY business_count DESC
LIMIT 3;

-- TOP 3 States: PA, FL, TN

-- Q3
SELECT COUNT(*) as total_restaurants
FROM yelp.business as b
JOIN yelp.category as c ON b.business_id = c.business_id
WHERE c.category_name = 'Restaurants';

-- Total Restaurants = 52,268

-- Q4
SELECT SUM(b.review_count) as total_restaurants_reviews
FROM yelp.business as b
JOIN yelp.category as c ON b.business_id = c.business_id
WHERE c.category_name = 'Restaurants';

-- Total Restaurants Reviews = 4,561,279

-- Q5
select * from yelp.business;

CREATE OR REPLACE VIEW top_users AS
Select distinct(u.user_id), u.name, u.review_count
FROM yelp.user as u
JOIN yelp.review_notext as r on u.user_id = r.user_id
JOIN yelp.category as c ON r.business_id = c.business_id
WHERE c.category_name = 'Restaurants';

Select * from top_users
order by review_count desc
LIMIT 3;


-- Q6
select DISTINCT b.business_id, b.name as business_name
FROM category c
INNER JOIN business b
USING(business_id)
WHERE state='PA'
AND b.name LIKE '%Coffee%'
AND
business_id NOT IN(
	SELECT DISTINCT business_id
    from category
    where
    category_name LIKE
    '%Coffee%'
    )
    order by business_id asc;

-- Q7
-- Step 1: Create the review_count view to store business ID, number of reviews, and state for bars
CREATE Or replace VIEW review_count AS
SELECT b.state, b.business_id, b.name, b.review_count
FROM business AS b
JOIN category AS c ON b.business_id = c.business_id
WHERE c.category_name = 'Bars';

-- Step 2: Create the max_review_count view to store the maximum number of reviews for bars in each state
CREATE or replace VIEW max_review_count AS
SELECT state, MAX(review_count) AS max_reviews
FROM review_count
GROUP BY state;

-- Step 3: Join the views to get the most popular bars in each state
SELECT rc.state, rc.business_id, rc.name, rc.review_count
FROM review_count AS rc
JOIN max_review_count AS mrc ON rc.state = mrc.state AND rc.review_count = mrc.max_reviews
ORDER BY rc.state ASC;