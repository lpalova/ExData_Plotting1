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
## Get the data on a corresponding time in the POSIXct format and unclass so that the new vector 'time' is numeric
power <- as.numeric(my_data$Global_active_power)
time <- unclass( as.POSIXct( strptime( paste(my_data$Date, my_data$Time), "%d/%m/%Y %H:%M:%S") ) )

## Create plot2:
## Notes: 'plot' function does not plot the data (type="n") neither the x-axis (xaxt="n")
## Annotate the data using 'lines' function that plots lines connecting (time,power) values and
## 'axis' function for the x-axis (side=1) that shows tick marks for times corresponding to 
## Thursday (1st time value), Friday (middle time value) and Saturday (last time value)
## and add labels to the tick marks "Thu", "Fri" and "Sat", respectively
png( filename = "plot2.png")
plot(time, power, ylab = "Global Active Power (kilowatts)", xlab="", xaxt="n", type="n")
lines(time, power)
axis(side=1, at=c(time[1], time[(length(time)/2)+1], time[length(time)]), labels=c("Thu","Fri","Sat"))
dev.off()