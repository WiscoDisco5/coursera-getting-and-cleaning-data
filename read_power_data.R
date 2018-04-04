library(tidyverse)
library(lubridate)

#download and unzip data if its not in your working directory
if (!"household_power_consumption.txt" %in% list.files()) {
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "./household_power_consumption.zip")
  unzip("./household_power_consumption.zip")
  file.remove("./household_power_consumption.zip")

}

#read in data, modify date/time fields, and filter to dates we care about
power <- read_delim("household_power_consumption.txt", 
                    delim = ";", 
                    na= "?") 
  
power <- power %>% as_tibble %>%
  mutate(Date = dmy(Date)) %>% 
  filter(between(Date, ymd("2007-02-01"), ymd("2007-02-02"))) %>%
  mutate(DateTime = ymd_hms(paste(Date, Time)),
         Time = hms(Time)) 

#file.remove("household_power_consumption.txt") ##to remove text file from wd
