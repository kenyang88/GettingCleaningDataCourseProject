CODE BOOK

Title : CodeBoob.md
Output : github_document
Author : Ken Yang


Libraries Required
==================================
dplyr, data.table


CodeBook Description
==================================
This document is a codebook providing descriptions of the variables, the data, and transformations performed to clean data. It performs the preparation of data set (including downloading, unzipping, file reading, etc.) and then followed by 5 steps as required by the course project.

## Download and unzip the dataset
Dataset downloaded and unzipped under the folder called “UCI HAR Dataset”

## assign each data to variables
xtrain <- test/X_train.txt : 7352 rows, 561 columns
contain recorded features train data

ytrain <- test/y_train.txt : 7352 rows, 1 columns
contain train data of activities

subjectTrain <- test/subject_train.txt : 7352 rows, 1 column
contain train data of train subjects being observed

xtest <- test/X_test.txt : 2947 rows, 561 columns
contain recorded features test data

ytest <- test/y_test.txt : 2947 rows, 1 columns
contain test data of activities

subjectTest <- test/subject_test.txt : 2947 rows, 1 column
contain test data of test subjects being observed

features <- features.txt :ncol : 561 rows, 2 columns
contain features of accelerometer and gyroscope 3-axial raw signals

activityLabels <- activity_labels.txt : 6 rows, 2 columns
contain list of activities performed when the corresponding measurements were taken

## Merge the training data set and the test dataset to create one data set (step 1)
create mergeTrain (7352 rows, 563 columns) by merging y_train, subjectTrain, and x_train using cbind() function

create mergeTest (2947 rows, 563 column) by merging y_test, subjectTest, x_test using cbind() function

create mergedTrainTest (10299 rows, 563 column) by merging mergTrain and mergeTrain using cbind() function

## Extract only the measurements on the mean and standard deviation for each measurement (step 2)
create TidyData (10299 rows, 88 columns) by subsetting mergedTrainTest, based on selected columns only: subjectId, activityId, as well as measurements on the mean and standard deviation (std) for each measurement.

## Uses descriptive activity names to name the activities in the data set (step 3)
Entire numbers in column activityId of the TidyData replaced by the corresponding activity taken from 2nd column of the variable activityLabels

## Appropriately labels the data set with descriptive variable names (step 4)
activityId column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (step 5)
create FinalData by summarizing TidyData to take the means of each variable for each activity and each subject, after grouped by subjectId and activityId.
Export FinalData into FinalData.txt file.
