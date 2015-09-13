## read the data file. 
## NOTE: the code assumes that you have the "exdata-data-household_power_consumption" extracted in the current working directory.
dataFilePath <- file.path(getwd(), "exdata-data-household_power_consumption", "household_power_consumption.txt")
epc <- read.csv(dataFilePath, sep = ";", na.strings = c("?", "NA"))

## format the data and create new data columns which are needed
epc$DateTime <- paste(epc$Date, " ", epc$Time)
epc$Date <- as.Date(epc$Date, "%d/%m/%Y")
epc$DateTime <- strptime(epc$DateTime, "%d/%m/%Y %H:%M:%S")

## filter only the given data range
epc <- epc[epc$Date >= as.Date("2007-02-01") & epc$Date <= as.Date("2007-02-02") ,]

## open a "png" device
png(filename = "plot4.png", width = 480, height = 480)

## set layout for the plots
par(mfrow = c(2, 2))

## create the plot
with(epc, {
	plot(DateTime, Global_active_power, type = "n", xlab = NA, ylab = "Global Active Power (kilowatts)")
	lines(DateTime, Global_active_power)
})
with(epc, {
	plot(DateTime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
	lines(DateTime, Voltage)
})
with(epc, {
	plot(DateTime, Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering")
	lines(DateTime, Sub_metering_1, col = "black")
	lines(DateTime, Sub_metering_2, col = "red")
	lines(DateTime, Sub_metering_3, col = "blue")
	legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2" , "Sub_metering_3"), lwd = 2, lty= 1)
})
with(epc, {
	plot(DateTime, Global_reactive_power, type = "n", xlab = "datetime")
	lines(DateTime, Global_reactive_power)
})

## close the device
dev.off()

## the plot will now be created at your working directory