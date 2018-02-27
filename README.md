# Getting And Cleaning Data Course Project
## Coursera Course:  Getting and Cleaning Data

Assignment Submission Files:
  - [run_analysis.R](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/run_analysis.R)
  - [README.md](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/README.md)
  - [CookBook.md](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/CodeBook.md)
  - [tidy_data.txt](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/tidy_data.txt)
## Instructions for: "run_analysis.R"

1.  DOWNLOAD the data set .zip file from the URL listed below:

      [URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

2.  Unzip the file into YOUR DIRECTORY whereas a folder named, "UCI HAR Dataset" is listed inside of YOUR DIRECTORY.

3.  Load RStudio and set your working directory, "setwd('YOUR DIRECTORY/UCI HAR Dataset').  **It is imperative that the Working Directory ends with "UCI HAR Dataset" folder as the last in the character string for the Script to work.

4.  Load the R script in RStudio using: > source("run_analysis.R")

5.  Run the R script in RStudio using:  > run_analysis()
      After the execution of the function has finished, you will see a spreadsheet-like Data Viewer that reveals the results with the newest outputs available.
      
## Explanation of [run_analysis.R](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/run_analysis.R)

"run_analysis.R" is a script written to demonstrate my ability to collect, work with, and clean a data set.  There were 5 instructions for utilizing the raw data:
1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and         each subject.
    
There were a number of functions written so as to do this and this 'follow-along script' below hopes to walk you through the process:
### BEGINNING:
run_analysis <- function() {
        
        setwd("C:/Users/geo/Desktop/Jeff/Coursera/Getting_and_Cleaning_Data/week4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
        getwd()        
        library(data.table)
        library(dplyr)
        library(reshape2)
#### 1: Merge the subject, training and the test sets to create one data set:
        sub_test <- read.table("test/subject_test.txt", col.names=c("subject"))         #### Read the Subject test data ##
        sub_train <- read.table("train/subject_train.txt", col.names=c("subject"))      #### Read the Subject train data ##
        sub_merge <-rbind(sub_test, sub_train)                                          #### Creation of Merged Subject Dataset
        ##For reference, check by: 
        ##str(sub_merge)
        xfile_test <- read.table("test/X_test.txt")                                     #### Read the X_test data
        xfile_train <- read.table("train/X_train.txt")                                  #### Read the X_train data ##
        xfile_merge <- rbind(xfile_test, xfile_train)                                   #### Creation of Merged Xfile Dataset
        ####For reference, check by: 
        ####str(xfile_merge)
        yfile_test <- read.table("test/y_test.txt", col.names=c("activityId"))          #### Read the y_test data ##
        yfile_train <- read.table("train/y_train.txt", col.names=c("activityId"))       #### Read the y_train data ##
        yfile_merge <- rbind(yfile_test, yfile_train)                                   #### Creation of Merged Yfile Dataset

##For reference, check by: 
        ##str(yfile_merge)

#### Feature Lookup:
        features <- read.table("features.txt", col.names=c("featureId", "featureName")) #### Creation of the features object by reading the features.txt file and passing the col.names argument.

#### 2- Extracts only the measurements on the 'mean' and 'standard deviation' for each measurement: 
        meas_msd <- grep("(mean|std)\\(", features$featureName)                         #### Creation of the meas_msd argument which will extract only the mean and standard deviation on each measurement taken which is listed via the featureName of the features object.
        names(xfile_merge) <- features[,2]                                              #### This names the merged xfile dataset by the featureName Column.
        mean_sd <- xfile_merge[, meas_msd]                                              #### Creation of the mean_sd argument which passes the meas_msd argument throught the merged xfile dataset.
        ## For Reference, Check by:
        ## >str(mean_sd)
#### 3- Use Descriptive Activity names to name the activities in the data set: 
        activities <- read.table("activity_labels.txt",col.names = c("activityId",      #### Creation of the activities object by reading the "activity_labels.txt" file and passing the col.names argument. 
        "activityName"))
        activities[, 2] = gsub("_", "", as.character(activities[, 2]))                  #### Creation of activites argument that is defined by the activityName Column which is equal to substitution of the activityName to any Row that has an "_" or "" in its name.
        yfile_merge [,1] = activities[yfile_merge[,1], 2]                               #### This passes the activities argument so as to add the Activity names to the merged yfile dataset.
        names(yfile_merge) <- "activityName"                                            #### This names the column of activityName to the merged yfile dataset.
#### 4- Appropiately labels the data set with descriptive 'variable' names: 
        named_dataset <- cbind(sub_merge, yfile_merge, mean_sd)                         ####  This creates a final dataset by column binding the subect and yfile datasets and passes the mean_sd argument through both sets.
        ##For Reference, Check by:
        ## >str(named_dataset)
        names(named_dataset)[2] <- paste("activityName")                                #### This concatenates the final dataset and places activityName as a label to the second column of the dataset.
        names(named_dataset) <- gsub("\\(|\\)", "", names(named_dataset))               #### gsub replaces any \\ with no_space(""") in the final dataset
        write.table(named_dataset, "tidy_data.txt", row.names = FALSE)                  #### This creates the "tidy_data.txt" file  (that is part of the files uploaded into github.com) and writes it as a table without the row names.
        
#### 5- From the tidy data set in step 4, create a second, independant tidy Data set with the average of each variable for each activity and each subject. 
        ind_tidy_data <- melt(named_dataset, id = c("subject", "activityName"))         #### This creates the ind_tidy_data set as an argument which 'melt' is used to make a molten data frame out of the named_dataset which has the argument id as concatenation of subject and activityName.
        mean_ind_tidy_data <- dcast(ind_tidy_data, subject+activityName ~ variable,     #### This creates the "mean_ind_tidy_data" data frame using dcast which pulls the ind_tidy_data set and passes the mean argument through the formula of subject+activityName and returns a very nice Data Frame.
        mean)
        View(mean_ind_tidy_data)                                                        #### Invoke a Data Viewer so as to see results 
        write.csv(mean_ind_tidy_data, file = "tidy_data.txt", row.names = FALSE)        #### This writes the results into the file that was made earlier, "tidy_data.txt", without the row names.
}

### END

## Explanation of [Code Book](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/CodeBook.md)

The CodeBook file is a detailed instructional list that walks you through the process of how I completeded the assignment through the use of Rstudio and its accompanying Syntax.  

## Explanation of [tidy_data](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/tidy_data.txt)

The tidy_data.txt file is the output generated by the run_analysis.R script in RStudio.  It is a compiled Table, with characteres seperated by "," that gives the average, or "mean" of the value for a specified Activity.
