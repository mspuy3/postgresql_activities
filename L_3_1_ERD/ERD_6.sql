-- 6. Rank the top 5 actors per country (determined by the number rentals) sort by most popular to least popular
--   Column => country, actor_full_name, actor_rank, rent_count

-- https://www.sqlshack.com/overview-of-sql-rank-functions/

-- sq1 counts rent per actor per country
-- sq2 ranks by rent/actor per country
-- final query limits call to first 5 per country

SELECT
	sq2.country,
	sq2.actor_full_name,
	sq2.actor_rank,
	sq2.rent_count
FROM (
	SELECT
		sq1.country,
		sq1.actor_full_name,
		ROW_NUMBER() OVER(PARTITION BY sq1.country ORDER BY sq1.rent_count DESC) AS actor_rank,
		sq1.rent_count
	FROM (
		SELECT
			CONCAT(a.first_name, ' ', a.last_name) AS actor_full_name,
			COUNT(r.rental_id) AS rent_count,
			co.country AS country
		FROM	public.actor AS a
		JOIN	public.film_actor AS fa
		ON	a.actor_id = fa.actor_id
		JOIN	public.inventory AS i
		ON	fa.film_id = i.film_id
		JOIN	public.rental AS r
		ON	i.inventory_id = r.inventory_id
		JOIN	public.staff AS sa
		ON	r.staff_id = sa.staff_id
		JOIN	public.store AS so
		ON	sa.store_id = so.store_id
		JOIN	public.address AS ad
		ON	so.address_id = ad.address_id
		JOIN	public.city AS c
		ON	ad.city_id = c.city_id
		JOIN	public.country AS co
		ON	c.country_id = co.country_id
		GROUP BY 
			actor_full_name,
			country
	) AS sq1
) AS sq2
WHERE
	sq2.actor_rank < 6