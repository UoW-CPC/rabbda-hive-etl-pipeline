#!/bin/bash

echo "Starting the earthquakes data downloading process"
touch ../data/earthquakes.csv
for value in {1..12}
do
  	let 'value1 = value+1'
	year=2019

	if [ "$value" = "12"  ]; then                                                                                                                                                                                                                                                                                                                           
          value1="$value"                                                                                                                                                                  
        fi 

	if [ "$value" = "1"  ]; then
  	  value="0$value"
	  value1="0$value1"
	fi
        if [ "$value" = "2"  ]; then                                                                                                                                                          
          value="0$value"  
          value1="0$value1"                                                                                                                                                                                                                                                                                                                                    
        fi
	if [ "$value" = "3"  ]; then                                                                                                                                                          
          value1="0$value1"                                                                                                                                                                   
          value="0$value"                                                                                                                                                                     
        fi
	if [ "$value" = "4"  ]; then                                                                                                                                                          
          value1="0$value1"                                                                                                                                                         
	  value="0$value"                                                                                                                                                                     
        fi
	if [ "$value" = "5"  ]; then                                                                                                                                                          
          value1="0$value1"                                                                                                                                                                   
          value="0$value"                                                                                                                                                                     
        fi
	if [ "$value" = "6"  ]; then                                                                                                                                                          
          value1="0$value1"                                                                                                                                                                   
          value="0$value"                                                                                                                                                                     
        fi
	if [ "$value" = "7"  ]; then                                                                                                                                                          
          value1="0$value1"                                                                                                                                                                   
          value="0$value"                                                                                                                                                                     
        fi
	if [ "$value" = "8"  ]; then                                                                                                                                                          
          value1="0$value1"                                                                                                                                                                   
          value="0$value"                                                                                                                                                                     
        fi
	if [ "$value" = "9"  ]; then                                                                                                                                                          
          value="0$value"                                                                                                                                                                     
        fi
	                                                                                                                                                                                                                                                                                                       
        value2="$value1"

	for split in {1..2}
         do
	 daystart=15
	 dayend=01
    	 value1="$value2"
	 if [ "$split" = "1" ]; then
           daystart=01
	   dayend=15
	   value1="$value"
	 fi                                                                                                           
	
         if [ "$split" = "2" ]; then
	   if [ "$value" = "12" ]; then
		dayend=31
           fi
         fi
	                  
	echo "year --> $year"
	echo "month --> $value"
	echo "dayStart -> $daystart"
	echo "dayEnd -> $dayend"
	echo "nextMonth -> $value1"
     
	echo "https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime=$year-$value-$daystart&endtime=$year-$value1-$dayend&minmagnitude=6"
	
	a="earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime=$year-$value-$daystart&endtime=$year-$value1-$dayend&minmagnitude=6" 
	wget -O $value$daystart $a
	sleep 2s

	cat $value$daystart >> ../data/earthquakes.csv
	echo "FINISHED DOWNLOAD PARTIAL the data is saved in /data/earthquakes.csv"
	sleep 1s
	rm $value$daystart
	done

done
echo "FINISHED DOWNLOAD all the data is saved in /data/earthquakes.csv"