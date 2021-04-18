# load packages
library(dplyr)

## Part A : download and unzip the data sets

# assign a file name for the zip file to be downloaded
filename <- "dataset.zip"
# Check if zip file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}
# Check if folder already exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename)
}
# define the path where the downloaded zip file has been unziped
pathdata = file.path("D:/D_drive/data/OnlineLearning/DataScientistSpecialization/R_Project/datasciencecoursera/Getting&CleaningDataCourseProject", "UCI HAR Dataset")

## Part B :	analyze data sets

# Part B.1 : create the data set of training and test
# (1) Read train data
xtrain = read.table(file.path(pathdata, "train", "X_train.txt"),header=FALSE)
ytrain = read.table(file.path(pathdata, "train", "y_train.txt"),header=FALSE)
subjectTrain = read.table(file.path(pathdata, "train", "subject_train.txt"),header=FALSE)
# (2) Read the test data
xtest = read.table(file.path(pathdata, "test", "X_test.txt"),header=FALSE)
ytest = read.table(file.path(pathdata, "test", "y_test.txt"),header=FALSE)
subjectTest = read.table(file.path(pathdata, "test", "subject_test.txt"),header=FALSE)
# (3) Read the features data
features = read.table(file.path(pathdata, "features.txt"),header = FALSE)
# (4) Read the activity data
activityLabels = read.table(file.path(pathdata, "activity_labels.txt"),header=FALSE)

# Part B.2 label the column names of data sets
# (1) map / assign column names to the Train Data
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityId"
colnames(subjectTrain) <- "subjectId"
# (2) map / assign column names to the test data
colnames(xtest) <- features[,2]
colnames(ytest) <- "activityId"
colnames(subjectTest) = "subjectId"
# (3) assign columns to the activity data
colnames(activityLabels) <- c('activityId','activityType')

## Part B.3 : merge train data set and test data set (step 1)
# merge train data (Step 1)
mergeTrain <- cbind(ytrain, subjectTrain, xtrain)
# merge test data
mergeTest <- cbind(ytest, subjectTest, xtest)
# merge Train data and Test data
mergeTrainTest <- rbind(mergeTrain, mergeTest)

## Part B.4 : Extracts only the measurements on the mean
## and standard deviation for each measurement (Step 2)
TidyData <- mergeTrainTest %>% select(subjectId, activityId, contains("mean"), contains("std"))

## Part B.5 : Uses descriptive activity names to name the activities
## in the data set (step 3)
TidyData$activityId <- activityLabels[TidyData$activityId, 2]

## Part B.6 : Labels the data set with descriptive variable names (step 4)
names(TidyData)[2] = "activityId"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

## Part B.7 : creates a second, independent tidy data set with the average of
## each variable for each activity and each subject. (step 5)
FinalData <- TidyData %>%
  group_by(subjectId, activityId) %>%
  summarise_all(funs(mean))
# write the final data set to a txt file
write.table(FinalData, "FinalData.txt", row.name=FALSE)
# display the final data
head(FinalData,5)


