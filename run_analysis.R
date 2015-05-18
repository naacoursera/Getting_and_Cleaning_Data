# Create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(data.table)
library(reshape2)


# 1. Merges the training and the test sets to create one data set.

# Load X_test and y_test data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Load subject_train and subject_test data.
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Bind train and test data (X,Y and subject) using row bind

X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
subject <- rbind(subject_train,subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Load features data
features <- read.table("./UCI HAR Dataset/features.txt")

# Extract index of variable containing "mean" or "std"
extract_features <- grepl("mean|std", features[,2])

# Use the index to Extract mean and std from dataset.
X = X[,extract_features]

# Name the variables
names(X) <- features[extract_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))


# 3. Uses descriptive activity names to name the activities in the data set.
# Load activities data
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Replace Y value with decriptive from activity_labels.
activities[, 2] = gsub("_", "", as.character(activities[, 2]))
Y[,1] = activities[Y[,1], 2]

# Name the variables
names(Y) <- "Activity"


# 4. Appropriately labels the data set with descriptive activity names.

names(subject) <- "Subject"
allData <- cbind(as.data.table(subject), X, Y)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
meltedData <- melt(allData, id=c("Subject","Activity"))
tidyData   = dcast(melted, Subject+Activity ~ variable, mean)

# Write to tidy_data text file
write.table(tidyData, file = "./tidy_data.txt", row.name=FALSE)
