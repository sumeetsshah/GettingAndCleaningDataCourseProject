##Author: Sumeet Shah
##Date Last Modified: May 23, 2015

##Read in the data from the "train" folder
trainStat <- read.table("train/X_train.txt")
trainAct <- read.table("train/y_train.txt")
trainSubject <- read.table("train/subject_train.txt")

##Read in the data from the "test" folder
testStat <- read.table("test/X_test.txt")
testAct <- read.table("test/y_test.txt")
testSubject <- read.table("test/subject_test.txt")

##Step 1: Merges the training and the test sets to create one data set.
##Merge the test and train sets with rbind() to combine rows
mergedStat <- rbind(trainStat, testStat)
mergedAct <- rbind(trainAct, testAct)
mergedSubject <- rbind(trainSubject, testSubject)


##Step 2: Extract only the measurements on the mean and standard deviation for each measurement.

##Read in the features table
features <- read.table("features.txt")

##Subset only the mean and the std value positions.
means<-subset(subset=grepl(".*mean.*", features$V2), features)
stds<-subset(subset=grepl(".*std.*", features$V2), features)

##Merge the mean and std set with rbind() to combine rows
meanAndStd<-rbind(means,stds)

##Pull out the mean and std values from the data using the previously obtained positions
mergedStat <- mergedStat[, meanAndStd$V1]

##Name variables in merged dataset as what particular mean or std they are
names(mergedStat) <- features[meanAndStd$V1, 2]


##Step 3: Use descriptive activity names to name the activities in the data set.

##Read in the activity labels from the txt file
activityLabels <- read.table("activity_labels.txt")

##Replace the number values in mergedAct with their corresponding activity
mergedAct[,1] = activityLabels[mergedAct[,1], 2]

##Rename the variable in mergedAct to "Activity"
names(mergedAct) <- "Activity"

##Step 4: Appropriately label the data set with descriptive activity names

##The mergedSubject is the only one that has yet to be given useful labels, so label it
##appropriately
names(mergedSubject) <-"Subject"

##I guess this data frame goes under Step 4, as Step 5 utilizes it to get averages of each variable.
##activity, and subject.
##Binds all data on Subject, Activity, and Statistics (means and stds) together
subjActStat <- cbind(mergedSubject, mergedAct, mergedStat)

##Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity for each subject

##Retrieves lists of unique subjects and activities.
##In the tidy data frame, there will be a repeated subject entry for each unique activity so
##we can see the subject's average for each activity
distinctSubjects <- unique(mergedSubject$Subject)
distinctActivities <- unique(activityLabels[,2])


##Find the number of columns of subjActStat, number of unique subjects, and number of unique activities. 
##This will be necessary when creating the tidy data.
numberOfColumns = dim(subjActStat)[2]
numberOfSubjects = length(distinctSubjects)
numberOfActivities = length(distinctActivities)

##There will be 1 row for each activity for each subject
numberOfRows = numberOfSubjects*numberOfActivities

##Create an empty data frame of appropriate size to be filled with the average data
tidyData <- data.frame(matrix(NA, nrow = numberOfRows, ncol = numberOfColumns))

##A counter so that the following loops will know what row to be inserting their data into.
currentRow = 1

##Loop over each unique subject
for (j in 1:numberOfSubjects) {
  
  ##For each unique subject, loop over each unique activity
  for (k in 1:length(distinctActivities)) {
    
    ##Set the Subject to be the Subject currently being looped on
    tidyData[currentRow, 1]<-distinctSubjects[j] 
    ##Set the Activity to be the Activity currently being looped on
    tidyData[currentRow, 2]<-distinctActivities[k]
    
    ##Subset the activity values for the Subject
    actSubset <- subset(subjActStat, subjActStat$Subject == j & subjActStat$Activity == distinctActivities[k])
    
    ##Get the average values for each of the columns and insert them into the tidy data
    tidyVector <- colMeans(actSubset[, 3:numberOfColumns])
    tidyData[currentRow, 3:numberOfColumns] <- tidyVector
    
    ##Now that this row is complete, add 1 to the currentRow so in the next iteration, the
    ##next row is filled
    currentRow <- currentRow+1
  }
}

##Name the columns in the tidy data appropriately
names(tidyData)[1] <- "Subject"
names(tidyData)[2] <- "Activity"
nameVector<- names(mergedStat)
names(tidyData)[3:numberOfColumns] <- nameVector

##Write the tidy data to a .txt file! Finally!
write.table(tidyData, "tidyData.txt", row.names=FALSE)