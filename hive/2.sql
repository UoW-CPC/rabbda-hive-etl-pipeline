use earthquakesbasic;

drop table if exists earthquakes;

create table earthquakes
(
  id string,
  time string,
  day date,
  latitude double,
  longitude double,
  magnitude double
  )
row format delimited fields terminated by ',';


INSERT OVERWRITE TABLE earthquakes 
SELECT id as id, time as time, day as day, latitude as latitude, longitude as longitude, mag as magnitude 
FROM earthquakes_full_dataset;