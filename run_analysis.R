
Here are the data for the project:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Download and extract files
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)

outDir<-getwd()
unzip(temp,exdir=outDir)

unlink(temp)

#Read the .txt files needed
#set outdir to the files location
outDir<-getwd()
#Read the labels to name the columns
label <- read.table(
  paste(outDir, "/UCI HAR Dataset/features.txt", sep="")
  , header=FALSE)

Xtrain <- read.table(
  paste(outDir, "/UCI HAR Dataset/train/X_train.txt", sep="")
  , header=FALSE
  #name the columns with the labels previously read
  ,col.names = label[[2]])

ytrain <- read.table(
  paste(outDir, "/UCI HAR Dataset/train/y_train.txt", sep="")
  , header=FALSE
  , col.names = "activity")


subject_train <- read.table(
  paste(outDir, "/UCI HAR Dataset/train/subject_train.txt", sep="")
  , header=FALSE
  , col.names = "subject")

Xtest <- read.table(
  paste(outDir, "/UCI HAR Dataset/test/X_test.txt", sep="")
  , header=FALSE
  ,col.names = label[[2]])

ytest <- read.table(
  paste(outDir, "/UCI HAR Dataset/test/y_test.txt", sep="")
  , header=FALSE
  , col.names = "activity")

subject_test <- read.table(
  paste(outDir, "/UCI HAR Dataset/test/subject_test.txt", sep="")
  , header=FALSE
  , col.names = "subject")

activity_labels <- read.table(
  paste(outDir, "/UCI HAR Dataset/activity_labels.txt", sep="")
  , header=FALSE
  , col.names = c("y", "activity"))

#Merge the data
yFull = rbind(ytrain, ytest)
subjectFUll = rbind(subject_train, subject_test)
Full_data = rbind(Xtrain, Xtest)

#Extract only the measurement that contain mean and standard deviation
Full_data = Full_data[,grep("\\.mean\\.",names(Full_data))] + Full_data[,grep("\\.std\\.",names(Full_data))]

#Combine with the label and subject
Full_data = cbind(Full_data, yFull, subjectFUll)

#Replace numbers of label with activity names
Full_data$activity = factor(Full_data$activity, activity_labels$y, labels = activity_labels$activity)

#Calculate the average of each variable for each activity and each subject
average_act_subj = aggregate(Full_data[,-c(ncol(Full_data),ncol(Full_data)-1)]
                             , list(Full_data$activity,Full_data$subject), mean)

#save the average table
write.table(average_act_subj, file = "average_act_subj.txt", row.name=FALSE)