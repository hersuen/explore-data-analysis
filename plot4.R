# Read the file in a dataframe
tabAll <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
# Convert the Date column in the correct format
tabAll[,1] <- as.Date(tabAll[,1], format= "%d/%m/%Y" )
#head(tabAll$Date)
# Select the required days
start <- as.Date("2007-02-01")
stop  <- as.Date("2007-02-02")
wt <- subset(tabAll, Date >= start & Date <= stop )
#head(wt)
# Convert the remaining columns
library(lubridate)
wt$Time <- strptime(wt$Time, format='%H:%M:%S')
year(wt$Time) <- year(wt$Date)
month(wt$Time) <- month(wt$Date)
mday(wt$Time) <- mday(wt$Date)
head(wt$Time)
cols = 3:9;    
wt[,cols] = apply(wt[,cols], 2, function(x) as.numeric(x));
#head(wt)
png(file = "plot4.png")
par(mfrow = c(2, 2)) 
with(wt, {
  plot(wt$Time, wt$Global_active_power, xlab = '', ylab = 'Global Active Power', type = 'l')
  plot(Time, Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
  plot(wt$Time, wt$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l', col='black')
  lines(wt$Time, wt$Sub_metering_2, col='red')
  lines(wt$Time, wt$Sub_metering_3, col='blue')
  legend("topright", col=c('black', 'red', 'blue'), lwd=c(1, 1, 1), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), box.lwd = 0, bg='transparent')
  plot(Time, Global_reactive_power, xlab = 'datetime', type = 'l')
})
dev.off()