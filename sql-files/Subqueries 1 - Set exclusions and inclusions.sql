/* Check the data to get the feel of the table structures and columns  */

SELECT * FROM business LIMIT 10;
SELECT * FROM user LIMIT 10;
SELECT * FROM review_notext LIMIT 10;
SELECT * FROM category LIMIT 10;

#get the business_id for category name of 'Bike Repair'
SELECT DISTINCT business_id
FROM 
category
WHERE category_name = 'Bike Repair';

# get the business_id for category name of 'Bicycles'
SELECT DISTINCT business_id
FROM 
category
WHERE category_name = 'Bicycles';

/* Now, how to get those business_id 's that are in Bicycle category, but also in Bike Repair category?
You can manually type all the business_ids and use an 'IN' statement in the WHERE clause */

# Set inclusion - businesses that are both 'Bicycles' and 'Bike Shops'
SELECT DISTINCT business_id
FROM 
category
WHERE category_name = 'Bicycles'
AND business_id IN ('aDMVQK3fGtD_FqmiZ5hdEg', 
					'-NAHnlhfIW_e1EOS59maxA',
                    'Cqhp3afalLZv7QJcoPY3Yg');
                    
# Set Exclusion - businesses that are 'Bicycles' but not 'Bike Shops'

SELECT DISTINCT business_id
FROM 
category
WHERE category_name = 'Bicycles'
AND business_id NOT IN ('aDMVQK3fGtD_FqmiZ5hdEg', 
					'-NAHnlhfIW_e1EOS59maxA',
                    'Cqhp3afalLZv7QJcoPY3Yg');

                    
/*The same results can be obtained by using subquery to get the business_id 's which are 'Bike Shop' category
Change between IN and NOT IN in the query below and see the results */


SELECT DISTINCT business_id
FROM 
category
WHERE category_name = 'Bicycles'
AND business_id NOT IN (SELECT DISTINCT business_id
					FROM 
					  category
                    WHERE 
                    category_name = 'Bike Repair'
                    );
                    
/*You can use LIKE to find category_names that contain "Bicycle' or 'Bike Repair'
pattern search with LIKE */
SELECT DISTINCT business_id 
FROM 
category 
WHERE category_name LIKE '%Bicycles%'
AND business_id NOT IN (SELECT DISTINCT business_id
					FROM 
					  category
                    WHERE 
                    category_name LIKE '%Bike Repair%'
                    );

#Use JOIN with business table to get business name:

SELECT DISTINCT b.business_id, b.name as business_name 
FROM 
category c
INNER JOIN 
business b
USING(business_id)
WHERE category_name LIKE '%Bicycles%'
AND business_id NOT IN (SELECT DISTINCT business_id
					FROM 
					  category
                    WHERE 
                    category_name LIKE '%Bike Repair%'
                    );


                    
/* Exercise 8.1: Write a query to get all businesses that have “Doctor” in their business names, 
but do not have “Health” in their category names. The query should return the 
business Id and business name */
#Enter your code here:

SELECT DISTINCT b.business_id, b.name as business_name
FROM 
category c
INNER JOIN 
business b
USING(business_id)
WHERE b.name LIKE '%Doctor%'
  AND c.category_name NOT LIKE '%Health%';

SELECT DISTINCT b.business_id, b.name as business_name
FROM category c
INNER JOIN business b
USING(business_id)
WHERE b.name LIKE '%Doctor%' AND
	business_id NOT IN (SELECT DISTINCT business_id
	FROM category WHERE category_name LIKE '%Health%');


# Subqueries with aggregates
/* What if you want to get the businesses that have star ratings that are 
equal to the minimum star ratings across the nation 
*/

SELECT AVG(stars) as avg_ratings FROM business ;

SELECT 
name as business_name, 
stars  
FROM business 
WHERE 
stars >= (SELECT AVG(stars) 
          FROM 
          business);

/* Exercise 8.2: Write a query to get all users who had posted more review counts than the average review counts across all users. 
The query should return the names of the users and the count of their reviews*/

#Enter your code here:
 
SELECT name , review_count
FROM user
WHERE review_count >= (SELECT AVG(review_count)
FROM user);




                    
                    
	


