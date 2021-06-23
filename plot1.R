## Load Libraries 
library(ggplot2)
library(lubridate)

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
names(subset_power_comp)

global_active_power_num <- as.numeric(subset_power_comp$Global_active_power)

# Make Plot
hist(global_active_power_num,
     xlab = "Global Active Power (kilowatts)",
     col  = "red",
     main = "Global Active Power")

# Save Plot

dev.copy(png, "plot1.png",
         width  = 480,
         height = 480)

dev.off()
