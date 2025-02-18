# Global_EV_Stations_Analysis
Analyzing EV charging infrastructure using SQL to optimize station placement and improve efficiency.

## Overview
The Global EV Stations Analysis project aims to provide insights into the availability and usage of EV charging stations. By analyzing data such as charging capacity, usage statistics, and station operators, we can better understand the current state of EV infrastructure and identify opportunities for improvement.

## Objectives
* Identify missing values in critical fields to ensure data quality.
* Analyze the distribution of charging stations across different locations, particularly in Berlin.
* Evaluate the types of chargers available and their prevalence.
* Identify the top station operators and their contribution to the charging station network.
* Assess the busiest and underutilized stations to inform future infrastructure planning.
* Investigate the availability of renewable energy sources at charging stations.
* Analyze customer reviews to determine the average ratings of charging stations.
* Understand the trends in charging station installations over the years.

## Dataset

The data for this project is sourced from the Kaggle dataset:

* Dataset Link: [Global Ev Stations Dataset](https://www.kaggle.com/datasets/vivekattri/global-ev-charging-stations-dataset?resource=download)

## Database Schema

The dataset used for analysis is structured as follows:

### Table: `ev_charging_stations`

```sql
CREATE TABLE ev_charging_stations (
    station_id VARCHAR(15) PRIMARY KEY,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    address VARCHAR(100),
    charger_type VARCHAR(50),
    cost_USD_kWh DECIMAL(4,2),
    availability VARCHAR(50),
    distance_to_city_km DECIMAL(4,2),
    usage_stats_avg_users_per_day INT,
    station_operator VARCHAR(25),
    charging_capacity_kW INT,
    connector_types VARCHAR(50),
    installation_year INT,
    renewable_energy_source VARCHAR(10),
    reviews_or_ratings DECIMAL(2,1),
    parking_spots INT,
    maintenance_frequency VARCHAR(20)
);
```
## Column Descriptions

| Column Name                  | Data Type        | Description                                                   |
|------------------------------|------------------|---------------------------------------------------------------|
| station_id                   | VARCHAR(15)      | Unique identifier for each charging station.                  |
| latitude                     | DECIMAL(10,6)    | Latitude coordinate of the charging station.                  |
| longitude                    | DECIMAL(10,6)    | Longitude coordinate of the charging station.                 |
| address                      | VARCHAR(100)      | Physical address of the charging station.                     |
| charger_type                 | VARCHAR(50)      | Type of charger available (e.g., Type 1, Type 2).           |
| cost_USD_kWh                 | DECIMAL(4,2)     | Cost of charging per kWh in USD.                             |
| availability                 | VARCHAR(50)      | Availability status of the charging station.                  |
| distance_to_city_km         | DECIMAL(4,2)     | Distance from the city in kilometers.                  |
| usage_stats_avg_users_per_day | INT              | Average number of users per day at the station.              |
| station_operator             | VARCHAR(25)      | Company or entity operating the charging station.             |
| charging_capacity_kW         | INT               | Charging capacity of the station in kilowatts.                |
| connector_types              | VARCHAR(50)      | Types of connectors available at the station.                 |
| installation_year            | INT               | Year when the station was installed.                          |
| renewable_energy_source      | VARCHAR(10)      | Indicates if the station uses renewable energy.               |
| reviews_or_ratings          | DECIMAL(2,1)     | Average rating or reviews for the charging station.           |
| parking_spots                | INT               | Number of parking spots available.                            |
| maintenance_frequency         | VARCHAR(20)      | Frequency of maintenance for the charging station.            |


## SQL Solutions

Here are the SQL queries implemented in this project:

1. **Identify missing values in critical fields**:
```sql
SELECT 
	*
FROM 
	ev_charging_stations
WHERE
	charging_capacity_kw IS NULL OR parking_spots IS NULL;
```
2. **Count total charging stations in Berlin**:
```sql
SELECT 
	COUNT(*) AS total_stations
FROM 
	ev_charging_stations
WHERE
	address ILIKE '%Berlin%';
```
3. **Percentage of each charger type**:
```sql
SELECT 
    charger_type,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ev_charging_stations) AS percentage
FROM 
    ev_charging_stations
GROUP BY 
    charger_type
ORDER BY 
    percentage DESC;
```
4. **Top station operators by number of stations**:
```sql
SELECT 
	station_operator,
	COUNT(*) AS station_count
FROM 
	ev_charging_stations
GROUP BY 
	station_operator
ORDER BY
	station_count DESC;
```
5. **Find the top 5 busiest stations**:
```sql
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
```
6. **Identify underutilized stations**:
```sql
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
```
7. **List all Stations with Renewable Energy Sources**:
```sql
SELECT 
	station_id,
	station_operator,
	address,
	renewable_energy_source
FROM 
	ev_charging_stations
WHERE 
	renewable_energy_source LIKE 'Yes';
```
8. **Find the total number of stations with Renewable Energy Sources:
```sql
SELECT 
    renewable_energy_source,
    COUNT(*) AS station_count
FROM 
	ev_charging_stations
WHERE
	renewable_energy_source = 'Yes' 
GROUP BY
	renewable_energy_source;
```
9. **Find the Average Rating of Charging Stations**:
```sql
SELECT 
    AVG(reviews_or_ratings) AS average_rating
FROM 
    ev_charging_stations;
```
10. **List Stations within a Certain Distance to the City (e.g., Less than 10 km)**:
```sql
SELECT 
    station_id,
    address,
    distance_to_city_km
FROM 
    ev_charging_stations
WHERE 
    distance_to_city_km < 10;
```
11. **Find Stations by Operator (Tesla)**:
```sql
SELECT 
    station_id,
    address,
    usage_stats_avg_users_per_day
FROM 
    ev_charging_stations
WHERE 
    station_operator = 'Tesla';
```
12. **Find the highest Reviewed Stations**:
```sql
SELECT 
    station_id,
	address,
    reviews_or_ratings
FROM 
    ev_charging_stations
ORDER BY 
    reviews_or_ratings DESC
LIMIT 10;
```
13. **Count the Number of Charging Stations Installed Each Year**:
```sql
SELECT 
    installation_year,
    COUNT(station_id) AS total_stations
FROM 
    ev_charging_stations
GROUP BY 
    installation_year
ORDER BY 
    installation_year DESC;
```
14. **Calculate the Total Number of Parking Spots Available by Operator**
```sql
SELECT 
    station_operator,
    SUM(parking_spots) AS total_parking_spots
FROM 
    ev_charging_stations
GROUP BY 
    station_operator
ORDER BY 
    total_parking_spots DESC;
```
   

### Conclusion

The **Global EV Stations Analysis** provides a comprehensive overview of the current state of EV charging infrastructure. By leveraging SQL queries to extract meaningful insights, stakeholders can make informed decisions regarding future investments, operational improvements, and strategic planning.

Key takeaways include the importance of addressing data quality issues, understanding user preferences, and promoting sustainability through renewable energy sources. Additionally, the findings underscore the need for continuous monitoring of charging station performance and user satisfaction to enhance the overall EV charging experience.

Future work may include more detailed analyses, such as user behavior studies, geographical mapping of stations, and the impact of incentives on EV adoption. By continually refining the data and insights derived from this analysis, we can contribute to the broader goal of expanding and improving EV infrastructure globally.
