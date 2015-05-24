#Coursera Course Project Code Book

###Link to Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
###Link to Source Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script performs the following steps on the source data:
* Read in the source data.
* Merge the train and test data into one data set.
	* (train/X_train.txt) and (test/X_test.txt) merge into a data frame that is 10299x561 named mergedStat, as it contains the statistical data
	* (train/y_train.txt) and (test/y_test.txt) merge into a data frame that is 10299x1 named mergedAct, as it contains the activities
	* (train/subject_train.txt) and (test/subject_test.txt) merge into a data frame that is 10299x1 named mergedSubject, as it contains the subjects
* Reads the features.txt file and extracts the features including data on the mean and std for each measurement. 
	* This creates the meanAndStd data frame, which has 66 attributes that are measurements on the mean and standard deviation.
* meanAndStd is used to filter the mergedStat data frame so it only contains the stats that are mean or std, yielding a 10299x79 data frame
	* The stat variables are of the form [t for time or f for frequency][variable name]-[stat type]()-[dimension X, Y, or Z] and are fairly self descriptive. ex)tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tGravityAcc-std()-X (see below for full)
	* All values here are normalized between -1 and 1
* Next, it reads the activity_labels.txt file and applies these labels to the currently numeric values in the mergedAct frame.
	* The activity types are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* Merge mergedStat, mergedAct, and mergedSubjects into 1 frame, subjActStat. subjActStat is 10299x81, with column 1 being Subject(integer), column 2 being Activity(character), and columns 3 through 68 being various mean and std values (float)
* Lastly, the script creates a new, tidy data set with the average of each measurement for each activity and each subject. 
	* The data frame is 180x68, with the first column as Subject(integer), the second column as Activity(character), and the remaining columns with the averages for each of the mean/std attributes(float).
	* The data frame is saved as tidyData.txt in the working directory

###All statistical attribute names   [t for time or f for frequency][variable name]-[stat type]()-[dimension X, Y, or Z]
"tBodyAcc-mean()-X"               
"tBodyAcc-mean()-Y"              
"tBodyAcc-mean()-Z"               
"tGravityAcc-mean()-X"           
"tGravityAcc-mean()-Y"            
"tGravityAcc-mean()-Z"           
"tBodyAccJerk-mean()-X"           
"tBodyAccJerk-mean()-Y"          
"tBodyAccJerk-mean()-Z"           
"tBodyGyro-mean()-X"             
"tBodyGyro-mean()-Y"              
"tBodyGyro-mean()-Z"             
"tBodyGyroJerk-mean()-X"          
"tBodyGyroJerk-mean()-Y"         
"tBodyGyroJerk-mean()-Z"          
"tBodyAccMag-mean()"             
"tGravityAccMag-mean()"           
"tBodyAccJerkMag-mean()"         
"tBodyGyroMag-mean()"             
"tBodyGyroJerkMag-mean()"        
"fBodyAcc-mean()-X"               
"fBodyAcc-mean()-Y"              
"fBodyAcc-mean()-Z"               
"fBodyAcc-meanFreq()-X"          
"fBodyAcc-meanFreq()-Y"           
"fBodyAcc-meanFreq()-Z"          
"fBodyAccJerk-mean()-X"           
"fBodyAccJerk-mean()-Y"          
"fBodyAccJerk-mean()-Z"           
"fBodyAccJerk-meanFreq()-X"      
"fBodyAccJerk-meanFreq()-Y"       
"fBodyAccJerk-meanFreq()-Z"      
"fBodyGyro-mean()-X"              
"fBodyGyro-mean()-Y"             
"fBodyGyro-mean()-Z"              
"fBodyGyro-meanFreq()-X"         
"fBodyGyro-meanFreq()-Y"          
"fBodyGyro-meanFreq()-Z"         
"fBodyAccMag-mean()"              
"fBodyAccMag-meanFreq()"         
"fBodyBodyAccJerkMag-mean()"      
"fBodyBodyAccJerkMag-meanFreq()" 
"fBodyBodyGyroMag-mean()"         
"fBodyBodyGyroMag-meanFreq()"    
"fBodyBodyGyroJerkMag-mean()"     
"fBodyBodyGyroJerkMag-meanFreq()"
"tBodyAcc-std()-X"                
"tBodyAcc-std()-Y"               
"tBodyAcc-std()-Z"                
"tGravityAcc-std()-X"            
"tGravityAcc-std()-Y"             
"tGravityAcc-std()-Z"            
"tBodyAccJerk-std()-X"            
"tBodyAccJerk-std()-Y"           
"tBodyAccJerk-std()-Z"            
"tBodyGyro-std()-X"              
"tBodyGyro-std()-Y"               
"tBodyGyro-std()-Z"              
"tBodyGyroJerk-std()-X"           
"tBodyGyroJerk-std()-Y"          
"tBodyGyroJerk-std()-Z"           
"tBodyAccMag-std()"              
"tGravityAccMag-std()"            
"tBodyAccJerkMag-std()"          
"tBodyGyroMag-std()"              
"tBodyGyroJerkMag-std()"         
"fBodyAcc-std()-X"                
"fBodyAcc-std()-Y"               
"fBodyAcc-std()-Z"                
"fBodyAccJerk-std()-X"           
"fBodyAccJerk-std()-Y"            
"fBodyAccJerk-std()-Z"           
"fBodyGyro-std()-X"               
"fBodyGyro-std()-Y"              
"fBodyGyro-std()-Z"               
"fBodyAccMag-std()"              
"fBodyBodyAccJerkMag-std()"       
"fBodyBodyGyroMag-std()"         
"fBodyBodyGyroJerkMag-std()"  