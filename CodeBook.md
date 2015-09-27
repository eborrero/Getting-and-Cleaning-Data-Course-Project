# CodeBook for Getting and Cleaning Data Course Project

This is the code book for the getting and cleaning data coursera project. This file will go indepth about the data, logic, and variables.
Note: To learn how to use this script, look at the README.md file. This is more of an in-depth description of how the script works.

## The Data
- The data for this project was obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
- The link to the original article/download and description is: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Data Set Information (Source: archive.ics.uci.edu)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
### Data Set Includes the Following Files (Taken from the dataset's README)
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Variables Created When Script is Run
- activityLabels: Reads the activity_labels.txt raw activity name and ID data.
- features: Reads the features.txt raw features data.
- x_test: Reads the X_test.txt raw test data.
- y_test: Reads the y_test.txt raw test activity data.
- subject_test: Reads the subject_test.txt raw subject ID data for test data.
- x_train: Reads the X_train.txt raw train data.
- y_train: Reads the y_train.txt raw train activity data.
- subject_train: Reads the subject_train.txt raw subject ID data for train data.
- x_merged: Row binds the x_test data under the x_train data.
- y_merged: Row binds the y_test data under the y_train data.
- subject_merged: Row binds the subject_test data under the subject_train data.
- meanNames: Created to find what column index contains "-mean" in the headers contained in features.
- stdNames: Created to find what column index contains "-std" in the headers contained in features.
- meanAndStdIndex: Combines both meanNames and stdNames into one variable.
- x_data: Uses meanAndStdIndex to remove unnecessary columns from x_merged.
- combined_dataset: Column binded data which eventually includes subject_merged, Activity column from y_merged, and x_data.
- tidyData: Using reshape2 library's melt function, rearranges data based on "Subject" and "Activity".
- tidyData_Final: Using the function dcast, rearranges the data to be more readable after the melt.

## What the Script run_analysis.R Does
1. The script starts by using read.table to obtain the raw data sets from all relevant txt files.
2. After the data has been obtained, labels are assigned to the data headers based on the features and activity txt files.
3. Since the project wants us to look only at mean and standard deviation columns for all data, the script combines (using row bind) the test and train data into three sets (x, y, and subject).
4. After the data has been merged, the script uses the grep function to search for headers that contain either "-mean" or "-std".
5. After the column index has been obtained for means and standard deviations, the script removes unnecessary columns from the x data.
6. The Activity column from y merged data is column binded with the modifyed x data.
7. The Subject merged data is combined with the data that was combined in the above set. Now we have a full table with Subject, Activity name, and the mean and std data columns.
8. The data is reshaped based on Subject and Activity and rearranged to be readable. This part requires the reshape2 library to be installed.
9. Finally, a Tidy_Data.txt file is created with the tidy data. Note: row.name = FALSE