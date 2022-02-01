-- Determine the potential number of customers a store staff would serve 
-- (count the number of customer in the same country as the staff)
-- Column => staff_full_name, customer_count

SELECT
	staff_country.staff_full_name,
	COALESCE(customer_per_country.customer_count, 0) AS customer_count

FROM (
	SELECT
		CONCAT(s.first_name, ' ', s.last_name) AS staff_full_name,
		country.country_id AS country_id
	FROM	public.staff AS s
	JOIN	public.store AS store
	ON	s.store_id = store.store_id
	JOIN	public.address AS add
	ON	store.address_id = add.address_id
	JOIN	public.city AS city
	ON	add.city_id = city.city_id
	JOIN	public.country AS country
	ON	city.country_id = country.country_id
	GROUP BY
		staff_full_name,
		country.country_id
) AS staff_country

LEFT JOIN (
	SELECT
		country.country_id AS country_id,
		COUNT(c.customer_id) AS customer_count,
		country.country AS c_name
	FROM	public.customer AS c
	JOIN	public.address AS add
	ON	c.address_id = add.address_id
	JOIN	public.city AS city
	ON	add.city_id = city.city_id
	JOIN	public.country AS country
	ON	city.country_id = country.country_id
	GROUP BY
		country.country_id
	ORDER BY
		country.country_id
) AS customer_per_country

ON
	staff_country.country_id = customer_per_country.country_id