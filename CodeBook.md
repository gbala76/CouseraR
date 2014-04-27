Coursera Project
=========

Code is written in Rstudio editor on Ubuntu Linux.

  - Type some Markdown text in the left window
  - See the HTML in the right
  - Magic



Script Explained
--------------

```
# Project Getting & Cleaning data
# Richard Ngamita 'ngamita@gmail.com'



# Link to data files. 
# file link is named fileUrl 

# Download to local dir.
Files are then downloaded local dir. 

# unzip the Dataset zipped files.

Files unzipped for local use. 

# Read training data sets. 
x_train 
y_train 
subject_train 

# Read test data sets.
x_test 
y_test 
subject_test


# Append read data using cbind. 
data.frame.train 
data.frame.test 

# read in features.txt column names data. 
# Keep as string and not factor. 

# Merge both datasets in 1 large set. rbind()
data_set is our main data set (data frame)

# Rename, colnames of repective train and test data sets.
# todo: skip, first and last (v1(subject) and v2(y_values) respectively.)



# Get all columns with mean or std variables data. 
# mean_std_cols -> gets all cols with mean() or std() data.

# Use as indexes. 
# separate subject data and Y values 



require(plyr)

# Read the activity data set. 

# Add the activities to main data set "data_set", new column. 

require(reshape2)
Melt and Dcast the file. 


# Write as tidy data. 
```



```sh
node app
```


License
----




**Free Script**

[Richard Ngamita]:http://thedatafugee.blogspot.com/


    