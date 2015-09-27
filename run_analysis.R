## You should create one R script called run_analysis.R that does the following.
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names.
## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Assuming you are in the directory where you unzip the data set


# Activity lables and features variable are defined from the txt file.
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("activityID", "activityLabel")
# We look at column 2 of the features to pull out the names which we will match up later for labeling. 
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Establish variables for the test txt files (x, y, and subject)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Establish variables for the train txt files (x, y, and subject)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI Har Dataset/train/subject_train.txt")

# Assign column names for data sets we have (Mainly Objective 4 I believe)
# for subject test and train, the one column will be labeled as subject
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"
# for x test and train, we will use the names in the features variable to assign the column names
colnames(x_test) <- features
colnames(x_train) <- features
# for y test and train, we will use the activityLabels variable to establish what the activities are
y_test[,2] <- activityLabels[y_test[,1],2]
colnames(y_test) <- c("activityID", "Activity")
y_train[,2] <- activityLabels[y_train[,1],2]
colnames(y_train) <- c("activityID", "Activity")


# Objective 1: Merge the test and train data
x_merged <- rbind(x_train,x_test)
y_merged <- rbind(y_train,y_test)
subject_merged <- rbind(subject_train,subject_test)

# Objective 2: Extract the mean and std for each measurement
# using the function grep, we are able to search through character strings for specific matches. This way, we aren't actually hard coding what columns to look at
# The code below finds out what column index we will need to look at for the appropriate columns that contain mean and std
meanNames <- grep("-mean",features)
stdNames <- grep("-std",features)
meanAndStdIndex <- c(meanNames,stdNames)

# with the index of the columns, we just need to pull out the x_merged columns
x_data <- x_merged[,meanAndStdIndex]

# Objective 3: Describe the activites in the data set
# all we need to do is merge in the activity labels with the x_data set
combined_dataset <- cbind(y_merged["Activity"], x_data)

# Objective 4 has been done already

# Objective 5: Tidy data set by activity and subject and write a file. Also add subject to it.
# for this part, we will need to make sure the reshape2 package is installed. The block of code will check to see if you have the package.
# at this point, make sure you are connected to the internet :).
if (!require("reshape2")) {
  install.packages("reshape2")
  library(reshape2)
}else{
  library(reshape2)
}

# Now we have to add the subject to combined_dataset and melt the data set by subject and activity
combined_dataset <- cbind(subject_merged,combined_dataset)
tidyData <- melt(combined_dataset, id=c("Subject","Activity"))
tidyData_final <- dcast(tidyData, Subject + Activity ~ variable, mean)

# Finally, export this to a file
write.table(tidyData_final, "Tidy_Data.txt", row.name = FALSE)
