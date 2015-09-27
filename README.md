# coursera_getting_and_cleaning_data_project
This is the course project for the Coursera course--Getting and Cleaning Data. 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

There are 28 text files included in the dataset. For the purposes of this project, the files in the Inertial Signals folders are not used. The files that will be used to load data are listed as follows:

test/subject_test.txt
test/X_test.txt
test/y_test.txt
train/subject_train.txt
train/X_train.txt
train/y_train.txt

The R script, run_analysis.R, does the following:

1. Download and unzip the dataset.
2. Read data from the files into the variables.
3. Assignment1: Merges the training and the test sets to create one data set.
4. Assignment2: Extracts only the measurements on the mean and std for each measurement.
5. Assignment3: Use descriptive activity names to name the activities in the data set.
6. Assignment4: Appropriately labels the data set with descriptive variable names.
7. Assignment5: create a second, independent tidy data set and output it.

The end result is shown in the file tidy.txt.
