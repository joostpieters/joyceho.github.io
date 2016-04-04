SHOW INDEX FROM actor;

/* Select actors where the id is intersection of the 3 actors */
EXPLAIN
SELECT name, year
FROM movie
WHERE id IN 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id FROM actor WHERE fname = 'Matt' AND lname = 'Damon') )
  AND id in 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id FROM actor WHERE fname = 'George' AND lname = 'Clooney') )
  AND id in 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id FROM actor WHERE fname = 'Brad' AND lname = 'Pitt') ) ;

/* Add the index of first name and last name */
CREATE INDEX actorname_idx ON actor(fname, lname);

EXPLAIN
SELECT name, year
FROM movie
WHERE id IN 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id FROM actor WHERE fname = 'Matt' AND lname = 'Damon') )
  AND id in 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id FROM actor WHERE fname = 'George' AND lname = 'Clooney') )
  AND id in 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id FROM actor WHERE fname = 'Brad' AND lname = 'Pitt') ) ;

/* Alternate query that takes advantage of the index */
EXPLAIN
SELECT name, year
FROM movie
WHERE id IN 
    ( SELECT mid
      FROM casts, actor
      WHERE casts.aid = actor.id AND actor.fname = 'Matt' AND actor.lname = 'Damon' )
  AND id in 
    ( SELECT mid
      FROM casts, actor
      WHERE casts.aid = actor.id AND actor.fname = 'George' AND actor.lname = 'Clooney')
  AND id in 
    ( SELECT mid
      FROM casts, actor
      WHERE casts.aid = actor.id AND actor.fname = 'Brad' AND actor.lname = 'Pitt');