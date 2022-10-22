--CHALLENGE 1: JOINING TV TITLES WITH REVIEWER RATINGS (INNER JOIN)

# Our first challenge in this section is to perform a join between each of our TV Series, and their corresponding Ratings
# left by reviewers. The result of this query will show us every review produced for each individual series. 

SELECT 
    title, 
    rating 
FROM series
JOIN reviews
    ON series.id = reviews.series_id;

# Notice that we are joining the reviews table to the series table based on the syntax: tablename.columnname = tablename.columnname
# Through this syntax we can identifying where in the reviews table we have corresponding foreign key matches to the series table!


--CHALENGE 2: AVERAGE RATING (INNER JOIN)

# In this excercise, we are going to refine our previous challenge. We will utilize the AVG() function in order to see the
# average review of each series in our TV series table. 

SELECT
    title,
    AVG(rating) as avg_rating
FROM series
JOIN reviews
    ON series.id = reviews.series_id
GROUP BY series.id
ORDER BY avg_rating;

# To accomplish this, it is necessary to GROUP BY not just the title, but the series.id Primary Key in order to produce unique
# results. This ensures that even if hypothetically two Series' were to share the same name, they would not be grouped 
# together and give us faulty rating averages.


--CHALLENGE 3: MATCHING REVIEWER NAMES TO THEIR REWIEWS. (INNER JOIN)

# For this challenge, the goal is to produce a results table that matches the first and last name of the users in our Reviwers
# table, to every rating that they have produced.

SELECT
    first_name,
    last_name,
    rating
FROM reviewers
INNER JOIN reviews
    ON reviewers.id = reviews.reviewer_id;


 --CHALLENGE 4: IDENTIFY ANY SHOWS THAT HAVE NOT BEEN REVIEWED. (LEFT JOIN)

 # In our data sets, we have included two shows which have never been reviewed. Our goal with this exercise is to produce a
 # results table identifying these shows.

 # We have three tables in our database: Reviewers, Series, and Reviews. Because this challenge is only about what series has
 # had NO reviews, we need only be concerned with the Series and Reviews tables. Our goal is to identify the non-overlapping 
 # items between the two. 

 # Because of this, we should not utilize an INNER JOIN and instead utilize a LEFT JOIN. The LEFT JOIN
 # is taking EVERYTHING from the left(series table), including those that have no reviews. 


 SELECT title AS unreviewed_series
FROM series
LEFT JOIN reviews
    ON series.id = reviews.series_id
WHERE rating IS NULL;

# We use the logic in the WHERE statement to produce only the TV Series that have no value (NULL) for rating.


--CHALLENGE 5: IDENTIFY THE AVERAGE RATING FOR EACH GENRE OF TV SERIES (INNER JOIN)


SELECT
  genre,
  Round(AVG(rating), 2) AS avg_rating
FROM series
INNER JOIN reviews
  ON series.id = reviews.series_id
GROUP BY series.genre
ORDER BY avg_rating;

# We can encompass AVG(rating) within a Round() function in order to round to the nearest 2 decimal places.


--CHALLENGE 6: COMPILING STATISTICS ON OUR USERS (LEFT JOIN)

# In this challenge, we are using analytics with MIN/MAX/AVG functions in our SQL code to identify statistics
# for the Users in our reviewers table such as Lowest Review Highest Review and Average Review. 

# We are also creating a new column which will indicate whether the user has an ACTIVE or INACTIVE status. 
# If the user has 10 or more reviews additionally, we can classify them as a POWER USER. 

# The left part of our JOIN is everything in the reviewers table. While primarily the logic will be performed on 
# the data in the Reviews table.


SELECT
  first_name,
  last_name,
  COUNT(rating) AS 'TOTAL REVIEWS',
  IFNULL(MIN(rating), 0) AS 'LOWEST REVIEW',
  IFNULL(MAX(rating), 0) AS 'HIGHEST REVIEW',
  ROUND(IFNULL(Avg(rating), 0), 2) AS 'AVERAGE REVIEW',
  CASE
    WHEN COUNT(rating) >= 10 THEN 'POWER USER'
    WHEN COUNT(rating) > 0 THEN 'ACTIVE'
    ELSE 'INACTIVE'
  END AS STATUS
FROM reviewers
LEFT JOIN reviews
  ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

# Because a user with no reviews would return NULL values, we can encompass our MIN/MAX/AVG functions with a IFNULL logic statement.
# If the result is NULL, it is replaced with the value of 0

# By using a case statement, we can integrate logic to easily identify Users by tags such as INACTIVE, ACTIVE, or POWER USER.


--CHALLENGE 7: PERFORMING A JOIN WITH ALL OF OUR TABLES (MULTIPLE INNER JOIN)

# For our final challenge, we will be producing a new results table which contains a little information from all three of our tables.
# The goal is to produce a table which contains the title of each of our TV Series, along with every rating, and a concatonated column
# containing the first and last names of every user who left a review. 


SELECT
  title,
  rating,
  CONCAT(first_name, ' ', last_name) AS REVIEWER
FROM reviewers
INNER JOIN reviews
  ON reviewers.id = reviews.reviewer_id
INNER JOIN series
  ON series.id = reviews.series_id
ORDER BY title;

# In effect by performing this double INNER JOIN, we are taking our Primary ID keys from the "Reviewers" and "Series" tables, and matching
# Them with their prespective Foreign Keys: reviewer_id, series_id. These Foreign Keys reside in the "Reviews Table".