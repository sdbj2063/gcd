run_analysis <- function() {
     
     ## A. Defines the libraries to use
     library("utils")
     library("reshape2")
     
     ## B. Downloads the original code book file
     myurlbook <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
     download.file(myurlbook,"human-activity-recognition-using-smartphones.html")
     myurlbookdate <- file.info("human-activity-recognition-using-smartphones.html")
     myurlbookdt <- myurlbookdate$mtime
     
     ## C. Downloads the original data file
     myurldata <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     download.file(myurldata,"getdata_projectfiles_UCI-HAR-Dataset.zip",mode="wb")
     myurldatadate <- file.info("getdata_projectfiles_UCI-HAR-Dataset.zip")
     myurldatadt <- myurldatadate$mtime
     
     ## D. Unzips the data file
     unzip("getdata_projectfiles_UCI-HAR-Dataset.zip")
     
     ## E. Imports features.txt and activity_labels.txt
     my_features <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, sep = "",stringsAsFactors=FALSE)
     my_activity_labels <- read.fwf("./UCI HAR Dataset/activity_labels.txt", widths = c(1,-1,20), header = FALSE, stringsAsFactors =FALSE)

     ## F. Imports subject_test.txt and subject_train.txt
     my_subject_test <- read.delim("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, stringsAsFactors =FALSE)
     my_subject_train <- read.delim("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, stringsAsFactors =FALSE)
     my_subjects <- rbind(my_subject_test,my_subject_train,deparse.level=0)
     rm(my_subject_test, my_subject_train)

     ## G. Imports the x_test.txt and x_train.txt
     my_x_test <- read.delim("./UCI HAR Dataset/test/x_test.txt", header = FALSE, sep = "",stringsAsFactors=FALSE)
     my_x_train <- read.delim("./UCI HAR Dataset/train/x_train.txt", header = FALSE, sep = "",stringsAsFactors=FALSE)
     my_x_axis <- rbind(my_x_test,my_x_train,deparse.level=0)
     rm(my_x_test, my_x_train)
     
     ## H. Imports the y_test.txt and y_train.txt
     my_y_test <- read.delim("./UCI HAR Dataset/test/y_test.txt", header = FALSE, stringsAsFactors =FALSE)
     my_y_train <- read.delim("./UCI HAR Dataset/train/y_train.txt", header = FALSE, stringsAsFactors =FALSE)
     my_y_axis <- rbind(my_y_test,my_y_train,deparse.level=0)
     rm(my_y_test, my_y_train)
     
     ## I.Creates human-readable variable names
     my_features$V3 <- my_features$V2
     my_features$V3 <- sub("^f","Freq",my_features$V3,perl=TRUE)
     my_features$V3 <- sub("^t","Time",my_features$V3,perl=TRUE)
     my_features$V3 <- sub("Acc","Acceleration",my_features$V3,fixed=TRUE)
     my_features$V3 <- sub("Gyro","Gyroscope",my_features$V3,fixed=TRUE)
     my_features$V3 <- sub("Mag","Magnitude",my_features$V3,fixed=TRUE)
     my_features$V3 <- sub("-mean()-","_mean_",my_features$V3,fixed=TRUE)
     my_features$V3 <- sub("-mean()","_mean",my_features$V3,fixed=TRUE)
     my_features$V3 <- sub("-std()-","_std_",my_features$V3,fixed=TRUE)
     my_features$V3 <- sub("-std()","_std",my_features$V3,fixed=TRUE)
     
     ## J.Assigns new variable labels to column names
     names(my_x_axis) <- my_features[,3]
     
     ## K.Extracts the calculations variable columns for mean() and std()
     my_col_mean <- row(my_features)[grep("mean()",my_features$V2, fixed=TRUE, value=FALSE)]
     my_col_std <- row(my_features)[grep("std()",my_features$V2, fixed=TRUE, value=FALSE)]
     my_col_final <- c(my_col_mean, my_col_std)
     my_x_axis2 <- my_x_axis[,my_col_final]
     rm(my_x_axis)
         
     ## L. Binds the my_y_axis and my_x_axis2 data sets.
     my_big_data <- cbind(my_y_axis,my_x_axis2,deparse.level=0)
     
     ## M. Binds my_subjects as a column to my_big_data sets.
     my_big_data <- cbind(my_subjects,my_big_data,deparse.level=0)
     my_column_names <- c("SubjectCode","ActivityCode")
     names(my_big_data)[1:2] <- my_column_names
     
     ## N. Calculates the mean for each variable grouped by subject and activity
     my_td <- melt(my_big_data, id=c("SubjectCode", "ActivityCode"), na.rm=TRUE)
     my_tidy_data <- dcast(my_td, SubjectCode + ActivityCode ~ variable, mean, margins = FALSE)
     rm(my_big_data, my_td)
     
     ## O. Replaces activity codes with activity labels and orders SubjectCode and ActivityCode first
     myfactors <- factor(my_tidy_data$ActivityCode)
     levels(myfactors) <- my_activity_labels$V2
     my_tidy_data <- cbind("ActivityCode" = myfactors, my_tidy_data, deparse.level=0)
     my_tidy_data <- cbind("SubjectCode" = my_tidy_data$SubjectCode, my_tidy_data, deparse.level=0)
     my_tidy_data <- my_tidy_data[,-3:-4]
     my_tidy_data$ActivityCode <- as.character(my_tidy_data$ActivityCode)
     
     ## P.Writes the tidy data
     write.table(my_tidy_data,file="gcd_tidy_data_set.txt", row.names=FALSE)
     
}