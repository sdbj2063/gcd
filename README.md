README.md

# Project Information:
# ======================================

Getting and Cleaning Data Class

Johns Hopkins University and Coursera

Script for Project

November 2014

# Introduction to this README and the R Script:
# ======================================

This README.md contains information about the script, how to operate it and how it meets
the project requirements.
The associated R script is run_analysis.R and must reside in the user's working directory.
The code book for this project is CodeBook.md.
The script generates a space delimited text file gcd_tidy_data_set.txt in the user's
working directory.

# Introduction to Original Data Set:
# ======================================

This script utilizes the code book and data at the following URLs:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# License to Original Data Set:
# ======================================
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

# Platform Information:
# ======================================

Oringinal script was run on the following system with RStudio.

* Windows 7 home Premium
* Service Pack 1
* 64-bit OS
* 1.6 GHz processor
* 4.00 GB RAM
 
* R version 3.1.1 (2014-07-10) -- "Sock it to Me"
* Copyright (C) 2014 The R Foundation for Statistical Computing
* Platform: x86_64-w64-mingw32/x64 (64-bit)

* R package "utils" 3.1.1
* R package "reshape2" 1.4


# Summary of Data Used and Script Requirements:
# ===============================
The original data unzips into your working directory in /UCI HAR Dataset with /train and /test subdirectories. The data is loaded into a grid, with 561 variables, or columns, plus subject and activity labels completing the columns. The columns of data are common mathematical calculations on the raw data set.

The sources for the rows of calculated data are X_test.txt and X_train.txt. The sources for the row labels indicating to what activity code a row of data corresponds are y_text.txt and y_train.txt. The sources for the row labels indicating to what subject a row of data corresponds are subject_test.txt and subject_train.txt. The source for the text names of the activity codes is activity_labels.txt. The source for the variable, or column, labels is features.txt.

The R script must be installed in the user's working directory. It reads from and saves files to that path. The command to execute the script is "run_analysis()."

# Project Script Requirements:
# ======================================

The project script must perform five basic functions:

1. Merge training and test sets into one data set.
2. Extract measures on the mean and standard deviation for each measurement.
3. Use descriptive activity names for the activities.
4. Label the data with descriptive variable names.
5. Create a second independent tidy data set with the average of each variable for each activity and each subject.
 
This script fulfills these requirements by performing the following functions. The individual functions occur in alphabetical order in the script.

1. Merge training and test sets into one data set.

    A. Sets libraries for R to utilize.

    B. Downloads the code book for the data file to the working directory. Retrieves the download date.
   
    C. Downloads the compressed data file to the working directory. Retrieves the download date.
    
    D. Unzips the compressed data file to the working directory.
    
    E. Imports features.txt and activity_labels.txt into individual data sets.
    
    F. Imports subject_test.txt and subject_train.txt and creates one super data set.
    
    G. Imports x_test.txt and x_train.txt and creates one super x_axis data set.
    
    H. Imports y_test.txt and y_train.txt and creates one super y_axis data set.
    
    L. Binds the activity list in y_axis and the x_axis data sets into big_data data set.
    
    M. Binds train and test subject ids to the big_data data set.
    

2. Extract measures on the mean and standard deviation for each measurement.

K. Extracts the measurement columns on the mean and standard deviation for each measurement in the x_axis data set and combines them into one data set.

3. Use descriptive activity names for the activities.
    O. Replaces activity codes with activity labels.

4. Label the data with descriptive variable names. 

    I. Creates human-readable feature labels for column names.
    
    J. Assigns my_features labels to column names.

5. Create a second independent tidy data set with the average of each variable for each activity and each subject.

    N. For the second data set, the tidy data set, calculates the mean for each variable (column of data) for each activity and each subject.
    
    P. Writes the tidy data to a text file in the working directory.
   

# Working Code Comments:
# ======================================

A. Defines the libraries to use

B. Defines the data set code book url, download the file and get the date

    Result is the HTML code book is in the working directory.

C. Defines the data set url, download the file and get the date

    Result is the zipped data file is in the working directory.

## D. Unzips data file
##    Result is the creation of the /UCI HAR Dataset directory in the working directory
##    informational text files in this subdirectory, and training and test files in 
##    subdirectories below /UCI HAR Dataset.

## E. Imports the features.txt and activity_labels.txt
##    Results are two data frames.
##    The features data frame has 2 variables with 561 rows.
##    The activity labels data frame has 2 variables with 6 rows.

## F. Imports the subject_test.txt and subject_train.txt. Creates super set.
##    Results are two data frames.
##    The test data frame has 1 variable with 2947 rows.
##    The train data frame has 1 variable with 7352 rows.
##    Result is one super set data frame with test and train records in that order with
##    1 variable, or column, and 10299 rows.

## G. Imports the x_test.txt and x_train.txt. Creates super set.
##    Results are two data frames.
##    The test data frame has 561 variables with 2947 rows.
##    The train data frame has 561 variables with 7352 rows.
##    Result is one super set data frame with test and train records in that order with
##    561 variables and 10299 rows.

## H. Imports the y_test.txt and y_train.txt
##    Results are two data frames.
##    The test data frame has 1 variable with 2947 rows.
##    The train data frame has 1 variable with 7352 rows.
##    Result is one super set data frame with test and train records in that order with
##    1 variable, or column, and 10299 rows.

## I. Creates human-readable feature labels for column names.

##    Copies names into third column of my_features.
##    Process third column using sub() to replace the characters below with words.
##    Word definitions obtained from README.txt and features_info.txt files 
##    and original data developers' description.
##    Deliberate decision to replace only the first instance of a string to capture f, t.
##    Focused on variables with mean() or std() in the name.
##    Replaced special characters dash and parens with underscore.
##    No explanation of "BodyBody" found in documentation, so that stands on its own.
##    "Body" and "Gravity" are self-explanatory.

##    f at beginning of line -> Freq, which stands for Frequency
##    t at beginning of line -> Time
##    Acc -> Acceleration
##    Gyro -> Gyroscope
##    Mag -> Magnitude
##    -mean()- -> _mean_
##    -mean() -> _mean
##    -std()- -> _std_
##    -std() -> _std


## J. Assigns my_features labels to column names
##    Result is variable names in the my_x_axis block have the new human readable names.


## K. Extracts the variable calculations columns for mean() and std()

##    To fulfill the project requirement to take the measurements on the 
##    mean and standard deviation for the measurements, I used variables with 
##    mean() and std().  MeanFreq() is another type of measurement.
##    mean() has 33 variables, or columns.
##    std() has 33  variables, or columns.
##    Result is a total column extraction of 66 into a new data set.

## L. Binds the my_y_axis and my_x_axis2 data sets.

##    my_y_axis contains 1 column with activity codes.
##    my_x_axis2 contains 66 columns of feature variables.
##    Result is one data frame set with 67 columns and 10299 rows.
##    First column contains the activity codes.
##    Remaining columns are feature variables.

## M. Binds my_subjects as a column to my_big_data sets.

##    Result is one set with 68 columns and 10299 rows
##    Assigns "SubjectCode" and "ActivityCode" as names to the first two columns.

## N. Calculates the mean for each variable

##    Uses melt() to create a manageable data frame with grouping by SubjectCode and 
##    ActivityCode.
##    Uses dcast() to apply the mean calculation to each group of data.
##    Result is my_tidy_data set listing all subject codes, each with an activity code
##    and a row of mean value calculations for each variable.

## O. Replaces activity codes with activity labels.

##    Creates a factor list of the activity codes.
##    Uses level() to replace factor level numbers with associated activity label text.
##    Orders SubjectCode and ActivityCode columns as columns 1 and 2 in data set.
##    Removes the old SubjectCode and ActivityCode columns.
##    Recasts factor column as character column.
##    Result is one set with 68 columns and 10299 rows.

## P. Writes the tidy data

##    Result is one data file "gcd_tidy_data_set.txt" in the working directory.

