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


####### Draw plot 2 ####### 

png("plot2.png")

plot(filteredData$dateTimes, filteredData$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()