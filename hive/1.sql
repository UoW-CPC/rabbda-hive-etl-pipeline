use earthquakesbasic;


drop table if exists earthquakes_full_dataset;

create table earthquakes_full_dataset
(
  year int,
  day date,
  time string,
  date_time string,
  latitude double,
  longitude double,
  depth double,
  mag double,
  magType string,
  nst string,
  gap string,
  dmin string,
  rms string,
  net string,
  id string,
  updated string,
  place string,
  type string,
  horizontalError string,
  depthError string,
  magError string,
  magNst string,
  status string,
  locationSource string,
  magSource string
  )
row format delimited fields terminated by ',';

LOAD DATA INPATH '/user/dkagialis/demo/earthquakes-final.csv' OVERWRITE INTO TABLE earthquakes_full_dataset;