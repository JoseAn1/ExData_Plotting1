##plot1.R

## download, and unzip the raw data in case doesn't exists in the working folder 

filename<-"household_power_consumption.txt"
localname="household_power_consumption.zip"
path="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(filename)) {
  download.file(path,destfile=localname)
  unzip(localname)
}

## loading data
data<-read.table(filename,sep=";",
                 header=TRUE,
                 colClasses=rep("character",9),
                 na.strings="?")

## selecting data 

data<-data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

##adjusting variable classes

data$Time<-paste(data$Date,data$Time)
data$Date<-as.Date(data$Date,"%d/%m/%Y")
data$Time<-strptime(data$Time,"%d/%m/%Y %H:%M:%S")
data[3:9] = apply(data[3:9],2,as.numeric)

##Plot1: drawing Histogram with Global_active_power

# creating a png file
png("plot1.png", height = 480, width = 480, bg = "transparent")
# drawing the plot 
hist(data$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")
# closing devices
dev.off()

