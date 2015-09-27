# Getting and Cleaning Data Course Project
 Readme
##The Course Project from Coursera for the Data Science Specialization Track
The script called run_analysis.R is created to meet the course requirements which are listed down below:

You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## To run the script, you will need to download the dataset from the link provided below:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Make sure the script is in the same folder as the extracted zip folder.
- Within the working directory, you should see the UCI HAR Dataset folder (all data sets inside it the same way you extracted the zip folder) and the run_analysis.R script.
- Once the above has been met, run the script and there will be an output file called "Tidy_Data.txt" which is a data set organized by subject and activity (means and stds).
- You WILL need to have the reshape2 library downloaded. If you do not have this, the script will automatically look for and download the library.
- See the CodeBook.md for more information about the variables created in this script.