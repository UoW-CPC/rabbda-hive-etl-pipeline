use earthquakesbasic;

drop table if exists earthquakes_closest_city;

create table earthquakes_closest_city
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
  city_distance double
  )
row format delimited fields terminated by ',';


INSERT OVERWRITE TABLE earthquakes_closest_city 
SELECT e.id as id, e.time as time, e.day as day, e.latitude as latitude, e.longitude as longitude, e.magnitude as magnitude, 
       e.city as city, e.city_latitude as city_latitude, e.city_longitude as city_longitude, e.country as country, e.population as population,
     e.city_distance as city_distance
FROM earthquakes_distance_to_all_cities e INNER JOIN
  (
    SELECT id, MIN(city_distance) as MinDistance
    FROM earthquakes_distance_to_all_cities
    GROUP BY id
  ) t ON e.id = t.id AND e.city_distance = t.MinDistance;