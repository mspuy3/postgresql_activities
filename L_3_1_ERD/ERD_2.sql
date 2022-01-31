-- 2. List all the films of Dan Torn and Dan Streep. Sort by film_title alphabetical order
-- Column => film_title, release_year, and rating, and actor_full_name.

SELECT
	c.title as film_title,
	c.release_year,
	c.rating,
	CONCAT(a.first_name, ' ', a.last_name) as actor_full_name
FROM
	public.actor AS a
INNER JOIN
	public.film_actor AS s
ON
	s.actor_id = a.actor_id
INNER JOIN 
	public.film AS c 
ON 
	c.film_id = s.film_id
WHERE
	a.first_name = 'Dan'
	and 
	(a.last_name = 'Torn' or a.last_name = 'Streep')