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

This file describes the different variables used in the script:  

testactivity: contains the test data for activity
trainactivity: contains the train data for activity

testsubject: contains the test data for subject
trainsubject: contains the train data for subject

testfeatures: contains the test data for features
trainfeatures: contains the train data for features

activity: merged train and test activity data
subject: merged train and test subject data
features: merged train and test features data

activity_labels: contains the labels or column names for the merged activity data set
features_labels: contains the labels or column names for the merged features data set

mean_stdev: contains all features columns name's which have either mean or standard deviation in their name
subset: is the reduced version of the features data set containing only the column names present in mean_stdev

subjectactivity: merged data set containing activity of each subject  
finaldata: created from merging the subjectactivity and subdata data sets
cleandata: is the final tidy/clean data. Contains activity of each subject and the average of each variable
