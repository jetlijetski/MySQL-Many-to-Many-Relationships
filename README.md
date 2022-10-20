# MySQL-Many-to-Many-Relationships

Our example for this section will be a TV Show Reviewing Application. It will be comprised of Users who sign up to review as well as their reviews and a selection of TV shows. 

• This is a many to many relationship because one Reviewer can leave a review on many TV shows, and a single TV show can be reviewed by many different reviewers!

3 Tables Necessary

	1. Series Data <--- Exists on its own
	• Contains a Primary Key as well as the title, year released and genre of movies.

	2. Reviews Data <--- Contains info on the series and the Reviewer as well as rating
	• This table acts as the union table between the Series and the Reviewers tables.
	• Foreign Keys to reference the Series and Reviewers tables.
	
	3. Reviewers Data <-- Exists on its own
Contains a Primary Key and information on the first and last name of our users.
