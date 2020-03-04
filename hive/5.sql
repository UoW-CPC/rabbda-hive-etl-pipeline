use earthquakesbasic;


drop table if exists earthquakes_closest_city_discance_to_all_stations;

create table earthquakes_closest_city_discance_to_all_stations
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
  station_country string,
  station_latitude double,
  station_longitude double,
  station_datacenter string,
  station_distance double
  )
row format delimited fields terminated by ',';


INSERT OVERWRITE TABLE earthquakes_closest_city_discance_to_all_stations 
SELECT e.id as id, e.time as time, e.day as day, e.latitude as latitude, e.longitude as longitude, e.magnitude as magnitude, 
       e.city as city, e.city_latitude as city_latitude, e.city_longitude as city_longitude, e.country as country, e.population as population,
     e.city_distance as city_distance,
     s.station_code as station_code, s.station_name as station_name, s.country as station_country,
     s.latitude as station_latitude, s.longitude as station_longitude, s.datacenter as station_datacenter,
     60*1.1515*(180*(acos(((sin(radians(e.latitude))*sin(radians(s.latitude)))+(cos(radians(e.latitude))*cos(radians(s.latitude))*cos(radians(e.longitude - s.longitude))))))/PI()) as station_distance
FROM earthquakes_closest_city e
CROSS JOIN seismographic_stations s;