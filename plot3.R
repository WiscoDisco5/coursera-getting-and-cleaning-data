library(tidyverse)
library(lubridate)

# read in data if it isnt already loaded
if (!"power" %in% ls()) {
  source('./read_power_data.R')
}

##plot3: time series of sub metering by groups 1,2,3

png(filename = "plot3.png", width = 480, height = 480, units = 'px')

plot(power$DateTime,
     power$Sub_metering_1, 
     ylab = "Energy sub metering",
     xlab = NA,
     type = 'l')

lines(power$DateTime,
      power$Sub_metering_2,
      col = 'red')

lines(power$DateTime,
      power$Sub_metering_3,
      col = 'blue')

legend('topright',
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty =1,
       col = c("black", "red", 'blue'))

dev.off()
