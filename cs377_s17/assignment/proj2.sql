USE imdb;

/* Part 1*/
SELECT name, year
FROM movie
WHERE id IN 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id
                   FROM actor
                   WHERE fname = 'Matt' AND lname = 'Damon') )
  AND id in 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id 
                   FROM actor
                   WHERE fname = 'George' AND lname = 'Clooney') )
  AND id in 
    ( SELECT mid
      FROM casts
      WHERE aid = (SELECT id
                   FROM actor
                   WHERE fname = 'Brad' AND lname = 'Pitt') );

/* Part 2*/
SELECT distinct name, year
FROM movie
WHERE movie.id IN ( SELECT casts.mid
                    FROM actor, casts, genre
                    WHERE fname = 'Tom' AND lname = 'Hanks'
                    AND actor.id = casts.aid
                    AND genre.mid = casts.mid
                    AND genre = 'Comedy' ) 
OR movie.id in ( SELECT movie_director.mid
                 FROM director, movie_director, genre
                 WHERE fname = 'Tom' AND lname = 'Hanks'
                 AND director.id = movie_director.did
                 AND genre.mid = movie_director.mid
                 AND genre = 'Comedy') ;

/* Part 3 */
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

/* Part 4 */
SELECT DISTINCT name, id
FROM casts, movie
WHERE movie.year = 2010
AND movie.id = casts.mid
AND casts.mid NOT IN (SELECT DISTINCT casts.mid
                      FROM actor, casts, movie
                      WHERE gender = 'F'
                      AND movie.year = 2010
                      AND actor.id = casts.aid
                      AND movie.id = casts.mid);

/* Part 5 */
SELECT m.year, COUNT(DISTINCT m.id)
FROM movie m, casts c
WHERE m.id NOT IN
    (SELECT m.id
     FROM movie m, actor a, casts c
     WHERE m.id = c.mid AND a.id = c.aid AND a.gender = 'M')
    AND m.id = c.mid
GROUP BY m.year;


/* Part 6 */
SELECT fname, lname
FROM actor
WHERE NOT EXISTS ( SELECT *
                   FROM casts c
                   WHERE c.mid IN (SELECT kb.mid
                                   FROM casts kb, movie, genre
                                   WHERE kb.aid = (SELECT id
                                                   FROM actor
                                                   WHERE fname = 'Stephen' and lname = 'Chow')
                                   AND movie.id = kb.mid
                                   AND year < 2009
                                   AND movie.id = genre.mid
                                   AND genre = 'Comedy')
                   AND c.mid NOT IN (SELECT t.mid
                                     FROM casts t
                                     WHERE t.aid = actor.id) )
AND id <> (SELECT id FROM actor WHERE fname = 'Stephen' AND lname = 'Chow');

/* Optimized query for this question */
SELECT DISTINCT id, fname, lname
FROM (SELECT aid FROM casts
      WHERE mid IN (SELECT kb.mid
                    FROM casts kb, movie, genre
                    WHERE kb.aid = (SELECT id
                                    FROM actor
                                    WHERE fname = 'Stephen' AND lname = 'Chow')
                    AND movie.id = kb.mid
                    AND year < 2009
                    AND movie.id = genre.mid
                    AND genre = "Comedy")) AS scma, actor
WHERE NOT EXISTS ( SELECT *
                   FROM casts c
                   WHERE c.mid IN (SELECT kb.mid
                                   FROM casts kb, movie, genre
                                   WHERE kb.aid = (SELECT id
                                                   FROM actor
                                                   WHERE fname = 'Stephen'
                                                   AND lname = 'Chow')
                                   AND movie.id = kb.mid
                                   AND year < 2009
                                   AND movie.id = genre.mid
                                   AND genre = "Comedy")
                   AND c.mid NOT IN (SELECT t.mid
                                     FROM casts t
                                     WHERE t.aid = id) )
AND id = scma.aid
AND id <> (SELECT id FROM actor WHERE fname = 'Stephen' AND lname = 'Chow');


/* Part 7 */
SELECT fname, lname, name, year
FROM director, movie, movie_director, genre
WHERE director.id = movie_director.did
AND movie.id = movie_director.mid
AND movie.id = genre.mid
AND genre = 'Biography'
AND year % 4 = 0
ORDER BY year, name;


/* Part 8 */
SELECT fname, lname, name, COUNT(DISTINCT role) as nrole
FROM actor, casts, movie
WHERE year = 2007
AND casts.mid = movie.id
AND actor.id = casts.aid
GROUP BY aid, mid
HAVING count(distinct role) >= 5;

/* Part 9 */
SELECT fname, lname
FROM actor, casts
WHERE gender = 'F'
AND actor.id = casts.aid
AND casts.mid IN ( SELECT movie.id
                   FROM genre, movie
                   WHERE genre.mid = movie.id
                   AND genre = 'Family'
                   AND year <= 2010
                   AND year >= 2005)
GROUP BY aid
HAVING count(mid) >= ALL( SELECT COUNT(mid)
                          FROM actor, casts
                          WHERE gender = 'F'
                          AND actor.id = casts.aid
                          AND casts.mid IN ( SELECT movie.id
                                             FROM genre, movie
                                             WHERE genre.mid = movie.id
                                             AND genre = 'Family'
                                             AND year <= 2010
                                             AND year >= 2005)
                          GROUP BY aid);

/* Parts for part 10 */
CREATE TEMPORARY TABLE kbm AS (SELECT mid
                               FROM actor, casts
                               WHERE fname = 'Kevin' AND lname = 'Bacon'
                               AND actor.id = casts.aid);
CREATE TEMPORARY TABLE kbn1 AS (SELECT aid
                                FROM casts
                                WHERE mid IN (SELECT mid FROM kbm)
                                AND aid NOT IN (SELECT id
                                                FROM actor
                                                WHERE fname = 'Kevin' AND lname = 'Bacon'));
CREATE TEMPORARY TABLE kbn1m AS (SELECT mid
                                 FROM casts
                                 WHERE aid IN (SELECT aid from kbn1)
                                 AND mid NOT IN (SELECT mid from kbm));

SELECT DISTINCT aid, fname, lname
FROM casts, actor
WHERE mid IN (SELECT mid FROM kbn1m)
AND aid NOT IN (SELECT aid FROM kbn1)
AND aid <> (SELECT id FROM actor
            WHERE fname = 'Kevin' AND lname = 'Bacon')
AND casts.aid = actor.id;

/* Final query for Part 10 */
SELECT DISTINCT aid, fname, lname
FROM casts, actor
WHERE mid IN (SELECT mid
              FROM casts
              WHERE aid IN (SELECT aid
                            FROM casts
                            WHERE mid IN (SELECT mid
                                          FROM actor, casts
                                          WHERE fname = 'Kevin'
                                          AND lname = 'Bacon'
                                          AND actor.id = casts.aid)
                            AND aid NOT IN (SELECT id
                                            FROM actor
                                            WHERE fname = 'Kevin'
                                            AND lname = 'Bacon'))
              AND mid NOT IN (SELECT mid
                              FROM actor, casts
                              WHERE fname = 'Kevin' AND lname = 'Bacon'
                              AND actor.id = casts.aid))
AND aid NOT IN (SELECT aid
                FROM casts
                WHERE mid IN (SELECT mid
                              FROM actor, casts
                              WHERE fname = 'Kevin' AND lname = 'Bacon'
                              AND actor.id = casts.aid)
                AND aid NOT IN (SELECT id
                                FROM actor
                                WHERE fname = 'Kevin' AND lname = 'Bacon'))
AND aid <> (SELECT id FROM actor
            WHERE fname = 'Kevin' AND lname = 'Bacon')
AND casts.aid = actor.id;

