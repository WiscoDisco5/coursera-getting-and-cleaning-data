library(tidyverse)
library(lubridate)

# read in data if it isnt already loaded
if (!"power" %in% ls()) {
  source('./read_power_data.R')
}

##plot2: time series of Global Active Power

png(filename = "plot2.png", width = 480, height = 480, units = 'px')

plot(power$DateTime,power$Global_active_power, 
     ylab = "Global Active Power (kilowatts)",
     xlab = NA,
     type = 'l')

dev.off()
