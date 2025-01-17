-- Keep open: https://docs.snowflake.com/en/sql-reference-commands.html
-- first create the database
CREATE DATABASE IF NOT EXISTS yelp;

-- then set our context
USE ROLE accountadmin;
USE WAREHOUSE compute_wh;
USE DATABASE yelp;
USE SCHEMA public;

CREATE OR REPLACE STORAGE INTEGRATION snowflake_gb760
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::061051252144:role/snowflake_gb760'
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('s3://gb760/');

desc integration snowflake_gb760;
-- Snowflake Stages are locations where data files are stored (“staged”) which helps in loading data into and unloading data out of database tables. 
-- The stage locations could be internal or external to Snowflake environment
-- now create a new stage to load the yelp data
CREATE OR REPLACE STAGE stage_yelp_s3
storage_integration = snowflake_gb760
url = 's3://gb760/';

-- test if we can access the stage
list @stage_yelp_s3;

-- aws s3 cp s3://genbus760/yelp/yelp_academic_dataset_review_withtext.csv.gz ./Documents --no-sign-request

-- create a new file format for the yelp data
CREATE OR REPLACE FILE FORMAT format_yelp_csv
TYPE='CSV'
COMPRESSION='GZIP'
SKIP_HEADER=1
FIELD_DELIMITER=','
RECORD_DELIMITER='\n'
ESCAPE='\\'
FIELD_OPTIONALLY_ENCLOSED_BY='"'
EMPTY_FIELD_AS_NULL=TRUE;



-- now create tables to store the yelp data
-- Data type documentation: https://docs.snowflake.com/en/sql-reference/data-types.html

CREATE OR REPLACE TABLE business
(
bid int,
business_id varchar primary key,
name varchar,
address varchar,
city varchar,
state varchar,
postal_code varchar,
latitude decimal,
longitude decimal,
stars decimal,
review_count int,
is_open int
);

CREATE OR REPLACE TABLE user
(
uid int,
user_id varchar primary key,
name varchar,
review_count int,
yelping_since timestamp,
average_stars decimal,
useful_votes int,
funny_votes int,
cool_votes int,
fans int,
compliment_hot int,
compliment_more int,
compliment_profile int,
compliment_cute int,
compliment_list int,
compliment_note int,
compliment_plain int,
compliment_cool int,
compliment_funny int,
compliment_writer int,
compliment_photos int
);

CREATE OR REPLACE TABLE category
(
cid int primary key,
business_id varchar,
category_name varchar
);

CREATE OR REPLACE TABLE review
(
rid int,
review_id varchar primary key,
business_id varchar,
user_id varchar,
stars int,
date timestamp,
useful_votes int,
funny_votes int,
cool_votes int
);

-- now copy data into the newly created tables
COPY INTO business
FROM @stage_yelp_s3/yelp_academic_dataset_business.csv.gz
FILE_FORMAT = format_yelp_csv;
COPY INTO user
FROM @stage_yelp_s3/yelp_academic_dataset_user.csv.gz
FILE_FORMAT = format_yelp_csv;
COPY INTO category
FROM @stage_yelp_s3/yelp_academic_dataset_category.csv.gz
FILE_FORMAT = format_yelp_csv;
COPY INTO review
FROM @stage_yelp_s3/yelp_academic_dataset_review_notext.csv.gz
FILE_FORMAT = format_yelp_csv;

-- skim the data you just loaded
DESCRIBE TABLE business;
DESCRIBE TABLE user;
DESCRIBE TABLE category;
DESCRIBE TABLE review;

SELECT * FROM business LIMIT 10;
SELECT * FROM user LIMIT 10;
SELECT * FROM category LIMIT 10;
SELECT * FROM review LIMIT 10;

