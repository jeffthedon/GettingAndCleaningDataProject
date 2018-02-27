# Code Book
  This code book includes information about the source data collected from this [Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), the transformations performed and some of the syntax needed after collecting the data to execute a tidy dataset through the use of [Rstudio](https://www.rstudio.com/products/rstudio/download/), as well as some information about the variables of the resulting tidy data set.
  
# Study Design
  The Source Data for this project was collected from the [HCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  It was used to complete a course from [Coursera](https://www.coursera.org/specializations/jhu-data-science) entitled "Getting and Cleaning Data" which was instructed by Professor Jeffrey Leek, PhD with some collaberation from Professor Robert Peng, PhD.
  
  The assignment utilized the aforementioned dataset whilst working with the data to compile a truly compiled, easy to read, and structured [tidy dataset] which represented the source data.  The assignment had 5 listed criteria that needed to be achieved:
  1. *Merges the training and the test sets to create one data set.
  2. **Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. ***Uses descriptive activity names to name the activities in the data set
  4. ****Appropriately labels the data set with descriptive variable names. 
  5. *****From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  The transformation from the Raw Data to the Tidy Data can be seen by following the List of Operations shown below as well as the accompanying notes and explanations offered in the [Readme.md](https://github.com/jeffthedon/GettingAndCleaningDataProject/blob/master/README.md) whilst utilizing RStudio:)
  
## List of Operations
  1. Download the Raw Data Zip File. 
  2. Extracted the files into Home Directory of:  "My Directory/ UCI HAR Dataset".
  3. Open RStudio. 
  4. Created a new script and named it, "run_anlysis.R".
  5. Set working directory using the setwd("My Directory/ UCI HAR Dataset".
  6. Use 'library' to install the packages: data.table, dplyr, and reshape2.
## * Merges the training and the test sets to create one data set.
  7. Merged the "Subject", "Test", and "Train" files using the comand "rbind".
  8. Look up the "features" file by using the command "read.table" and listed them by the "col.names" argument.
## ** Extracts only the measurements on the mean and standard deviation for each measurement.  
  9. Creat a function (meas_msd) which utilized the "grep" command to extract the 'mean' and 'standard deviation of each observation that had a "featureName".
## *** Uses descriptive activity names to name the activities in the data set.
  10. Use the "names" function to set the names of the merged "xfile_merge" dataset by the "featureName" column.
  11. Pass the "meas_msd" function through "xfile_merged" dataset and named the object "mean_sd".
  12. Create an object named "activities" using the "read.table" function on the "activity_labels.txt, and set the column names using a concatenation of both "activityId" and "activityName".
## **** Appropriately labels the data set with descriptive variable names.
  13. Then, to clean up the Activity Names, use the "gsub" function which substitutes and activites with "//, and basically deleted the slashes, by using the argument, "", and then listed them using "as.character" to the "activityName" to the object named "activities".
  14. Pass the "activities" object through the "yfile_merge" data set.
  15. Name the column name of the "yfile_merge" dataset to the corresponding "activityName" using the "names" function.
  16. To Appropiately label the dataset, create "named_dataset" using the "cbind" function and grabbing the columns from "sub_merge" and "yfile_merge" datasets and passing the "mean_std" function through the datasets.
  17. Name the columns in the "named_dataset" using the "names" function by using "paste" to call "activityName" and 'pastes' it to the second[2] column of the dataset.
  18. Clean up the columns of the "named_dataset" using the "gsub" function to once again delete, the "//" by replacing them with "".
## ***** From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  19. Create "tidy_data.txt" with "row.names = FALSE" using the write.table function.
  20. Create an "ind_tidy_data" object through using the "melt" function of the "named_dataset" where the 'id' is equal to a concatenation of the "subject" and "activityName".
  21. Create the "mean_ind_tidy_data" object where using the "dcast" function on the "ind_tidy_data" object, where the "subject and activity name" columns has a 'variable" of mean passed through so at to get the average.
  22. Use the "View" function on "mean_ind_tidy_data" to bring up a Data Viewer that shows the above performed function in a spreadsheet style image in Rstudio.
  23. Use "write.csv" function to save the "mean_ind_tidy_data" into the file that we created in "Step 19 above---tidy_data.txt" without using "row.names.
  ### PLEASE refer to [run_analysis.R]() for detailed implementation code that shows the aformentioned steps.


# OUTPUT Data Details of [tidy_data.txt]()
subjectId: Numbered Variables, 1 to 30; each representing a single participant in the study.
activity: the activity that the participant was doing at the time of the measurement
## List of Activities:
  1. WALKING 
  2. WALKING_UPSTAIRS 
  3. WALKING_DOWNSTAIRS 
  4. SITTING 
  5. STANDING 
  6. LAYING

## Column Names with Mean and Standard Deviation Variables
- tBodyAcc-mean-X
- tBodyAcc-mean-Y
- tBodyAcc-mean-Z
- tBodyAcc-std-X
- tBodyAcc-std-Y
- tBodyAcc-std-Z
- tGravityAcc-mean-X
- tGravityAcc-mean-Y
- tGravityAcc-mean-Z
- tGravityAcc-std-X
- tGravityAcc-std-Y
- tGravityAcc-std-Z
- tBodyAccJerk-mean-X
- tBodyAccJerk-mean-Y
- tBodyAccJerk-mean-Z
- tBodyAccJerk-std-X
- tBodyAccJerk-std-Y
- tBodyAccJerk-std-Z
- tBodyGyro-mean-X
- tBodyGyro-mean-Y
- tBodyGyro-mean-Z
- tBodyGyro-std-X
- tBodyGyro-std-Y
- tBodyGyro-std-Z
- tBodyGyroJerk-mean-X
- tBodyGyroJerk-mean-Y
- tBodyGyroJerk-mean-Z
- tBodyGyroJerk-std-X
- tBodyGyroJerk-std-Y
- tBodyGyroJerk-std-Z
- tBodyAccMag-mean
- tBodyAccMag-std
- tGravityAccMag-mean
- tGravityAccMag-std
- tBodyAccJerkMag-mean
- tBodyAccJerkMag-std
- tBodyGyroMag-mean
- tBodyGyroMag-std
- tBodyGyroJerkMag-mean
- tBodyGyroJerkMag-std
- fBodyAcc-mean-X
- fBodyAcc-mean-Y
- fBodyAcc-mean-Z
- fBodyAcc-std-X
- fBodyAcc-std-Y
- fBodyAcc-std-Z
- fBodyAccJerk-mean-X
- fBodyAccJerk-mean-Y
- fBodyAccJerk-mean-Z
- fBodyAccJerk-std-X
- fBodyAccJerk-std-Y
- fBodyAccJerk-std-Z
- fBodyGyro-mean-X
- fBodyGyro-mean-Y
- fBodyGyro-mean-Z
- fBodyGyro-std-X
- fBodyGyro-std-Y
- fBodyGyro-std-Z
- fBodyAccMag-mean
- fBodyAccMag-std
- fBodyBodyAccJerkMag-mean
- fBodyBodyAccJerkMag-std
- fBodyBodyGyroMag-mean
- fBodyBodyGyroMag-std
- fBodyBodyGyroJerkMag-mean
- fBodyBodyGyroJerkMag-std
