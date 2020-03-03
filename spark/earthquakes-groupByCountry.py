from pyspark.sql import SparkSession
from pyspark.sql import Row

import collections

# Create a SparkSession 
spark = SparkSession.builder.appName("SparkSQL").getOrCreate()

def mapper(line):
    fields = line.split(',')
    return Row(place=str(fields[9].encode("utf-8")))

lines = spark.sparkContext.textFile
("hdfs:///user/admin/project/earthquakes-basic/earthquakes-etl/results/ETL-process-earthquakes-final.csv")
earthquakes = lines.map(mapper)

# Infer the schema, and register the DataFrame as a table.
schemaEarthquakes = spark.createDataFrame(earthquakes).cache()
schemaEarthquakes.createOrReplaceTempView("countries")

# SQL can be run over DataFrames that have been registered as a table.
countriesDF = spark.sql("SELECT * FROM countries")

# The results of SQL queries are RDDs and support all the normal RDD operations.
for country in countriesDF.collect():
  print(country)

# We can also use functions instead of SQL queries:
schemaEarthquakes.groupBy("place").count().orderBy("place").show(1000,False)

spark.stop()
