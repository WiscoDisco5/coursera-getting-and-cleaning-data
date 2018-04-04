library(tidyverse)
library(lubridate)

# read in data if it isnt already loaded
if (!"power" %in% ls()) {
  source('./read_power_data.R')
}

##plot3: time series of sub metering by groups 1,2,3

png(filename = "plot4.png", width = 480, height = 480, units = 'px')

#plots: entered by ROW in 2X2 grid
par(mfrow=c(2,2))

#plot 1: active power by time
plot(power$DateTime,
     power$Global_active_power, 
     ylab = "Global Active Power (kilowatts)",
     xlab = NA,
     type = 'l')

#plot 2: voltage by time
plot(power$DateTime,
     power$Voltage, 
     ylab = "Voltage",
     xlab = 'datetime',
     type = 'l')

#plot 3: sub metering by time and colored by group
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
       col = c("black", "red", 'blue'),
       bty = 'n')

#plot 4
plot(power$DateTime,
     power$Global_reactive_power, 
     ylab = "Global_reactive_power",
     xlab = 'datetime',
     type = 'l')

#end
dev.off()
