-- show the indexes that were created on the movie table
SHOW INDEX FROM movie;

-- drop index from movie table
DROP INDEX movieYr_idx ON movie;

-- count the number of movies from 2004
SELECT COUNT(*) FROM movie WHERE year = 2004;
SELECT COUNT(*) FROM movie WHERE year < 2007 AND year >= 2004;

-- create the hash index on year for each movie
CREATE INDEX movieYr_idx ON movie(year) USING HASH;
-- rerun the count query to see how long it takes
SELECT COUNT(*) FROM movie WHERE year = 2004;
SELECT COUNT(*) FROM movie WHERE year < 2007 AND year >= 2004;


DROP INDEX movieYr_idx ON movie;
-- create an index on year for each movie (b-tree)
CREATE INDEX movieYr_idx ON movie(year);

-- rerun the count query to see how long it takes
SELECT COUNT(*) FROM movie WHERE year = 2004;
SELECT COUNT(*) FROM movie WHERE year < 2007 AND year >= 2004;

-- show the indexes that were created on actor
SHOW INDEX FROM actor;

DROP INDEX actorLname_idx ON actor;

-- run a few queries to get an idea of how long it takes w/o indices
SELECT * FROM actor WHERE fname = 'Matt';
SELECT * FROM actor where lname = 'Smith';
SELECT * FROM actor WHERE fname = 'Matt' AND lname = 'Smith';
SELECT * FROM actor where fname = 'Alex' AND gender = 'F';

-- create the last name index
CREATE INDEX actorLname_idx ON actor(lname);
SELECT * FROM actor WHERE fname = 'Matt';
SELECT * FROM actor where lname = 'Smith';
SELECT * FROM actor WHERE fname = 'Matt' AND lname = 'Smith';
SELECT * FROM actor where fname = 'Alex' AND gender = 'F';

-- create the first name index
CREATE INDEX actorFname_idx ON actor(fname);
SELECT * FROM actor WHERE fname = 'Matt';
SELECT * FROM actor where lname = 'Smith';
SELECT * FROM actor WHERE fname = 'Matt' AND lname = 'Smith';
SELECT * FROM actor where fname = 'Alex' AND gender = 'F';

-- create the first name, gender index
CREATE INDEX actorFnameGender_idx ON actor(fname, gender);
SELECT * FROM actor where fname = 'Alex' AND gender = 'F';
SHOW INDEX FROM actor;