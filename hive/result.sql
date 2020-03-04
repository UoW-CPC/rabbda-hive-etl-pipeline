use earthquakesbasic;


drop table if exists results;

create table results
(
  seismograph string,
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

LOAD DATA INPATH '/user/dkagialis/demo/results.csv' OVERWRITE INTO TABLE results;