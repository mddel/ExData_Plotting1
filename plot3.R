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


####### Draw plot 3 ####### 

png("plot3.png")

plot(filteredData$dateTimes, filteredData$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")

lines(filteredData$dateTimes, filteredData$Sub_metering_2, col = "red")

lines(filteredData$dateTimes, filteredData$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

dev.off()