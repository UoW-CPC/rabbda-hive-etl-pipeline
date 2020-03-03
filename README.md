# rabbda-hive-etl-pipeline


## Introduction
This application comes along with a series of solutions that aim to demonstrate how Big Data can be used to create complex and real-life Big Data applications.

Specifically, with this application, we present a Hive ETL pipeline (Extract-Transform-Load) that joins data 
from different sources, and allows to answer complex research questions and gain better insights. 

This is a step-by-step guide that includes all application phases:
 1. Data acquisition: Requesting the data from a Rest API.
 2. Data preparation: Pre-processing the data with Python.
 3. ETL pipeline: Executing Hive queries.
 4. Output data: Post-processing the data with Python.
 5. Further analysis: 
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
 
 Then 
 
 
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
