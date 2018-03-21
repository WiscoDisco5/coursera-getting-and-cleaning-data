# coursera-getting-and-cleaning-data

This repo is the final project for the Getting and Cleaning Data coursera course. Running read_uci_har.R will create two files (uci_har.csv and uci_har_summarised.csv) in your working directory. The uci_har.csv file contains an abbreviated version of the data from [the University of California-Irvine's Human Activity Recognition database](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The uci_har_summarised.csv contains a summarised version of the dataset. It gives the average value of each feature grouped by the subject and activity fields. The R file for this project depends on the tidyverse package.

The resulting datasets can be reproduced in your working directory by running read_uci_har.R. This file does the following:

1. Downloads the zipped data from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzips the data in your working directory.
2. Reads in the subject ID, Y value (activity), and X values (features) for both the training and testing data.
3. Reads in the feature names and a table for translating the activity codes into meaningful values.
4. After replacing the activity codes with meaningful values, the data is all bound together.
5. The dataset is limited to values of interest: subject, actvity and the features containing the mean and standard deviations.
6. The column names are cleaned up by removing special characters and generally making variable names more clear.
7. A summarised dataset is created. This dataset has grouped means by subject and activity.
8. Datasets are saved to your working directory. Workspace and working directory are cleared.