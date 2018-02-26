## The Downloadable Content for this project can be found at:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


run_analysis <- function() {
## Please set your working directory(setwd()) if already not set to directory "/UCI Har Dataset/" that was
## extracted from dataset.zip in above stage SEE Line "9" Below:
        
        setwd("C:/Users/geo/Desktop/Jeff/Coursera/Getting_and_Cleaning_Data/week4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
        getwd()        
        library(data.table)
        library(dplyr)
        library(reshape2)
## 1:  Merge the subject, training and the test sets to create one data set:
        sub_test <- read.table("test/subject_test.txt", col.names=c("subject"))         ## Read the Subject test data ##
        sub_train <- read.table("train/subject_train.txt", col.names=c("subject"))      ## Read the Subject train data ##
        sub_merge <-rbind(sub_test, sub_train)                                          ## Creation of Merged Subject Dataset
        ##For reference, check by: 
        ##str(sub_merge)
        xfile_test <- read.table("test/X_test.txt")                                     ## Read the X_test data ##
        xfile_train <- read.table("train/X_train.txt")                                  ## Read the X_train data ##
        xfile_merge <- rbind(xfile_test, xfile_train)                                   ## Creation of Merged Xfile Dataset
        ##For reference, check by: 
        ##str(xfile_merge)
        yfile_test <- read.table("test/y_test.txt", col.names=c("activityId"))          ## Read the y_test data ##
        yfile_train <- read.table("train/y_train.txt", col.names=c("activityId"))       ## Read the y_train data ##
        yfile_merge <- rbind(yfile_test, yfile_train)                                   ## Creation of Merged Yfile Dataset
        ##For reference, check by: 
        ##str(yfile_merge)

## Feature Lookup:
        features <- read.table("features.txt", col.names=c("featureId", "featureName"))

## 2- Extracts only the measurements on the 'mean' and 'standard deviation' for each measurement: ##
        meas_msd <- grep("(mean|std)\\(", features$featureName)                        
        names(xfile_merge) <- features[,2]
        mean_sd <- xfile_merge[, meas_msd]
        ## For Reference, Check by:
        ## >str(mean_sd)
## 3- Use Descriptive Activity names to name the activities in the data set: ##
        activities <- read.table("activity_labels.txt",col.names = c("activityId", "activityName"))
        activities[, 2] = gsub("_", "", as.character(activities[, 2]))
        yfile_merge [,1] = activities[yfile_merge[,1], 2]
        names(yfile_merge) <- "activityName"
## 4- Appropiately labels the data set with descriptive 'variable' names: ##
        named_dataset <- cbind(sub_merge, yfile_merge, mean_sd)
        ##For Reference, Check by:
        ## >str(named_dataset)
        names(named_dataset)[2] <- paste("activityName")
        names(named_dataset) <- gsub("\\(|\\)", "", names(named_dataset))
        write.table(named_dataset, "tidy_data.txt", row.names = FALSE)
        
## 5- From the tidy data set in step 4, create a second, independant tidy
##    Data set with the average of each variable for each activity and each subject. ##
        ind_tidy_data <- melt(named_dataset, id = c("subject", "activityName"))
        mean_ind_tidy_data <- dcast(ind_tidy_data, subject+activityName ~ variable, mean)
        View(mean_ind_tidy_data)                                                        ##Invoke a Data Viewer so as to see results
        write.csv(mean_ind_tidy_data, file = "tidy_data.txt", row.names = FALSE)
}

