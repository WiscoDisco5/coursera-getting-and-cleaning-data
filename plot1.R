library(tidyverse)
library(lubridate)

# read in data if it isnt already loaded
if (!"power" %in% ls()) {
  source('./read_power_data.R')
}

##plot1: red histogram with global active power

png(filename = "plot1.png", width = 480, height = 480, units = 'px')

plot(hist(power$Global_active_power), 
     col = 'red', 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
