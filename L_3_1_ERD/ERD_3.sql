--3. List all Comedy films of all actors whose last names start with 'D'. Sort by actor_full_name alphabetical order
--Column => actor_full_name, film_title, category_name

SELECT
	CONCAT(a.first_name, ' ', a.last_name) as actor_full_name,
	f.title as film_title,
	c.name as category_name
FROM
	public.category AS c
INNER JOIN
	public.film_category AS fc
ON
	fc.category_id = c.category_id
INNER JOIN
	public.film AS f
ON
	f.film_id = fc.film_id
INNER JOIN
	public.film_actor AS fa
ON
	fa.film_id = f.film_id
INNER JOIN
	public.actor AS a
ON
	a.actor_id = fa.actor_id
WHERE
	c.name = 'Comedy'
	and
	LEFT(a.last_name, 1) = 'D'
ORDER BY
	actor_full_name