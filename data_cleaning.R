testactivity = read.table("test/Y_test.txt", header = F)
trainactivity = read.table("train/y_train.txt", header = F)

testsubject = read.table("test/subject_test.txt", header = F)
trainsubject = read.table("train/subject_train.txt", header = F)

testfeatures = read.table("test/X_test.txt", header = F)
trainfeatures = read.table("train/X_train.txt", header = F)

activity = rbind(trainactivity, testactivity)
subject = rbind(trainsubject, testsubject)
features = rbind(trainfeatures, testfeatures)

activity_labels = read.table("activity_labels.txt", header = F)
activity$V1 = factor(activity$V1, levels = as.integer(activity_labels$V1), labels = activity_labels$V2)

names(activity) = c("activity")
names(subject) = c("subject")

features_labels = read.table("features.txt", header = F)
names(features) = features_labels$V2

mean_stdev = c(as.character(features_labels$V2[grep("mean\\(\\)|std\\(\\)", features_labels$V2)]))
subdata = subset(features, select = mean_stdev)

subjectactivity = cbind(subject, activity)
finaldata = cbind(subdata, subjectactivity)

names(finaldata) = gsub("^t", "time", names(finaldata))
names(finaldata) = gsub("^f", "frequency", names(finaldata))

cleandata = aggregate(finaldata, by = list(finaldata$subject, finaldata$activity), FUN = mean)
colnames(cleandata)[1:2] = c("Subject", "Activity")

cleandata = cleandata[1:68]

write.table(cleandata, file = "clean_data.txt", row.name = F)
