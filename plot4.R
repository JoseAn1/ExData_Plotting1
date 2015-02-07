##plot4.R

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

#Plot4: drawing four plots 
# creating a png file
png("plot4.png", height = 480, width = 480, bg = "transparent")
# defining the four plots
par(mfrow=c(2,2))

Sys.setlocale("LC_TIME", "English")
##subplot1
plot(data$Time,data$Global_active_power,type="n",xlab="",ylab="Global Active Power")
lines(data$Time,data$Global_active_power)
##subplot2
plot(data$Time,data$Voltage,type="n",ylab="Voltage",xlab="datetime")
lines(data$Time,data$Voltage)
##subplot3
plot(data$Time,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(data$Time,data$Sub_metering_1,col="black")
lines(data$Time,data$Sub_metering_2,col="red")
lines(data$Time,data$Sub_metering_3,col="blue")
legend("topright", legend = names(data[7:9]),col=c("black","red","blue"),lty=c(1,1,1),bty="n")
#subplot4
plot(data$Time,data$Global_reactive_power,type="n",ylab="Global_reactive_power",xlab="datetime")
lines(data$Time,data$Global_reactive_power)
# closing devices
dev.off()

 