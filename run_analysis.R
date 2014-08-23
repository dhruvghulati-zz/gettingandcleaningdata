# You should create one R script called run_analysis.R that does the following. 
	# 1.	Merges the training and the test sets to create one data set.
	# 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
	# 3.	Uses descriptive activity names to name the activities in the data set
	# 4.	Appropriately labels the data set with descriptive variable names. 
	# 5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#Get all required packages
library(plyr)
if (!require("data.table")) {install.packages("data.table")}
if (!require("reshape2")) {install.packages("reshape2")}
require("data.table")
require("reshape2")

#Download all content and set up a courseproject folder
	fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	if(!file.exists("courseproject")){dir.create("courseproject")}
	zipfile="./courseproject/jawbone.zip"
	message("downloading the file")
	download.file(fileURL,destfile=zipfile,method="curl")
	message("Unzipping file contents")
	unzip(zipfile,exdir="courseproject")
	message("loading X_train.txt")
	train.x <- read.table("courseproject/UCI HAR Dataset/train/X_train.txt")
	message("loading y_train.txt")
	train.y <- read.table("courseproject/UCI HAR Dataset/train/y_train.txt")
	message("loading subject_train.txt")
	subject.train <- read.table("courseproject/UCI HAR Dataset/train/subject_train.txt")
	message("loading X_test.txt")
	test.x <- read.table("courseproject/UCI HAR Dataset/test/X_test.txt")
	message("loading y_test.txt")
	test.y <- read.table("courseproject/UCI HAR Dataset/test/y_test.txt")
	message("loading subject_test.txt")
	subject.test <- read.table("courseproject/UCI HAR Dataset/test/subject_test.txt")
	message("loading activity_labels.txt")
	#The activity labels second column only contains names
	activity_labels <- read.table("courseproject/UCI HAR Dataset/activity_labels.txt")[,2]
	message("loading features.txt")
	#The features second column only contains lists of features
	featurelist <- read.table("courseproject/UCI HAR Dataset/features.txt")[,2]

#Create a new vector added to the featurelist data frame which looks for patterns of the features vector - only features with the words "mean" or "std" in them, and so we know which ones we need to extract
required_features <- grepl("mean|std", featurelist)

#We know that train.y and test.y are numbers in the txt file which should be reassigned to being activity names. So in the activity labels column vector we assign a new column which is essentially the requisite activity label for that number. This is like saying activitylabels[1:3000]
test.y[,2] = activity_labels[test.y[,1]]
train.y[,2] = activity_labels[train.y[,1]]

#Renames the column names of each data frame, sometimes using the column vector extracted via featurelist (which contains multiple columns)
	#The test and train files (X) contains lots of columns, essentially the featurelist columns
	names(test.x) = featurelist
#The test data frame currently has only "Activity ID" (1:6), but we will be binding another column to it which will be the activity label, in the second column
	names(test.y) = c("Activity_ID", "Activity_Label")
	names(subject.test) = "subject"
	names(train.x) = featurelist
	names(train.y) = c("Activity_ID", "Activity_Label")
	names(subject.train) = "subject"

# Extract only the columns of feature names required for the dataset
test.x = test.x[,required_features]
train.x = train.x[,required_features]


#To subject test we bind two columns together, the activity labels (test.y) and only the features required (mean and standard deviation) for certain features
test_data <- cbind(as.data.table(subject.test), test.y, test.x)
train_data <- cbind(as.data.table(subject.train), train.y, train.x)

#We then bind everything together
data = rbind(test_data, train_data)

#We know our new data will have 3 columns so we just rename to make sure
columns  = c("subject", "Activity_ID", "Activity_Label")
#We want the column names of data not in the columns assigned
data_labels = setdiff(colnames(data), columns)
#Now we melt the dataset and tell it what should appear in what row. Any columns not in the columns assigned get into measure.vars. We know that the key labels to be sorted and are the columns
melt_data= melt(data, id = columns, measure.vars = data_labels)
# Apply mean function to dataset using dcast function. This calculates the mean of each variable, by subject and by Activity_Label.
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "courseproject/tidy_data.txt",row.names=FALSE)

	
