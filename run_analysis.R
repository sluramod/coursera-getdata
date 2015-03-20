library(dplyr)

# read features from the file
features <- read.delim("UCI HAR Dataset//features.txt", header=FALSE, sep=' ', strip.white=TRUE)
# keep only features containing mean and std as requested
features_mean_std <- features[grepl("-mean\\(\\)|-std\\(\\)",features$V2,ignore.case=TRUE),]

# read activity labels
activity_labels <- read.delim("UCI HAR Dataset//activity_labels.txt", header=FALSE, sep="")

# training dataset
X_train <- read.delim("UCI HAR Dataset//train/X_train.txt", header=FALSE, sep="")
# keep only columns requested (mean, std)
X_train_mean_std <- X_train[,features_mean_std$V1]
# assign descriptive features names
names(X_train_mean_std) <- features_mean_std$V2

# read y_train dataset using specific factors
f_y_train <- file("UCI HAR Dataset//train/y_train.txt")
y_train_lines <- readLines(f_y_train)
close(f_y_train)
y_train <- data.frame(factor(y_train_lines, levels=activity_labels$V1, labels = activity_labels$V2))
colnames(y_train) <- c("activity")

# read subjects
subjects_train <- read.table("UCI HAR Dataset//train/subject_train.txt", col.names = c("subject"))

# combine all 3 datasets
train <- bind_cols(X_train_mean_std, y_train, subjects_train)

# test dataset
X_test <- read.delim("UCI HAR Dataset//test/X_test.txt", header=FALSE, sep="")
# keep only columns requested (mean, std)
X_test_mean_std <- X_test[,features_mean_std$V1]
# assign descriptive features names
names(X_test_mean_std) <- features_mean_std$V2

# read y_test dataset using specific factors
f_y_test <- file("UCI HAR Dataset//test/y_test.txt")
y_test_lines <- readLines(f_y_test)
close(f_y_test)
y_test <- data.frame(factor(y_test_lines, levels=activity_labels$V1, labels = activity_labels$V2))
colnames(y_test) <- c("activity")

# read subjects
subjects_test <- read.table("UCI HAR Dataset//test/subject_test.txt", col.names = c("subject"))

# combine all 3 datasets
test <- bind_cols(X_test_mean_std, y_test, subjects_test)

# combine train and test datasets
all <- bind_rows(train, test)

# create resulting data set with the average of each variable for each activity and each subject
answer <- summarise_each(group_by(all, activity, subject), funs(mean))
