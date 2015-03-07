####### Get the data ####### 

dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

dataZipFileName <- "ElectricPowerConsumption.zip"
dataFileName <- "household_power_consumption.txt"

if(!file.exists(dataZipFileName))
{
    download.file(dataURL, dataZipFileName)
}

dataFile <- unz(dataZipFileName, dataFileName)

columnTypes <- c("character", "character", "numeric", "numeric","numeric", "numeric",
                 "numeric", "numeric","numeric" )

allData <- read.csv(dataFile, nrows = -1, header = TRUE, sep = ";", 
                    colClasses = columnTypes, na.strings = "?")

dateTimes <- strptime(paste(allData$Date, allData$Time),
                      "%d/%m/%Y %H:%M:%S")

allData <- cbind(allData,dateTimes)


filteredData <- allData[(allData$dateTimes > as.POSIXlt("2007-02-01")) &
                            (allData$dateTimes < as.POSIXlt("2007-02-03")) &
                            (!is.na(allData$dateTimes)),]

####### Draw plot 4.1 ####### 

png("plot4.png")

layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))

plot(filteredData$dateTimes, filteredData$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "")

####### Draw plot 4.2 ####### 

plot(filteredData$dateTimes, filteredData$Voltage, type = "l", 
     ylab = "Voltage", xlab = "datetime")

####### Draw plot 4.3 ####### 

plot(filteredData$dateTimes, filteredData$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")

lines(filteredData$dateTimes, filteredData$Sub_metering_2, col = "red")

lines(filteredData$dateTimes, filteredData$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n")

####### Draw plot 4.4 ####### 

plot(filteredData$dateTimes, filteredData$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")


dev.off()