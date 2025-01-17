/*
The SQL code below illustrate how to:
1. Create a database, 
2. Create tables for the database. You can generate the SQL code from a Retional Schema created by ERDPlus.com 
3. Load data, in csv format, into the tables
*/

-- Create a database named streaming. We will store the Tuber data in this databse
DROP DATABASE IF EXISTS streaming;

CREATE DATABASE streaming;

-- Make streaming the active database so we can work with it
USE streaming;


/*
The three blocks of SQL below create three tables: User, Item, and Watch
The SQL can be generated from a Relational Schema you created using ERDplus.com
*/

-- Create a new table named User
CREATE TABLE User
(
  User_ID INT NOT NULL,
  First_Name VARCHAR(255) NOT NULL,
  Last_Name VARCHAR(255) NOT NULL,
  Class_Year INT NOT NULL,
  Gender VARCHAR(255) NOT NULL,
  PRIMARY KEY (User_ID)
);

-- Create a new table named Item
CREATE TABLE Item
(
  Item_ID INT NOT NULL,
  Item_Name VARCHAR(255) NOT NULL,
  Category VARCHAR(255) NOT NULL,
  Total_Duration INT NOT NULL,
  Genre VARCHAR(255) NOT NULL,
  PRIMARY KEY (Item_ID)
);

-- Create a new table named Watch
CREATE TABLE Watch
(
  Item_ID INT NOT NULL,
  User_ID INT NOT NULL,
  Stream_Time INT NOT NULL,
  PRIMARY KEY (User_ID, Item_ID),
  FOREIGN KEY (User_ID) REFERENCES User(User_ID),
  FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID)
);



/*
The three blocks of SQL below loads data into the three tables: User, Item, and Watch
You are likely to encounter various issues. No worries. Prof. Li will help you in class and after class
*/

SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

-- Load data into the Item table
-- Remember to change the file path to yours. Mine is: /Users/zli2546/Documents/Tuber/Item.csv 
LOAD DATA LOCAL INFILE 'C:/Users/carso/OneDrive - UW-Madison/MSBA Business Analytics/Fall Semester/GenBus760_DataTech/data/Item.csv'
INTO TABLE streaming.Item
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Item_ID, Item_Name, Category, Total_Duration, Genre);

-- Having trouble loading data into database? Follow the steps below:
-- Step 1: Run the code below:
SET GLOBAL local_infile = 1;   -- This will turn on the option of loading data from a csv file on your machine
SHOW GLOBAL VARIABLES LIKE 'local_infile';  -- We need the value to be ON. 
-- Step 2: Go to the Workbench ribbon "Database" --> "Manage Connections". Edit the connection, on the Connection tab, go to the 'Advanced' sub-tab, and in the 'Others:' box add the line 'OPT_LOCAL_INFILE=1'
-- Step 3: Quit and restart your Workbench. Run the SQL above (LOAD DATA LOCAL...) to loan data again

-- Load data into the User table
LOAD DATA LOCAL INFILE 'C:/Users/carso/OneDrive - UW-Madison/MSBA Business Analytics/Fall Semester/GenBus760_DataTech/data/User.csv'
INTO TABLE streaming.User
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(User_ID, First_Name, Last_Name, Class_Year, Gender);

-- Loan data into the Watch table
LOAD DATA LOCAL INFILE 'C:/Users/carso/OneDrive - UW-Madison/MSBA Business Analytics/Fall Semester/GenBus760_DataTech/data/Watch.csv'
INTO TABLE streaming.Watch
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Item_ID, User_ID, Stream_Time);