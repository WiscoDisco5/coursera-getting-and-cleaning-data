## Getting and Cleaning Data Project
## by: John Goodwin

## attach packages

library(tidyverse)

## get data --------------------------------------------------------------------

#download file
url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url, destfile = "./UCI_HAR_Data.zip")

#unzip
unzip("./UCI_HAR_Data.zip", exdir = ".", overwrite = TRUE)

#clean up 
file.remove("./UCI_HAR_Data.zip")

## read in data
## test-------------------------------------------------------------------------
setwd("./UCI HAR Dataset/test/")

subject_test <- read_table("subject_test.txt", 
                      col_names = FALSE)

x_test <- read_table("X_test.txt",
                     col_names = FALSE)

y_test <- read_table("Y_test.txt",
                     col_names = FALSE)

## train------------------------------------------------------------------------
setwd("../train/")

subject_train <- read_table("subject_train.txt", 
                           col_names = FALSE)

x_train <- read_table("X_train.txt",
                     col_names = FALSE)

y_train <- read_table("Y_train.txt",
                     col_names = FALSE)

## labels and feature names-----------------------------------------------------
setwd("..")

# labels for activity codes
activity_labels <- read_table("activity_labels.txt",
                              col_names = FALSE)
colnames(activity_labels) <- c("activity_code", "activity")

# features
features <- read_table("features.txt",
                       col_names = FALSE) 

features <- features %>% 
  mutate(X1 = gsub(".* ", "", X1)) %>% ##remove number from name
  unlist %>% unname

## join everything together-----------------------------------------------------

# bind subject data
subject <- bind_rows(subject_train, subject_test)
colnames(subject) <- "subject"

# bind x data
x <- bind_rows(x_train, x_test) 
colnames(x) <- features

# bind activity labels and replace with activity labels 
y <- bind_rows(y_train, y_test)
colnames(y) <- "activity_code"

y <- y %>% left_join(activity_labels, by = "activity_code") %>% select(activity)

# bind it all together
uci_har <- bind_cols(subject, y, x)

## clean it all up -------------------------------------------------------------
rm(list = ls()[!ls() %in% "uci_har"])

## we only want subject, activity, and the mean and std fields
field_names <- colnames(uci_har)
features_keep <- which(grepl("mean\\(\\)",field_names) | grepl("std\\(\\)",field_names))

uci_har <- uci_har %>% select(subject, activity, features_keep)

## clean up the field names

colnames(uci_har) <- field_names %>% 
  .[features_keep] %>%
  sub("^t", "time", .) %>%
  sub("^f","freq", .) %>%
  sub("BodyBody", "Body", .) %>%
  gsub("-", "", .) %>%
  sub("mean\\(\\)", "Mean",.) %>%
  sub("std\\(\\)", "StdDev", .) %>%
  c("subject", "activity", .)

## summarised dataset ----------------------------------------------------------

uci_har_summarised <- uci_har %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean(., na.rm = TRUE))) 

## write to working directory---------------------------------------------------
setwd("..")

write_csv(uci_har, "./uci_har.csv")
write_csv(uci_har_summarised, "./uci_har_summarised.csv")

## clean up by deleting data folder and rm all but uci_har from workspace
rm(list=ls()[!ls() %in% "uci_har"])
unlink("./UCI HAR Dataset", recursive = TRUE)
