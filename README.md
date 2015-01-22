#Coursera Getting and Cleaning Data-course course project

Task on the course was:

" You should create one R script called run_analysis.R that does the following. 

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement. 

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names. 

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

Data is from the following project: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 


Loaded as instructed from:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
)

#Files

- Data files in directory: UCI HAR Dataset -directory

- README.md, this file

- run_analysis.R , R-program producing requested output

- CodeBook.md , description of data and transformations done

- tidy1.txt , processed tidy data from step 4 

- tidy2.txt , aggregated tidy data from step 5



#Running the program

Program expects reshape2 and dplyr libraries to be installed in the system.

Once you have downloaded the repository. Set the current working directory to the repo - and run code with source-command.

Like:

setwd("/Users/huima/datascience/gettingandcleaningdata/project-repo")
source("run_analysis.R")

Tested on OS X. "R version 3.1.1 (2014-07-10)"


#What the script does

Script is commented in the source code, but here is a brief go through for the process. There is no error checking or output during the run of the script.

In the first step of the process test and training data is merged into one dataset. 

Second step imports readable column names from the features file and injects them to the dataset. Columns that have mean or std in them are selected as the maindataset from this point forward.

Third step loads activity data and activity label data. Test and training activity data is merged into own dataset. Left join is used to combine activity dataset with labels. This activity data is then merged as new columns into main dataset. There is no additional renaming of columns, as they are sufficiently well named.

Fourth step loads subject information and adds that to the main dataset with the same procedure - combining test and training data, and then adding it as a new column. First output file gets written out from this dataset. Second dataset gets aggregated by using reshape-module and melt - cast -- method. In the aggregate subject and activity are used as identity columns. 

Fifth step is profit. 

