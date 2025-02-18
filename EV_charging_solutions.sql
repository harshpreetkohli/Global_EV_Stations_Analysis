
--1. Identify missing values in critical fields

SELECT 
	*
FROM 
	ev_charging_stations
WHERE
	charging_capacity_kw IS NULL OR parking_spots IS NULL;

--2. Count total charging stations in Berlin

SELECT 
	COUNT(*) AS total_stations
FROM 
	ev_charging_stations
WHERE
	address ILIKE '%Berlin%';

--3. Percentage of each charger type

SELECT 
    charger_type,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ev_charging_stations) AS percentage
FROM 
    ev_charging_stations
GROUP BY 
    charger_type
ORDER BY 
    percentage DESC;

-- 4. Top station operators by number of stations

SELECT 
	station_operator,
	COUNT(*) AS station_count
FROM 
	ev_charging_stations
GROUP BY 
	station_operator
ORDER BY
	station_count DESC;

--5. Find the top 5 busiest stations

SELECT 
	station_id,
	usage_stats_avg_users_per_day,
	station_operator,
	address
FROM
	ev_charging_stations
ORDER BY
	usage_stats_avg_users_per_day DESC
LIMIT
	5;

--6. Identify underutilized stations

SELECT 
	station_id,
	usage_stats_avg_users_per_day,
	station_operator,
	address
FROM
	ev_charging_stations
ORDER BY 
	usage_stats_avg_users_per_day ASC
LIMIT 
	5;

--7. List all Stations with Renewable Energy Sources

SELECT 
	station_id,
	station_operator,
	address,
	renewable_energy_source
FROM 
	ev_charging_stations
WHERE 
	renewable_energy_source LIKE 'Yes';

--8. Find the total number of stations with Renewable Energy Sources

SELECT 
    renewable_energy_source,
    COUNT(*) AS station_count
FROM 
	ev_charging_stations
WHERE
	renewable_energy_source = 'Yes' 
GROUP BY
	renewable_energy_source;

--9. Find the Average Rating of Charging Stations

SELECT 
    AVG(reviews_or_ratings) AS average_rating
FROM 
    ev_charging_stations;

--10. List Stations within a Certain Distance to the City (e.g., Less than 10 km)

SELECT 
    station_id,
    address,
    distance_to_city_km
FROM 
    ev_charging_stations
WHERE 
    distance_to_city_km < 10;

--11. Find Stations by Operator (Tesla)

SELECT 
    station_id,
    address,
    usage_stats_avg_users_per_day
FROM 
    ev_charging_stations
WHERE 
    station_operator = 'Tesla';

--12. Find the highest Reviewed Stations

SELECT 
    station_id,
	address,
    reviews_or_ratings
FROM 
    ev_charging_stations
ORDER BY 
    reviews_or_ratings DESC
LIMIT 10;

--13. Count the Number of Charging Stations Installed Each Year

SELECT 
    installation_year,
    COUNT(station_id) AS total_stations
FROM 
    ev_charging_stations
GROUP BY 
    installation_year
ORDER BY 
    installation_year DESC;


--14. Calculate the Total Number of Parking Spots Available by Operator

SELECT 
    station_operator,
    SUM(parking_spots) AS total_parking_spots
FROM 
    ev_charging_stations
GROUP BY 
    station_operator
ORDER BY 
    total_parking_spots DESC;




