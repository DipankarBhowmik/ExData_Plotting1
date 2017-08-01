## Setting the path
setwd("E:/coussera/Exploratory Data Analysis/Week1")
## Downloading and unzipping the file
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "household_power_consumption.zip"
householdFile <- "household_power_consumption.txt"

if (!file.exists(householdFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = T)
}

t <- read.table("householdFile", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")
  
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
t <- t[complete.cases(t),]

## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Remove Date and Time column
t <- t[ ,!(names(t) %in% c("Date","Time"))]
  
## Add DateTime column
t <- cbind(dateTime, t)
  
## Format dateTime Column
t$dateTime <- as.POSIXct(dateTime)


##PLOT 1

  ## Create the histogram
  hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
  dev.copy(png,"plot1.png", width=480, height=480)
  dev.off()