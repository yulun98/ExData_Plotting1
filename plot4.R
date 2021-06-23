## Load Libraries 
library(ggplot2)
library(lubridate)
library(dplyr)

## Load Data 
## Create data directory

if(!dir.exists("data")) { dir.create("data") }

## Download and unzip data file

file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
  download.file(file.url, file.path)
  unzip(file.path, exdir = "data")
}

## Load data

power_comp <- read.table("./data/household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
summary(power_comp)
head(power_comp, n=5)


## Data from the dates 2007-02-01 and 2007-02-02
#make subset
subset_power_comp <- power_comp[power_comp$Date %in% c("1/2/2007","2/2/2007"),]
head(subset_power_comp, n=5)

subset_power_comp$DateTime <- strptime(paste(subset_power_comp$Date, subset_power_comp$Time), format="%d/%m/%Y %H:%M:%S")
head(subset_power_comp, n=5)

subset_power_comp$Sub_metering_1 <- as.numeric(subset_power_comp$Sub_metering_1)
subset_power_comp$Sub_metering_2 <- as.numeric(subset_power_comp$Sub_metering_2)
subset_power_comp$Sub_metering_3 <- as.numeric(subset_power_comp$Sub_metering_3)
subset_power_comp$Global_active_power<- as.numeric(subset_power_comp$Global_active_power)
subset_power_comp$Global_reactive_power<- as.numeric(subset_power_comp$Global_reactive_power)
subset_power_comp$Voltage <- as.numeric(subset_power_comp$Voltage)
head(subset_power_comp)
# Make Plot
par(mfrow=c(2,2), mar=c(5,5,1,1))
#Plot 1
plot(x = subset_power_comp[, "DateTime"]
     , y = subset_power_comp[, "Global_active_power"]
     , type="l", xlab="", ylab="Global Active Power")
#Plot 2
plot(x = subset_power_comp[, "DateTime"]
     , y = subset_power_comp[, "Voltage"]
     , type="l", xlab="datetime", ylab="Voltage")
#Plot 3
plot(x = subset_power_comp[, "DateTime"]
     , y = subset_power_comp[, "Sub_metering_1"]
     , type="l", xlab="", ylab="Energy sub metering")
lines(x = subset_power_comp[, "DateTime"]
      , y = subset_power_comp[, "Sub_metering_2"]
      , type="l", col="red")
lines(x = subset_power_comp[, "DateTime"]
      , y = subset_power_comp[, "Sub_metering_3"]
      , type="l", col="blue")

legend("topright",
       col = c("black",
               "red",
               "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty = 1, lwd=2.5, cex=0.1)
#Plot 4
plot(x = subset_power_comp[, "DateTime"]
     , y = subset_power_comp[, "Global_reactive_power"]
     , type="l", xlab="datetime", ylab="Global_reactive_power")

# Save Plot

dev.copy(png, "plot4.png",
         width  = 480,
         height = 480)

dev.off()
