library(reshape2)

# Download data and unzip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./data.zip")
unzip("./data.zip", exdir = "./data")

# Load user data from both (train and test) datasets and merge
data_train <- read.table(file = "./data/UCI HAR Dataset/train/X_train.txt")
data_test <- read.table(file = "./data/UCI HAR Dataset/test/X_test.txt")
data <- rbind(data_train, data_test)

# Load activity information from both (train and test) datasets and merge
data_act_train <- read.table(file = "./data/UCI HAR Dataset/train/y_train.txt")
data_act_test <- read.table(file = "./data/UCI HAR Dataset/test/y_test.txt")
data_act <- rbind (data_act_train, data_act_test)

# Load subject information from both (train and test) datasets and merge
data_sub_train <- read.table(file = "./data/UCI HAR Dataset/train/subject_train.txt")
data_sub_test <- read.table(file = "./data/UCI HAR Dataset/test/subject_test.txt")
data_sub <- rbind(data_sub_train, data_sub_test)

# Retrieve all "mean" and "std" features
features <- read.table(file = "./data/UCI HAR Dataset/features.txt")
meanIdx <- grep("mean", features[[2]])
stdIdx <- grep("std", features[[2]])
idx <- append(meanIdx, stdIdx, after = length(meanIdx))
filtered_features <- features[idx,2]

# Filter user data by columns of interest (filtered features)
filtered_data <- data[, idx]

colnames(filtered_data) <- filtered_features
colnames(data_act) <- "activity"
colnames(data_sub) <- "subject"

# Populate meaningful activity information 
act <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
for (i in 1:6) {
    data_act$activity[data_act$activity == i] <- act[i]
}

# Merge subject, activity and user datasets
sub_activity <- cbind(data_sub, data_act)
merged_data <- cbind(sub_activity, filtered_data)

# Calculate average of each variable for each activity and each subject
melted_data <- melt(merged_data, id = c("subject", "activity"))
tidy_data <- dcast(melted_data, subject + activity ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)




