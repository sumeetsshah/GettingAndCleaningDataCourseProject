#GettingAndCleaningDataCourseProject
##Repository for Coursera Getting and Cleaning Data Course Project

This repository contains:
* README.md - The README file
* CodeBook.md - Describes the variables, the data, and any transformations or work done to clean up the data
* run_analysis.R - R script used for the analysis. Produces tidyData.txt file.

Data source for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
To run, unzip the source data in your working directory or unzip the file and set the resulting "UCI HAR Dataset" folder as your working directory 
with te setwd() command.

The run_analysis.R file will:
* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement.
* Use descriptive activity names to name the activities in the data set.
* Appropriately label the data sets with descriptive activity names and create a unified dataset of every subject, activity, and mean/std.
* Create a second, independent tidy data set with the average of each variable for each activity and each subject. The data set is saved as "tidyData.txt" in your working directory!
