#Getting and cleaning data project
#Download and unzip the dataset

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
path_rf <- file.path("./data", "UCI HAR Dataset")

#Read data from the files into the variables

#Read the Activity files
dataActivityTrain <- read.table(file.path(path_rf, "train", "y_train.txt"), header=FALSE)
dataActivityTest <- read.table(file.path(path_rf, "test", "y_test.txt"), header=FALSE)

#Read the Subject files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"), header=FALSE)
dataSubjectTest <-read.table(file.path(path_rf, "test", "subject_test.txt"), header=FALSE)

#Read the Features files
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "x_train.txt"), header=FALSE)
dataFeaturesTest <- read.table(file.path(path_rf, "test", "x_test.txt"), header=FALSE)

#Assignment1:Merges the training and the test sets to create one data set
#step1: Concatenate the data tables by rows

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

#step2: set names to variables

names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"), header=FALSE)
names(dataFeatures) <- dataFeaturesNames[, 2]

#step3: Merge columns

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataCombine, dataFeatures)

#Assignment2: Extracts only the measurements on the mean and std for each measurement

subdataFeaturesNames <- dataFeaturesNames[, 2][grep("mean\\(\\)|std\\(\\)", dataFeaturesNames[, 2])]
selectedNames <- c("subject", "activity", as.character(subdataFeaturesNames))
Data <- subset(Data, select = selectedNames)

#Assignment3: Use descriptive activity names to name the activities in the data set

activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"), header=FALSE)
Data$activity <- factor(Data$activity, levels = activityLabels[, 1], labels = activityLabels[, 2])
Data$subject <- as.factor(Data$subject)

#Assignment4: Appropriately labels the data set with descriptive variable names

names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "frequency", names(Data))
names(Data) <- gsub("Acc", "Accelerometer", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))

#Assignment5: create a second, independent tidy data set and output it

library(plyr)
Datatwo <- aggregate(. ~subject + activity, Data, mean)
Datatwo <- Datatwo[order(Datatwo$subject, Datatwo$activity), ]
write.table(Datatwo, file = "tidydata.txt", row.name=FALSE)



