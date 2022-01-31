-- Determine the potential number of customers a store staff would serve 
-- (count the number of customer in the same country as the staff)
-- Column => staff_full_name, customer_count

SELECT
	CONCAT(s.first_name, ' ', s.last_name) AS staff_full_name,
	COUNT(country.country_id) AS customer_count
FROM 
	public.staff AS s
JOIN	
	public.customer AS cu
ON
	cu.store_id = s.store_id
JOIN
	public.store AS store
ON
	store.store_id = cu.store_id
JOIN 
	public.address AS add
ON
	store.address_id = add.address_id
JOIN
	public.city AS city
ON
	add.city_id = city.city_id
JOIN
	public.country AS country
ON
	city.country_id = country.country_id
GROUP BY
	staff_full_name   
