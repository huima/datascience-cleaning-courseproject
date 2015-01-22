#
# 
# setwd("/Users/huima/datascience/gettingandcleaningdata/project-repo")
# source("run_analysis.R")
#
#
#
library(reshape2)
library(dplyr)

#
# Define files that are used in the processing
#

# Test files, actual data
testFile <- "UCI HAR Dataset/test/X_test.txt"
trainFile <- "UCI HAR Dataset/train/X_train.txt"

# Test data column identifiers 
featuresFile <- "UCI HAR Dataset/features.txt"

# Activity identifier files
testActFile <- "UCI HAR Dataset/test/y_test.txt"
trainActFile <- "UCI HAR Dataset/train/y_train.txt"
actLabelFile <- "UCI HAR Dataset/activity_labels.txt"


# Files identifying subjects
testSubjectFile <- "UCI HAR Dataset/test/subject_test.txt"
trainSubjectFile <- "UCI HAR Dataset/train/subject_train.txt"

# STEP 1:
# First goal, merge the training and the test sets to create one data set.
#

testData <- read.table(testFile)
trainData <- read.table(trainFile)
mergedData <- rbind(testData,trainData)

# STEP 2:
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# - mean, std
#

# Prevent labels becoming factors, and push them as column names
featureData <- read.table(featuresFile, stringsAsFactors = FALSE)
colnames(mergedData) <- featureData$V2

# 
# I wanted to use select, but got errors on duplicate columns
# select(mergedData, matches("mean|std"))
# keys <- duplicated(names(mergedData))
# (names(mergedData))[keys]
#

selectedSet <- mergedData[,grepl("mean|std", colnames(mergedData))]
# length(colnames(selectedSet))  is 79
# length(unique(colnames(selectedSet))) is 79
# Checked 


#
# STEP 3:
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
#

testDataActivity <- read.table(testActFile)
trainDataActivity <- read.table(trainActFile)
actLabels <- read.table(actLabelFile)

mergedActivityData <- rbind(testDataActivity,trainDataActivity)

colnames(mergedActivityData) <- c('activityId')
colnames(actLabels) <- c('activityId','activity')

mergedActivityData <- left_join(mergedActivityData, actLabels, by = c('activityId'))

# Checked 
# dim(mergedActivityData)
# dim(mergedData)
# Both datasets had 10299 rows

selectedActivitySet <- cbind(selectedSet, mergedActivityData)

#
# Next labeling
#
#setNames <- colnames(selectedActivitySet)
#setNames <- gsub("std", "")
#
# Decided to leave the dataset column names as they are, as they are descreptive
# enough and doing simple replacement operations do not provide additional value
# It would be just adding lipstick to a pig


#
# STEP 4:
# From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
#

testSubjects <- read.table(testSubjectFile)
trainSubjects <- read.table(trainSubjectFile)
subjects <- rbind(testSubjects,trainSubjects)
colnames(subjects) <- c('subject')
# Checked subjects to have 10299 rows

# add subjects to the dataset
completeData <- cbind(selectedActivitySet, subjects)

# Reshaping the data to have aggregates for each activity and each subject
# Used this article as help: http://seananderson.ca/2013/10/19/reshape.html
#
longData <- melt(completeData,id.vars= c("subject","activity"))
wideData <- dcast(longData, subject+activity ~ ..., fun.aggregate=mean)


write.table(completeData,file="tidy1.txt", row.names=FALSE)
write.table(wideData,file="tidy2.txt", row.names=FALSE)



