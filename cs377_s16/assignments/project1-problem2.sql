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