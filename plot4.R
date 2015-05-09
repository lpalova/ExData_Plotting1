## Load the dataset into R
data_all <- read.table("household_power_consumption.txt",sep=";",header=TRUE,
                       colClasses=c("character","character","character","character",
                                    "character","character","character","character","character"))

## Convert all dates into "Date" format
date_all <- as.Date(data_all$Date, "%d/%m/%Y")

## Define the two days that we use here 
day1 <- as.Date("2007-02-01")
day2 <- as.Date("2007-02-02")

## Subset only data for day1 and day2 and store the data in a data frame 'my_data'
my_data <- subset( data_all, date_all == day1 | date_all == day2 )

## Get the data on Global_active_power and store the data in a numeric vector 'power'
## Get the data on Sub_metering_1 _2 and _3 and store the data in numeric vectors 'sub_1', 'sub_2' and 'sub_3', respectively
## Get the data on Voltage and store the data in a numberic vector 'voltage'
## Get the data on Global_reactive_power and store the data in a numberic vector 'reactive'
## Get the data on a corresponding time in the POSIXct format and unclass so that the new vector 'time' is numeric
power <- as.numeric(my_data$Global_active_power)
sub_1 <- as.numeric(my_data$Sub_metering_1)
sub_2 <- as.numeric(my_data$Sub_metering_2)
sub_3 <- as.numeric(my_data$Sub_metering_3)
voltage <- as.numeric(my_data$Voltage)
reactive <- as.numeric(my_data$Global_reactive_power)
time <- unclass( as.POSIXct( strptime( paste(my_data$Date, my_data$Time), "%d/%m/%Y %H:%M:%S") ) )

## Create plot4:
## Similar to plot2 and plot3 commands..
## mfrow orders the four figures into one plot, mar changes the figure margins

png( filename = "plot4.png")
par(mfrow=c(2,2), mar=c(5,5,2,1))

#plot: topleft
plot(time, power, ylab = "Global Active Power", xlab="", xaxt="n", type="n")
lines(time, power)
axis(side=1, at=c(time[1], time[(length(time)/2)+1], time[length(time)]), labels=c("Thu","Fri","Sat"))

#plot: topright
plot(time, voltage, ylab = "Voltage", xlab="datetime", xaxt="n", type="n")
lines(time, voltage)
axis(side=1, at=c(time[1], time[(length(time)/2)+1], time[length(time)]), labels=c("Thu","Fri","Sat"))

#plot: bottomleft
plot(time, sub_1, ylim=c(0,38), yaxp=c(0,40,4), ylab = "Energy sub metering", xlab="", xaxt="n", type="n")
lines(time, sub_1, col="black")
lines(time, sub_2, col="red")
lines(time, sub_3, col="blue")
axis(side=1, at=c(time[1], time[(length(time)/2)+1], time[length(time)]), labels=c("Thu","Fri","Sat"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), 
       lty=c(1,1,1), bty="n")

#plot: bottomright
plot(time, reactive, ylab = "Global_reactive_power", xlab="datetime", xaxt="n", type="n")
lines(time, reactive)
axis(side=1, at=c(time[1], time[(length(time)/2)+1], time[length(time)]), labels=c("Thu","Fri","Sat"))

dev.off()