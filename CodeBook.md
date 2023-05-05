---
title: "Getting and Cleaning Data Project 2"
output: 
  html_document: 
    keep_md: yes
date: "2023-05-05"
author: "Punya Hirawat"
editor_options: 
  markdown: 
    wrap: 72
---



## Processing Fragmented Accelerometer Data

The R script my_analysis.R serves the function of retrieving, merging
and cleaning the train and test text files downloaded from [Samsung
Galaxy Accelerometer
Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The script performs the following functions:  
-Loading test and train activity, subject and feature data sets  
-Merging these test and train data sets into single activity, subject and feature data sets  
-Renaming the columns  
-Obtaining the required mean and standard deviation data set  
-Aggregating this data based on subject and activity type  
-Creating a cleaned data set with the required data


The code to perform all of the above is given below:

```r
## Loading the activity test and train data
testactivity = read.table("test/Y_test.txt", header = F)
trainactivity = read.table("train/y_train.txt", header = F)


## Loading the subject test and train data
testsubject = read.table("test/subject_test.txt", header = F)
trainsubject = read.table("train/subject_train.txt", header = F)


## Loading the features test and train data
testfeatures = read.table("test/X_test.txt", header = F)
trainfeatures = read.table("train/X_train.txt", header = F)


## Merges test and train data set for activity, subject and features
activity = rbind(trainactivity, testactivity)
subject = rbind(trainsubject, testsubject)
features = rbind(trainfeatures, testfeatures)


## Retrieving activity labels and matching factor levels(1-6) to these
activity_labels = read.table("activity_labels.txt", header = F)
activity$V1 = factor(activity$V1, levels = as.integer(activity_labels$V1), labels = activity_labels$V2)


## Renaming Activity and Subject Columns
names(activity) = c("activity")
names(subject) = c("subject")


## Renaming the features columns with the lablels from the features.txt file
features_labels = read.table("features.txt", header = F)
names(features) = features_labels$V2


## Subsetting the mean and standard deviation data from features data
mean_stdev = c(as.character(features_labels$V2[grep("mean\\(\\)|std\\(\\)", features_labels$V2)]))
subdata = subset(features, select = mean_stdev)


## Merging and obtaining the final data set with subject, activity and features
subjectactivity = cbind(subject, activity)
finaldata = cbind(subdata, subjectactivity)


## Clarifying time and frequency features 
names(finaldata) = gsub("^t", "time", names(finaldata))
names(finaldata) = gsub("^f", "frequency", names(finaldata))


## Creating the clean data set by aggregating based on mean of every subject and activity
cleandata = aggregate(finaldata, by = list(finaldata$subject, finaldata$activity), FUN = mean)
colnames(cleandata)[1:2] = c("Subject", "Activity")


## Removing the non-aggregated columns
cleandata = cleandata[1:68]


## Writing this cleaned data set to a text file
write.table(cleandata, file = "clean_data.txt", row.name = F)
```
