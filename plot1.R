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
# Convert the remaining columns (the Time column is not used here so it will be ignored)
cols = 3:9;    
wt[,cols] = apply(wt[,cols], 2, function(x) as.numeric(x));
#head(wt)
png(file = "plot1.png")
hist(wt$Global_active_power, col=2, xlab='Global Active Power (kilowatts)', main='Global Active Power')
dev.off()