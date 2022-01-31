-- 5. Find the most popular film category per store (determined by the number of rentals)
--   Column => store_id, film_count, category_name

-- Solved using the "Joining with simple group-identifier, max-value-in-group Sub-query" Solution From https://stackoverflow.com/questions/7745609/sql-select-only-rows-with-max-value-on-a-column 

-- Basically, run the raw sub-table twice. Run A contains X, Y, Z. Run B contains X and MAX(Y). resulting JOINed table filters via MAX(Y), while retaining appropriate X groups and corresponding Z labels.

SELECT
	sub_query.ss AS store_id,
	sub_query.film_count_raw AS film_count,
	sub_query.cn AS category_name	

FROM (
	SELECT
		s.store_id AS ss,
		COUNT(c.category_id) AS film_count_raw,
		c.name AS cn
	FROM
		public.store AS s
	JOIN
		public.inventory AS i
	ON
		s.store_id = i.store_id
	JOIN
		public.rental AS r
	ON
		i.inventory_id = r.inventory_id
	JOIN
		public.film_category as f
	ON
		i.film_id = f.film_id
	JOIN
		public.category as c
	ON
		f.category_id = c.category_id
	GROUP BY
		s.store_id,
		c.name
) AS sub_query

INNER JOIN (
	SELECT 
		sub_query.ss AS store_id, 
		MAX(sub_query.film_count_raw) AS film_count
	FROM (
		SELECT
			s.store_id AS ss,
			COUNT(c.category_id) AS film_count_raw,
			c.name AS cn
		FROM
			public.store AS s
		JOIN
			public.inventory AS i
		ON
			s.store_id = i.store_id
		JOIN
			public.rental AS r
		ON
			i.inventory_id = r.inventory_id
		JOIN
			public.film_category as f
		ON
			i.film_id = f.film_id
		JOIN
			public.category as c
		ON
			f.category_id = c.category_id
		GROUP BY
			s.store_id,
			c.name
	) AS sub_query
	GROUP BY 
		store_id
) AS sq_2

ON
	sub_query.ss = sq_2.store_id 
	AND 
	sub_query.film_count_raw = sq_2.film_count 