# download and unzip file if it does not already exists
if (!file.exists("UCI HAR Dataset")) { 
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
  unzip(temp, exdir ="./")
}


# Load feature labels
features <- read.table("UCI HAR Dataset/features.txt")
# categorizing the second column as character
features[,2] <- as.character(features[,2])


# Extracts only the measurements on the mean and standard deviation for each measurement.
featuresExtracted <- grep(".*mean.*|.*std.*", features[,2])
featuresExtracted.names <- features[featuresExtracted,2]

# Uses descriptive activity names to name the activities in the data set
# Rename features to understandable meanings rename -mean and -std and removing '-()'
featuresExtracted.names = gsub('-mean', 'Mean', featuresExtracted.names)
featuresExtracted.names = gsub('-std', 'StandardDeviation', featuresExtracted.names)
featuresExtracted.names <- gsub('[-()]', '', featuresExtracted.names)

# Load the trainingset
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresExtracted]
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Load the testset
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresExtracted]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge the trainingset and the testset
allData <- rbind(train, test)

#Appropriately labels the data set with descriptive variable names which we created in line 26-28.
colnames(allData) <- c("subject", "activity", featuresExtracted.names)


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- allData
# Load activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
# categorizing the second column as character
activityLabels[,2] <- as.character(activityLabels[,2])


# turn activities & subjects into factors
tidyData$activity <- factor(tidyData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
tidyData$subject <- as.factor(tidyData$subject)

#install.packages('reshape2')
library(reshape2)

tidyData.melted <- melt(tidyData, id = c("subject", "activity"))
tidyData.mean <- dcast(tidyData.melted, subject + activity ~ variable, mean)

write.table(tidyData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
