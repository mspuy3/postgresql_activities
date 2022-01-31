-- 1. Display the number of unique inventory rented and the total number of inventory rented
-- Column => unique_inventory_rented, total_inventory_rented

SELECT
	COUNT(DISTINCT inventory_id) AS unique_inventory_rented,
	COUNT(*) AS total_inventory_rented
FROM
	public.rental;
