Getting and Cleaning Data Course Project Code Book
========================================================

This file describes the variables, data, and any transformations or work that I have performed to clean up the data.

* The site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* The data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* The run_analysis.R script performs the following steps to clean the data:
    * Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in traindata, trainlabel and trainsubject variables. Then do the same in the "test" folder.
    * Concatenate data, label, and subject files into new files (joindata, etc.).
    * Read the "features.txt"" file and store the data in a variable called features, only extracting the measurements on the mean and standard deviation. Clean by removing "()", and "-".
    * Read the activity_labels.txt file and store the data in a variable called activity and clean it.
    * Transform the values of joinLabel according to the activity data frame.
    * Combine the joinSubject, joinLabel and joinData by column to get a clean data frame (cleandata). Properly name the first two columns, "subject" and "activity". 
    * Then output to files "merged data.txt"
    * The second independent tidy data set with the average of each measurement for each activity and each subject is calculated by using a nested "for"" loop through the 30 unique subjects and 6 unique activities.
    * Write the result out to "data with means.txt" file.