library(curl)
library(data.table)

## File location
filename = "household_power_consumption.zip"
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


# Check if the data file exists, if not then download it
if (!file.exists("./household_power_consumption.txt")) {
        download.file(fileURL, filename, method="curl")
        unzip(filename)
        file.remove(zip.file)
}

## Read full file
dataAll = fread("household_power_consumption.txt",sep = ";", header = TRUE, na.strings = "?", colClasses = rep("character",9))

## Subset the data
dataAll$Date = as.Date(dataAll$Date, format = "%d/%m/%Y")
data = dataAll[dataAll$Date >= as.Date("2007-02-01") & dataAll$Date <= as.Date("2007-02-02"),]

# Convert Global_active_power to numeric data type
data$Global_active_power = as.numeric(data$Global_active_power)


## Plot data
hist(data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
png("plot1.png", width=480, height=480)
dev.off()