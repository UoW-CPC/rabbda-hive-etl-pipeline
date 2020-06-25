from datetime import datetime, timedelta

# open earthquakes file in read mode
fn = open('../data/earthquakes_closest_city_station.csv', 'r')
# open output files in write mode
fnOutput = open('../data/results.csv', 'w')
# read the content of the file line by line
cont = fn.readlines()
type(cont)
for line in range(0, len(cont)):
       lineText = cont[line]
       # create the seismograph link
       lineList = lineText.split(',')
       startDate = datetime.strptime(lineList[2], "%Y-%m-%d")
       endDate = startDate + timedelta(1)
       seismograph = "http://service.iris.edu/irisws/timeseries/1/query?net=IU&sta={}&loc=00&cha=BHZ&starttime=2005-01-01T00:00:00&endtime=2005-01-02T00:00:00&output=plot".format(lineList[12],startDate.strftime("%Y-%m-%dZ%H:%M:%S"),endDate.strftime("%Y-%m-%dZ%H:%M:%S"))
       print(seismograph)
       # create a new line by formatting the text of the current line
       newLineText = seismograph + "," + lineText
       # write the line in the new file
       fnOutput.write(newLineText)
# close the file
fnOutput.close()
fn.close()