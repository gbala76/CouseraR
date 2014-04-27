# Project Getting & Cleaning data
# Richard Ngamita 'ngamita@gmail.com'

if(!file.exists('data')){
  dir.create('./data')
}

# Link to data files. 
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Download to local dir.
download.file(fileUrl, destfile='./data/Dataset.zip', method='wget')

# unzip the Dataset zipped files.
unzip('./data/Dataset.zip')


# Read training data sets. 
x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')

# Read test data sets.
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

# temp = list.files(path='./UCI HAR Dataset/train/', pattern="*.txt")
# for (i in 1:length(temp)) assign(temp[i], read.csv(temp[i]))
# labelFilename <- file.path('UCI HAR Dataset', 'activity_labels.txt') #refactor later


# Append read data using cbind. 
data.frame.train <- cbind(x_train, y_train)
data.frame.train <- cbind(subject_train, data.frame.train)

data.frame.test <- cbind(x_test, y_test)
data.frame.test <- cbind(subject_test, data.frame.test)

# read in features.txt column names data. 
# Keep as string and not factor. 
features <- read.table('./UCI HAR Dataset/features.txt', stringsAsFactors=FALSE)

# Merge both datasets in 1 large set. rbind()
data_set <- rbind(data.frame.train,data.frame.test)

# Rename, colnames of repective train and test data sets.
# todo: skip, first and last (v1(subject) and v2(y_values) respectively.)
names(data_set)[2:562] <- features[,2]
names(data_set)[1] <- 'subject'
names(data_set)[563] <- 'y_values'


# Get all columns with mean or std variables data. 
# mean_std_cols -> gets all cols with mean or std data.
patterns= c("-mean\\(\\)","-std\\(\\)")
mean_std_cols <- unique (grep(paste(patterns,collapse="|"), features$V2, value=TRUE))

# Use as indexes. 
# separate subject data and Y values 
new_data_set <- data_set[2:562]
mean_std_df <- new_data_set[mean_std_cols]


require(plyr)

# Read the activity data set. 
activity <- read.table('UCI HAR Dataset/activity_labels.txt')

tidy_data <- mean_std_df
# Add the activities to main data set "data_set", new column. 
tidy_data$activity <- mapvalues(data_set$y_values, from = (as.character(activity$V1)), to = (as.character(activity$V2)))
tidy_data$subject <- data_set$subject

require(reshape2)

tdMelt <- melt(tidy_data,id=c("subject","activity"))
tdData <- dcast(tdMelt, subject + activity ~ variable, value.var="mean")


# Write as tidy data. 
write.table(tdData, file="./tidydata.txt", sep="\t", row.names=FALSE)