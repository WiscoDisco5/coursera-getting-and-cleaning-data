##read and merge data

library(tidyverse)


subject_test <- read_table("./data/UCI HAR Dataset/test/subject_test.txt", 
                      col_names = FALSE,
                      col_types = "i")

x_test <- read_table("./data/UCI HAR Dataset/test/X_test.txt", 
                      col_names = FALSE)

y_test <- read_table("./data/UCI HAR Dataset/test/Y_test.txt", 
                           col_names = FALSE)

