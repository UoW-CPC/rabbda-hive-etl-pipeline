use earthquakesbasic;

drop table if exists earthquakes_distance_to_all_cities;

create table earthquakes_distance_to_all_cities
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


INSERT OVERWRITE TABLE earthquakes_distance_to_all_cities 
SELECT e.id as id, e.time as time, e.day as day, e.latitude as latitude, e.longitude as longitude, e.magnitude as magnitude, 
       c.city_ascii as city, c.lat as latitude, c.lng as longitude, c.country as country, c.population as population,
     60*1.1515*(180*(acos(((sin(radians(e.latitude))*sin(radians(c.lat)))
              +(cos(radians(e.latitude))*cos(radians(c.lat))*cos(radians(e.longitude - c.lng))))))
          /PI())            
as city_distance
FROM earthquakes e
CROSS JOIN cities c;