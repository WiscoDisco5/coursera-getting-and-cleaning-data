## Getting and Cleaning Data Project
## by: John Goodwin

## attach packages

library(tidyverse)

## get data ----------------------------

#download file
url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url, destfile = "./Data/UCI_HAR_Data.zip")

#unzip
unzip("./Data/UCI_HAR_Data.zip", exdir = "./Data", overwrite = TRUE)

#clean up 
file.remove("./Data/UCI_HAR_Data.zip")

## read in data ------------------------------------
## test
setwd("./Data/UCI HAR Dataset/test/")

subject_test <- read_table("subject_test.txt", 
                      col_names = FALSE)

x_test <- read_table("X_test.txt",
                     col_names = FALSE)

y_test <- read_table("Y_test.txt",
                     col_names = FALSE)

## train
setwd("../train/")

subject_train <- read_table("subject_train.txt", 
                           col_names = FALSE)

x_train <- read_table("X_train.txt",
                     col_names = FALSE)

y_train <- read_table("Y_train.txt",
                     col_names = FALSE)

## metadata
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

## clean field names and mash data together! -------------------------

# get subject field
subject <- bind_rows(subject_train, subject_test)
colnames(subject) <- "subject"

# get x data: only keep mean() and std()
x <- bind_rows(x_train, x_test) 

keep_vars <- grepl("mean\\(\\)", features) | grepl("std\\(\\)", features)
features <- features[keep_vars]

features %>% 
  gsub("t", "time_", .) %>%
  gsub("f","freq_", .)

x <- x[,keep_vars]

# get y data: replace codes with meaningful values
y <- bind_rows(y_train, y_test)
colnames(y) <- "activity_code"

y <- left_join(y,activity_labels, by = "activity_code") %>% select(-activity_code)

# bind together
uci_har <- bind_cols(subject, y, x)

colnames(uci_har) %>% tibble %>% print(n=1000)

## remove unnecessary fields and clean up feature names ---------------



## clean up folders
setwd("../..")
unlink("./Data/UCI HAR Dataset", recursive = TRUE)
