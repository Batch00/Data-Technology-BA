DROP DATABASE IF EXISTS streaming;

CREATE DATABASE streaming;

USE streaming;


CREATE TABLE User
(
  User_ID INT NOT NULL,
  First_Name VARCHAR(255) NOT NULL,
  Last_Name VARCHAR(255) NOT NULL,
  Class_Year INT NOT NULL,
  Gender VARCHAR(255) NOT NULL,
  PRIMARY KEY (User_ID)
);

LOAD DATA LOCAL INFILE '/Users/jlin247/Downloads/Slides_W5/User.csv'
INTO TABLE streaming.User
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(User_ID, First_Name, Last_Name, Class_Year, Gender);

-- DROP TABLE streaming.User;

SELECT * from streaming.User;

UPDATE streaming.User 
SET Class_Year = "2017" 
WHERE Class_Year = "2016";

UPDATE streaming.User
SET Last_Name = "Jones"
WHERE Last_Name = "Alden";


CREATE TABLE Item
(
  Item_ID INT NOT NULL,
  Item_Name VARCHAR(255) NOT NULL,
  Category VARCHAR(255) NOT NULL,
  Total_Duration INT NOT NULL,
  Genre VARCHAR(255) NOT NULL,
  PRIMARY KEY (Item_ID)
);

CREATE TABLE Watch
(
  Item_ID INT NOT NULL,
  User_ID INT NOT NULL,
  Stream_Time INT NOT NULL,
  PRIMARY KEY (User_ID, Item_ID),
  FOREIGN KEY (User_ID) REFERENCES User(User_ID),
  FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID)
);

LOAD DATA LOCAL INFILE '/Users/jlin247/Downloads/Slides_W5/Item.csv'
INTO TABLE streaming.Item
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Item_ID, Item_Name, Category, Total_Duration, Genre);

LOAD DATA LOCAL INFILE '/Users/jlin247/Downloads/Slides_W5/Watch.csv'
INTO TABLE streaming.Watch
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Item_ID, User_ID, Stream_Time);

DELETE FROM streaming.Watch
WHERE Item_ID = "6";

-- Some other userful exericises

SELECT * FROM streaming.Item;

-- select item_name and total duration from table item
SELECT Item_Name, Total_Duration FROM streaming.Item;

-- select item_name and total duration from table item with total duration greater than 300
SELECT Item_Name, Total_Duration FROM streaming.Item WHERE Total_Duration > 300;

-- select item_name and total duration from table item with total duration not equal to 600

SELECT Item_Name, Total_Duration FROM streaming.Item WHERE Total_Duration != 600;

-- select item_name and total duration from table item with total duration less or equal to 600

SELECT Item_Name, Total_Duration FROM streaming.Item WHERE Total_Duration <=600;

-- select item_name and total duration from table item with total duration greater than 300 and genre equals to comedy
SELECT Item_Name, Total_Duration FROM streaming.Item WHERE Total_Duration > 300 AND Genre = 'Comedy';

-- select item_name and total duration from table item with category equals to movie and total duration between 100 and 200
SELECT Item_Name, Total_Duration FROM streaming.Item WHERE Category = 'Movie' AND Total_Duration BETWEEN 100 AND 200;

-- select item_name and total duration from table item with genre equals to comedy or horror drama
SELECT Item_Name, Total_Duration, Genre FROM streaming.Item WHERE Genre = 'Comedy' OR Genre = 'Horror Drama';

-- find out how many distinct year of class in the table user
SELECT Distinct Class_Year FROM streaming.User;
-- DISTINCT modifier with a SELECT statement to return only one row for each unique combination of columns selected

-- select all columns from table user and order by first name in ascending way
SELECT * FROM streaming.User ORDER BY First_Name;

SELECT * FROM streaming.User ORDER BY First_Name, Last_Name;
SELECT * FROM streaming.User ORDER BY Last_Name ASC, First_Name DESC;

SELECT Item_Name, Total_Duration FROM streaming.Item ORDER BY Total_Duration DESC;
SELECT Item_Name, Total_Duration FROM streaming.Item ORDER BY Total_Duration DESC LIMIT 5;
-- This function limits the # of rows that a SELECT query returns.

-- count how many distinct genres from table item in the set of ('Horror Drama','Comedy','Animated')
SELECT distinct Genre FROM streaming.Item WHERE Genre IN ('Horror Drama','Comedy','Animated');

-- select first name and last name from user table where first name begins with 'A'

SELECT First_Name, Last_Name FROM streaming.User WHERE First_Name like 'A%';

-- 'A%' The string must start with the letter "A" and follows by zero or more.
-- 'A_', The LIKE operator is case-insensitive in MySQL
-- '%' a substitute for zero or more characters. '_' a substitute for exactly one character.
-- For case sensitive case, can do WHERE LOWER(name) LIKE 'a%';

-- select users whose first name begins with 'al'
SELECT First_Name, Last_Name FROM streaming.User WHERE First_Name like 'Al%';

-- -- select users whose first name begins with 'A' and the first letter is 'i', such as Alice, Alicia, Alisha, ...

SELECT First_Name, Last_Name FROM streaming.User WHERE First_Name like 'A_i%';


-- calculate the max, min and average of watch minutes from table watch

SELECT AVG(Stream_Time), MAX(Stream_Time), MIN(Stream_Time) FROM streaming.Watch;

-- calculate the sum of stream time for item_id equals to 6

SELECT SUM(Stream_Time) FROM streaming.Watch WHERE Item_ID = 4;

-- find out how many unique users have watched the item_id 2 or 3.

SELECT COUNT(DISTINCT User_ID) FROM streaming.Watch WHERE Item_ID = 2 OR Item_ID = 3;

-- what are item 's average steam time over users? and which item has the higest?

SELECT Item_ID, AVG(Stream_Time) FROM streaming.Watch GROUP BY Item_ID ORDER BY AVG(Stream_Time) Desc;

SELECT Item_ID, AVG(Stream_Time) FROM streaming.Watch GROUP BY Item_ID ORDER BY AVG(Stream_Time) Desc Limit 1;

-- find out the item_id which has an average stream time over users for at least 100 minutes

SELECT Item_ID, AVG(Stream_Time) FROM streaming.Watch GROUP BY Item_ID Having AVG(Stream_Time) >= 100;

-- find out the item_id (and the item_id is smaller or equal to 4) which has an average stream time over users for at least 90 minutes and order by avg stream time descending

SELECT Item_ID, AVG(Stream_Time) FROM streaming.Watch WHERE Item_ID <= 4 GROUP BY Item_ID Having AVG(Stream_Time) >= 90 ORDER BY AVG(Stream_Time) DESC;
