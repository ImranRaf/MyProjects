/*8.d
select o.name, avg(r.rating) as average, count(r.rating) as cnt from occupations o join users u on u.occupation_id=o.id join ratings r on r.user_id=u.id join genres_movies g on g.movie_id=r.movie_id where g.id=11 group by o.name having cnt > 2 order by average desc;*/

/*8.e
SELECT o.name, g.name AS cnt FROM occupations o join users u ON u.occupation_id=o.id JOIN ratings r ON u.id=r.user_id JOIN genres_movies gm ON r.movie_id=gm.movie_id JOIN genres g ON gm.id=g.id GROUP BY o.name;*/

/*9
SELECT m.title, COUNT(r.rating) AS cnt FROM ratings r JOIN movies m ON r.movie_id=m.id GROUP BY m.title ORDER BY cnt desc LIMIT 1;*/

/*10
SELECT m.title, AVG(r.rating) AS average, COUNT(r.rating) AS cnt FROM ratings r JOIN movies m ON r.movie_id=m.id GROUP BY m.title HAVING cnt > 10 ORDER BY average desc LIMIT 1;*/

/*11
SELECT m.title, AVG(r.rating) AS average, COUNT(r.rating) AS cnt FROM ratings r JOIN movies m ON r.movie_id=m.id GROUP BY m.title HAVING cnt > 10 ORDER BY average asc LIMIT 1;*/

