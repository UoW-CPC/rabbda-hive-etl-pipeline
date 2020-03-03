# rabbda-hive-etl-pipeline


## Introduction
This application comes along with a series of solutions that aim to demonstrate how Big Data can be used to create complex and real-life Big Data applications.

Specifically, with this application, we present a Hive ETL pipeline (Extract-Transform-Load) that joins data 
from different sources, and provides answers complex research questions and gain better insights. 

This is a step-by-step guide that includes all application phases:
 1. Data acquisition: Requesting the data from a Rest API.
 2. Data preparation: Pre-processing the data with Python.
 3. Data ingestion: upload the data to HDFS.
 4. ETL pipeline: Executing Hive queries.
 5. Output data: Downloading the data from HDFS and Post-processing the data with Python.
 6. Further analysis: 
    * Spark in memory data processing.
    * Complex research questions with Hive.
    * Data presentation with Tableau.

The data source for this demo is related to earthquakes, source: [USGS science for a changing world](https://earthquake.usgs.gov).

USGS provides a [Rest API](https://earthquake.usgs.gov/fdsnws/event/1/) which will be using to request earthquakes data.
Sample request in csv format: [earthquakes](https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime=2020-02-18T00:00:00.000Z&endtime=2020-02-19T00:00:00.000)
 
 __Keywords:__ Hadoop, HDFS, Hive, Rest API, Python, Spark, Bash, Tableau. 
 
 
 ## Getting started
 These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
 
 ### Download the repository
 The initial step is to download the repository in your Hadoop machine. To do so, run in terminal the following command:
 ```
 git clone https://github.com/UoW-CPC/rabbda-hive-etl-pipeline.git
 ```
 
 ### Running the application
 Having download the repository you can now run the application and perform all the 5 steps mentioned in the introduction paragraph.
 First move to the working directory by executing the command:
 ```
 cd rabbda-hive-etl-pipeline
 ``` 
 Now execute the command:
 ```
 ls
 ```
 There you can see seven folders:
 * _bash_, folder which contains the bash scripts used to used to download the earthquakes from the Rest API, step 1. 
 * _data_, data sets for cities and seismographic station.
 * _hive_, queries to run the ETL pipeline, step 3, and advanced query, step 5.
 * _python_, scripts to perform steps 2 and 4.
 * _sample-data_, 
 * _spark_, scripts to perform step 5.
 * _tableau_, to perform step 5.
 * _README.md_, project description file.
 
 
 
 #### 1. Data acquisition: Requesting the data from a Rest API.
 
Move the bash folder to download the earthquakes by executing the command:
 
 ```
 cd bash
 ```
 In this folder you can see the bash script that requests the data from the Rest API. To see its content run the following:
 
 ```
 cat downloadEarthquakesData.sh
 ```
  
 The script is develop to download earthquakes data for a single year, and you can also define minimum magnitude.
 In this demo we will download data for the year 2019 and minimum magnitude of 6. 
 The script is already configured, so we only need to run the following command:
 
 ```
 bash downloadEarthquakesData.sh
 ```
 To see the first rows of the data run the following command:
  ```
 head ../data/earthquakes.csv 
 ```
 Move back to the project folder:
 ```
 cd ..
 ```
 #### 2. Data preparation: Pre-processing the data with Python.
 
 As you can see the data contain multiple header rows, this is because every request returned also the headers.
 Therefore, it is required to clear those rows. We do so by executing a Python script.
 
 Move to the python folder:
 ```
 cd python
 ```
 and execute the following command:
 ```
 python ClearTitles.py
 ```
 
 No if you check the data folder, there are two new files:
 * _titles.csv_, file that contains the headers of the requests.
 * _earthquakes-no-titles.csv_, file that contains earthquakes data without the headers.
 
 Last step in the preparation phase is to split the earthquake datetime  column to more columns, like, year, date, and time.
 Again, we use a Python script.  
 
```
 python SplitDateTime.py
 ```
 
  No if you check the data folder, there is two new file:
  * _earthquakes-final.csv_, file that contains earthquakes data that will be using in the ETL pipeline
 
 Move again to the project folder:
 ```
 cd ..
 ```
 #### 3. Data ingestion: upload the data to HDFS.
 
 In this phase we simple have to upload the three data sets, earthquakes, cities, seismographic stations to HDFS. 
 
 ```
#Command: hdfs dfs -put /"your_local_dir_path/file" /"your_hdfs_dir_path" 
hdfs dfs -put ../data/earthquakes-final.csv /demo # put here your path
hdfs dfs -put ../data/cities.csv /demo # put here your path
hdfs dfs -put ../data/seismographic-stations.csv /demo # put here your path
 ```
 
 #### 4. ETL pipeline: Executing Hive queries.
 
 This is the most important part of the application, that import the data sets to hive and join them to create new data sets.
 
 Move the hive folder:
 ```
 cd hive
 ``` 
 and start executing the ETL pipeline:
 ```
 # 1. Create the database
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f create-db.sql
 # 2. Create table cities
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f cities.sql
 # 3. Create table seasmographic stations
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f seismographic-stations.sql
 # 4. create table earthquakes_full_dataset
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 1.sql
 # 4. create table earthquakes with columns: id, time, day, latitude, longitude, magnitude
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 2.sql
 # create table earthquakes_distance_to_all_cities with cross join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 3.sql
 # create table earthquakes_closest_city inner join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 4.sql
 # create table earthquakes_closest_city_discance_to_all_stations cross join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 5.sql
 # create table earthquakes_closest_city_station inner join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 6.sql
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 7.sql
 ```
 
 #### 5. Output data: Downloading the data from HDFS and Post-processing the data with Python.
 
 
 
 #### Run the Python application
 
 Having install the requirements you can now __run the python application__. 
 
 Move to the earthquakes folder:
 ```
 cd earthquakes
 ```
 and execute the earthquakes script:
 ```
 python earthquakes.py
 ```
 By default the script makes a requests every 10 minutes. As an alternative you can pass a parameter to change this value. Example:
  ```
 python earthquakes.py 2
 ```
 Now we have a request every 2 minutes.
 
 To see the results open a new terminal and move to the repository directory. There, you can see a new directory, _data_. If you move into this folder, there is a file called _earthquakes.csv_.
 
 To see its content run the following command:
   ```
 cat earthquakes.csv
 ```
 Alternatively, you can monitor file changes with the command:
 ```
 tail -F earthquakes.csv
 ```
 
 At this point, we have temporary stored the data in the local machine.
 
 #### Run the Flume Agent
  
 The next step is to upload those data to HDFS. To do so, we use the [Flume service](https://flume.apache.org/).
 Open a new terminal and move once again to the rabbda-earthquakes-realtime directory.
 
 There we have to edit the _flume-earthquakes-realtime.conf_ file.
 Specifically, you need to edit the  _eq.sources.r1.command_ and _eq.sinks.k1.hdfs.path_ to match your local environment.
 
 
 Example: 
 ```
 eq.sources.r1.command = tail -F /home/user/rabbda-earthquakes-realtime/data/earthquakes.csv
 eq.sinks.k1.hdfs.path = hdfs://NameNode.Domain.com:8020/user/UserName/flume/realtime
 ```
 Now is time to __start the Flume agent__ and upload the data to HDFS. Execute the command:
 ```
 flume-ng agent --name eq --conf-file flume-earthquakes-realtime.conf
 ```
 Having done this, Flume agent starts monitoring the _earthquakes.csv_ file for changes and uploads the data to HDFS.
 
 #### Verify the data in HDFS
 Finally, __go to Ambari Files View__ in the path specified previously and see the data sinking to HDFS in real-time.
 
 ## Architecture
<img width="732" alt="architecture" src="https://user-images.githubusercontent.com/32298274/75445139-bebad500-595c-11ea-830f-9850fa0e7dd0.png">




[Demo video](https://drive.google.com/open?id=1cVJDfO616nggClPJWdOQ2HOVEvEpF7tF)
