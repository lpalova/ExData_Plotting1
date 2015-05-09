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
power <- as.numeric(my_data$Global_active_power)

## Create plot1 (histogram)
png( filename = "plot1.png")
hist(power, xlab="Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()