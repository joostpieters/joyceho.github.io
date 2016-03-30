USE imdb;

/* Part a */
SELECT a.fname, a.lname, aid, COUNT(mid)
FROM movie m, casts c, actor a
WHERE year = 2004 AND m.id = c.mid AND a.id = c.aid
GROUP BY aid
HAVING COUNT(mid) >= 10;

/* Part b*/

/* Part c*/
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
      WHERE aid = (SELECT id FROM actor WHERE fname = 'Brad' AND lname = 'Pitt') );

/* Part d */
SELECT d.fname, d.lname, COUNT(md.mid)
FROM director d, movie_director md, movie m
WHERE md.mid = m.id AND m.year >= 2005 AND m.year <= 2010 AND d.id = md.did
GROUP BY md.did
ORDER BY COUNT(md.mid) DESC
LIMIT 100;

/* Part e */
SELECT *
FROM actor
WHERE id NOT IN 
( SELECT aid
  FROM casts c, movie_director md, director d
  WHERE md.did = d.id AND md.mid = c.mid
     AND NOT (d.fname = 'Steven' AND d.lname = 'Soderbergh'))
AND id IN 
( SELECT aid
  FROM casts c, movie_director md, director d
  WHERE md.did = d.id AND md.mid = c.mid
     AND d.fname = 'Steven' AND d.lname = 'Soderbergh');

/* Part f */
SELECT m.year, COUNT(DISTINCT m.id)
FROM movie m, casts c
WHERE m.id NOT IN
    (SELECT m.id
     FROM movie m, actor a, casts c
     WHERE m.id = c.mid AND a.id = c.aid AND a.gender = 'M')
    AND m.id = c.mid
GROUP BY m.year;
