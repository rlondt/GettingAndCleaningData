# GettingAndCleaningData
Week 4 assignment for Coursera's Getting and Cleaning Data Course

## run_analisys.R
This script does the following:

1. download and unzip file if it does not already exists
2. Load feature labels
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set
5. Load the trainingset
6. Load the testset
7. Merge the trainingset and the testset
8. Appropriately labels the data set with descriptive variable names which we created in line 9. From the data set in step 8, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
10. Load activity labels
11. turn activities & subjects into factors
12. create a set with the average of each variable for each activity and each subject
13. write the set to tidy.txt

# Prerequisite
During execution of the run_analisys.R the "reshape2" package is used. This package has to be installed before running the script. 
install.packages('reshape2')

