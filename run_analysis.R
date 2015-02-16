#  run_analysis script

# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extract the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second,
#         independent tidy data set with the average of:
#                each variable for each activity and
#                each subject.
require("dplyr")
require("tidyr")

#  Define the loading environment
home_dir <- getwd()
upper_dir <- "UCI_HAR_Dataset"
train_dir <- "train"
test_dir <- "test"


# Load label files
activity_file <- "activity_Labels.txt"
features_file <- "features.txt"
act_tab <- read.table(paste(home_dir, upper_dir, activity_file, sep="/"), sep=" ")
feat_tab <- read.table(paste(home_dir, upper_dir, features_file, sep="/"), sep=" ")

# Load train data files
print ("Loading and cleaning train data files")
subject_train_file <- "subject_train.txt"
train_data_file <- "X_train.txt"
train_acts_file <- "y_train.txt"
sub_train <- as_data_frame(read.table(paste(home_dir, upper_dir, train_dir, subject_train_file, sep="/"), sep=""))
acts_train <- as_data_frame(read.table(paste(home_dir, upper_dir, train_dir, train_acts_file, sep="/"), sep=""))
data_train <- as_data_frame(read.table(paste(home_dir, upper_dir, train_dir, train_data_file, sep="/"), sep=""))
colnames(data_train) <- feat_tab[,2]
colnames(sub_train) <- "Subject"
#Activity <- apply(acts_train, 1, function(elm){elm <-as.character(act_tab[elm,2])})
Activity <- apply(acts_train, 1, function(elm){elm <-act_tab[elm,2]})
# acts_train <- data.frame(Activity)
train_tab <- cbind(sub_train, Activity, data_train)
train_df <- as_data_frame(train_tab)
#  Clean up by removing large data files no longer needed
rm("sub_train", "data_train", "train_tab", "Activity")


# Load test data files
print ("Loading and cleaning test data files")
subject_test_file <- "subject_test.txt"
test_data_file <- "X_test.txt"
test_acts_file <-"y_test.txt"
sub_test <- as_data_frame(read.table(paste(home_dir, upper_dir, test_dir, subject_test_file, sep="/"), sep=""))
acts_test <- as_data_frame(read.table(paste(home_dir, upper_dir, test_dir, test_acts_file, sep="/"), sep=""))
data_test <- as_data_frame(read.table(paste(home_dir, upper_dir, test_dir, test_data_file, sep="/"), sep=""))
colnames(data_test) <- feat_tab[,2]
colnames(sub_test) <- "Subject"
#Activity <- apply(acts_test, 1, function(elm){elm <-as.character(act_tab[elm,2])})
Activity <- apply(acts_test, 1, function(elm){elm <-act_tab[elm,2]})
# acts_test <- data.frame(Activity)
test_tab <- cbind(sub_test, Activity, data_test)
test_df <- as_data_frame(test_tab)
#  Clean up by removing large data files no longer needed
rm("sub_test", "data_test", "test_tab", "Activity")
rm("act_tab", "acts_test", "acts_train", "feat_tab")

## Now Extract the mean and Std columns from test_df and train_df
print ("Extracting Mean and Std Columns and merging data files")
## temp_df <- select(test_df, matches("mean"))
order(c(grep("Subject", colnames(test_df)), grep("Activity",
      colnames(test_df)),grep("mean", colnames(test_df)), grep("std",
      colnames(test_df))))
