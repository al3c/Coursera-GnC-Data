## setwd("/Users/alecgruss/Documents/Coding/Coursera/GnC Data/data")

## Step 1: merge train and test data sets
## traindata is 7352 obs by 561 variables
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
## train label and subject are 7352 x 1
trainlabel <- read.table("./UCI HAR Dataset/train/y_train.txt")

trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
## testdata is 2947 x 561
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
## train label and subject are 2947 x 1
testlabel <- read.table("./UCI HAR Dataset/test/y_test.txt")

testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

joindata <- rbind(traindata, testdata)
joinlabel <- rbind(trainlabel, testlabel)
joinsubject <- rbind(trainsubject, testsubject)

## Step 2: extract measurements for mean and standard deviation 
## for each measurement

features <- read.table("./UCI HAR Dataset/features.txt")
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features[,2])
joindata <- joindata[, mean_std_indices]
## remove (), capitalize M and S, remove - in column names
names(joindata) <- gsub("\\(\\)", "", features[mean_std_indices,2]) 
names(joindata) <- gsub("mean", "Mean", names(joindata))
names(joindata) <- gsub("std", "Std", names(joindata))
names(joindata) <- gsub("-", "", names(joindata))

## Step 3: descriptive activity names
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[,2] <- tolower(gsub("_", "", activity[,2]))
activitylabel <- activity[joinlabel[,1], 2]
joinlabel[,1] <- activitylabel
names(joinlabel) <- "activity"

## Step 4: label the data set with descriptive activity names
names(joinsubject) <- "subject"
cleandata <- cbind(joinsubject, joinlabel, joindata)
write.table(cleandata, "merged data.txt")

## Step 5: second data set with average of each variable for each activity
## and each subject

subjectlen <- length(table(joinsubject))
activitylen <- dim(activity)[1]
columnlen <- dim(cleandata)[2]
result <- matrix(NA, nrow=subjectlen*activitylen, ncol=columnlen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleandata)
row <- 1
for(i in 1:subjectlen) {
    for(j in 1:activitylen) {
        result[row, 1] <- sort(unique(joinsubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleandata$subject
        bool2 <- activity[j, 2] == cleandata$activity
        result[row, 3:columnlen] <- colMeans(cleandata[bool1&bool2, 3:columnlen])
        row <- row + 1
    }
}
head(result)
write.table(result, "data with means.txt")
