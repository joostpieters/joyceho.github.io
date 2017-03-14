/* Part A */
SELECT genre FROM movie, genre WHERE id = mid AND name = 'Despicable Me';

/* Part B */
SELECT name, year FROM movie, genre
WHERE year <= 2013 AND year >= 2011
AND id = mid AND genre = 'Animation' order by year, name;

/* Part C */
SELECT movie.name, year
FROM movie, genre, movie_director, director 
WHERE movie.id = movie_director.mid AND movie_director.mid = genre.mid
AND did = director.id
AND fname = 'Steven' AND lname = 'Soderbergh'
AND genre = 'Thriller'
ORDER BY year DESC;

/* Part D */
SELECT name, role
FROM movie, actor, casts
WHERE movie.id = mid AND actor.id = aid
AND fname = 'Steve' AND lname = 'Carell';

/* Part E */
SELECT DISTINCT actor.fname, actor.lname
FROM actor, casts, director, movie_director
WHERE casts.mid = movie_director.mid and director.id = did
AND director.fname ='Woody' AND director.lname = 'Allen'
AND aid = actor.id
ORDER BY actor.fname ASC;

/* Part F */
SELECT movie.name, actor.fname, actor.lname
FROM actor, casts, movie_director, director, movie
WHERE actor.fname = director.fname
AND actor.lname = director.lname
AND actor.gender = 'F'
AND casts.mid = movie_director.mid
AND director.id = movie_director.did
AND casts.aid = actor.id
AND movie.id = casts.mid;

/* Part G */
SELECT DISTINCT name
FROM casts, movie
WHERE mid = id
AND year = 2004
GROUP BY aid, mid
HAVING COUNT(role) > 1;

/* Part H */
SELECT genre, COUNT(DISTINCT aid)
FROM casts, genre, movie
WHERE genre.mid = casts.mid
AND movie.id = genre.mid
AND year = 2010
GROUP BY genre;

/* Part I */
SELECT a.fname, a.lname, COUNT(mid)
FROM movie m, casts c, actor a
WHERE year = 2004 AND m.id = c.mid AND a.id = c.aid
GROUP BY aid
HAVING COUNT(mid) >= 10
ORDER BY a.lname;

/* Part J */
SELECT d.fname, d.lname, COUNT(md.mid)
FROM director d, movie_director md, movie m
WHERE md.mid = m.id AND m.year >= 2005 AND m.year <= 2010 AND d.id = md.did
GROUP BY md.did
ORDER BY COUNT(md.mid) DESC
LIMIT 100;

/* Part K */
SELECT fname, lname, name, role
FROM casts, movie, actor
WHERE mid = movie.id
AND actor.id = aid
AND year = 2011
AND role LIKE '%Officer%';

/* Part L */
SELECT *
FROM director
WHERE id NOT IN
    (SELECT did
     FROM movie, movie_director
     WHERE year = 2005
     AND id = mid)
AND lname = 'Zapata';

/* Part M */
SELECT fname, lname, id, COUNT(DISTINCT mid)
FROM actor, casts
WHERE mid IN
    (SELECT mid
     FROM actor, casts
     WHERE fname = 'Meryl'
     AND lname = 'Streep'
     AND aid = id)
AND aid <> (SELECT id
     FROM actor
     WHERE fname = 'Meryl'
     AND lname = 'Streep')
AND aid = id
GROUP BY id;
