require("dplyr")
require("reshape2")

#  Define the loading environment
home_dir <- getwd()
upper_dir <- "UCI_HAR_Dataset"
train_dir <- "train"
test_dir <- "test"

# Test for proper woking environment
if (!file.exists(paste(home_dir, upper_dir, sep="/")) |
         !file.exists(paste(upper_dir, train_dir, sep= "/")) |
         !file.exists(paste(upper_dir, test_dir, sep ="/"))) {
     print("Error Incorrect working environment")
}  else {
# Working environment is good


     # .... Useful Utility Functions ........

     adj_names <- function(val, tgt, col) {
          #  Reads a table/data.frame column specified by col and
          #  greps for the tgt phrase.  If the Tgt is found add the current row number to
          #  the contents of the cell
          for (idx in 1:nrow(val)) {
               k <- length(grep(tgt, val[idx,col]))
               if (k > 0) {
                    val[idx, 2] <- paste(as.character(idx),
                                         as.character(val[idx,2]), sep="-")
               }
          }
          val
     }


     # Load label files
     activity_file <- "activity_Labels.txt"
     features_file <- "features.txt"
     act_tab <- read.table(paste(home_dir, upper_dir, activity_file, sep="/"), sep=" ")
     feat_tab <- read.table(paste(home_dir, upper_dir, features_file, sep="/"), stringsAsFactors= FALSE, sep=" ")

     # Make Duplicate Column labels Unique by adding the row number to the label
     feat_tab <- adj_names(feat_tab, "bandsEnergy", 2)

     # Load training data files
     print ("Loading and cleaning train data files")
     subject_train_file <- "subject_train.txt"
     train_data_file <- "X_train.txt"
     train_acts_file <- "y_train.txt"
     sub_train <- as_data_frame(read.table(paste(home_dir, upper_dir, train_dir,
                             subject_train_file, sep="/"), sep=""))
     acts_train <- as_data_frame(read.table(paste(home_dir, upper_dir,
                             train_dir, train_acts_file, sep="/"), sep=""))
     train_df <- as_data_frame(read.table(paste(home_dir, upper_dir, train_dir,
                              train_data_file, sep="/"),  stringsAsFactors= FALSE, sep=""))

     colnames(train_df) <- feat_tab[,2]
     colnames(sub_train) <- "Subject"
     acts_train <- data.frame(apply(acts_train, 1, function(elm){elm <-act_tab[elm,2]}))
     colnames(acts_train) <- "Activity"

     # Load test data files
     print ("Loading and cleaning test data files")
     subject_test_file <- "subject_test.txt"
     test_data_file <- "X_test.txt"
     test_acts_file <-"y_test.txt"
     sub_test <- as_data_frame(read.table(paste(home_dir, upper_dir,
                              test_dir, subject_test_file, sep="/"), sep=""))
     acts_test <- as_data_frame(read.table(paste(home_dir, upper_dir,
                              test_dir, test_acts_file, sep="/"), sep=""))
     test_df <- as_data_frame(read.table(paste(home_dir, upper_dir, test_dir,
                              test_data_file, sep="/"),  stringsAsFactors= FALSE, sep=""))
     colnames(test_df) <- feat_tab[,2]
     colnames(sub_test) <- "Subject"
     acts_test <- data.frame(apply(acts_test, 1, function(elm){elm <-act_tab[elm,2]}))
     colnames(acts_test) <- "Activity"

     ## Now Extract the mean and Std columns from test_df and train_df
     print ("Extracting Mean and Std Columns and merging data files")
     tstmn_df <- test_df %>%
          select(contains("fbody")) %>%
          select(contains("Mag")) %>%
          select(contains("Mean()"))
     tststd_df <- test_df %>%
          select(contains("fbody")) %>%
          select(contains("Mag")) %>%
          select(contains("std()"))

     tst_data <- cbind(sub_test, acts_test, tstmn_df, tststd_df)
     tst_data <- arrange(tst_data, Subject, Activity)
     colnames(tst_data) <- gsub("BodyBody","Body", colnames(tst_data))

     trnmn_df <- train_df %>%
          select(contains("fbody")) %>%
          select(contains("Mag")) %>%
          select(contains("Mean()"))
     trnstd_df <- train_df %>%
          select(contains("fbody")) %>%
          select(contains("Mag")) %>%
          select(contains("std()"))

     trn_data <- cbind(sub_train, acts_train, trnmn_df, trnstd_df)
     trn_data <- arrange(trn_data, Subject, Activity)
     colnames(trn_data) <- gsub("BodyBody","Body", colnames(trn_data))

     # Creating the Training Tidy dataset
     print("Creating and outputting the Training Tidy dataset")
     trn_tidy <- melt(trn_data, id=c("Subject", "Activity"), measure.vars= colnames(trn_data[3:5]))
     tst_tidy <- melt(tst_data, id=c("Subject", "Activity"), measure.vars= colnames(tst_data[3:5]))
     write.table(tst_tidy, "Tidy_data.txt", row.names=FALSE)


}


