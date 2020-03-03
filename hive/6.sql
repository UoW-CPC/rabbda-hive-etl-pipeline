use earthquakesbasic;

drop table if exists earthquakes_closest_city_station;

create table earthquakes_closest_city_station
(
  id string,
  time string,
  day date,
  latitude double,
  longitude double,
  magnitude double,
  city string,
  city_latitude double,
  city_longitude double,
  country string,
  population int,
  city_distance double,
  station_code string,
  station_name string,
  station_latitude double,
  station_longitude double,
  station_datacenter string,
  station_distance double
  )
row format delimited fields terminated by ',';


INSERT OVERWRITE TABLE earthquakes_closest_city_station 
SELECT 
e.id as id,
e.time as time,
e.day as day,
e.latitude as latitude,
e.longitude as longitude,
e.magnitude as magnitude, 
e.city as city,
e.city_latitude as latitude,
e.city_longitude as longitude,
e.country as country,
e.population as population,
e.city_distance as city_distance,
e.station_code as station_code,
e.station_name as station_name,
e.station_latitude as station_latitude,
e.station_longitude as station_longitude,
e.station_datacenter as station_datacenter,
e.station_distance as station_distance
FROM earthquakes_closest_city_discance_to_all_stations e INNER JOIN
	(
	  SELECT id, MIN(station_distance) as MinDistance
	  FROM earthquakes_closest_city_discance_to_all_stations
	  GROUP BY id
	  ) t ON e.id = t.id AND e.station_distance = t.MinDistance;