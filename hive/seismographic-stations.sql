use earthquakesbasic;

drop table if exists seismographic_stations;

create table seismographic_stations
(
  station_code string,
  station_name string,
  country string,
  latitude double,
  longitude double,
  datacenter string
  )
row format delimited fields terminated by ',';

LOAD DATA INPATH '/user/dkagialis/demo/seismographic-stations.csv'

 OVERWRITE INTO TABLE seismographic_stations;