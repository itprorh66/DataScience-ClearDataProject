#DataScience-ClearDataProject
This repository contains the class work required to satisfy requirements of the Getting and Cleaning Data Course.  The purpose of this project is to demonstrate an ability to collect, work with, and clean a data set. The goal is to prepare tidy data set that can be used for later analysis.  
##Data Source
The source of the data used in this project is from:  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
    
##Data Description
This dataset comes from experiments described in:   
    *Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. __Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.__ International Workshop of Ambient Assisted     Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.*  
    
The dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

A complete description of the experiments performed and the data collected can also be found at:  
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##Project Description  
This project created a codebook describing the data retrieval, extraction and cleasning that was performed along with an R script entitled run_analysis.R that does the following.  
  1. Merges the training and the test sets to create one data set.  
  2. Extracts only the measurements on the mean and standard deviation for each measurement.  
  3. Uses descriptive activity names to name the activities in the data set.  
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Working Directory Structure  
The run_analysis script requires that the source data be accessible from the working directory in which the script runs.  The script assumes that within the working directory there shall exist a sub-directory entitled "UCI_HAR_Dataset" and within this sub-directory there shall exist two files entilted "features.txt" and "activity_labels.txt" and two sub-sub-directories the first entitled "Train" and the second entitled "Test."  The "Train" directory shall contain the files: "X_train.txt", "subject_train.txt", and "y_train.txt."  The "Test" directory shall contain the files: "X_test.txt", "subject_test.txt", and "y_test.txt."
