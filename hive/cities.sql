use earthquakesbasic;

drop table if exists cities;

create table cities
(
  city string,
  city_ascii string,
  lat double,
  lng double,
  country string,
  iso2 string,
  iso3 string,
  admin_name string,
  capital string,
  population int,
  id string
  )
row format delimited fields terminated by ',';

LOAD DATA INPATH '/user/dkagialis/demo/cities.csv' OVERWRITE INTO TABLE cities;