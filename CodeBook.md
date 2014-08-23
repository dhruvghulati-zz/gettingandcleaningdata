#Guide to run_analysis.R
*Note that this script does not contain nested functions. This is something that could be added later*

#R Packages used:

* reshape2
* data.table
* plyr

#Variable names used:

Initial files read from txt files to data frames in R:

train.x - list of data obtained in the training section for all the features 
train.y - list of the activities performed in the training section by activity code
subject.train - list of the subjects in the training section
test.x - list of data obtained in the test section for all the features
test.y- list of the activities performed in the test section by activity code
subject.test - list of the subjects in the test section
activity_labels - list of all the activities performed e.g. SITTING, WALKING - by code
feature list - list of all the features which have calculations (>100 - only some were standard deviation or mean measurements)

Variables created through cleaning process:

required_features - vector of all the features we actually need to extract measurements for in our txt.file
test_data - data frame of all the data (subject, activity, feature) for the test section
train_data - data frame of all the data (subject, activity, feature) for the train section
data - data frame of both the test and train data as one
columns - the list of columns we actually want our txt file to contain
data_labels - the feature calculations that are the chunk of the data beyond just info on subject, activity_ID and activity label- the values.
melt_data - a melted version of the data to then organise - essentially a table
tidy_data - organising the mean of each feature by subject and Activity_Label.

