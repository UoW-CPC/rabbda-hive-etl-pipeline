use earthquakesbasic;


drop table if exists seismograph_stations;

create table seismograph_stations
(
  station_code string,
  station_name string,
  country string,
  latitude double,
  longitude double,
  datacenter string
  )
row format delimited fields terminated by ',';

LOAD DATA INPATH '/user/admin/project/earthquakes-basic/earthquakes-etl/seismograph-stations.csv'

LOAD DATA INPATH '/user/dkagialis/project/earthquakes-basic/earthquakes-etl/seismograph-stations.csv'

 OVERWRITE INTO TABLE seismograph_stations;