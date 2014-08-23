gettingandcleaningdata
======================

#This was a course project for Johns Hopkin's specialization track#

##About the dataset

This dataset was a test carried out on a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, it captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 70% of the volunteers was selected for generating the training data and 30% the test data. 

A vector of features was obtained by calculating variables from the time and frequency domain which essentially are the various calculation brackets and sections of measurement obtained of velocity, acceleration etc., for each subject. 

###About the code

The code here will essentially read into R all the most recent test and training results via downloading the data from the source, per subject, and assign the correct feature and activity label to the test and training results via some data cleansing/wrangling. The script assigns useful column labels, and only extracts a table which looks at the feature variables which are related to means and standard deviation calculations. Then, it calculates the mean of each feature variable needed, by subject and by activity name and writes that to a txt file in your courseproject directory.

###Running the script

1. Clone this repository and create a copy on your local machine
2. Source the "run_analysis.R" file.
3. Whichever directory you are on, it will create a folder called "courseproject", download the files, and place unzipped files from the source into this courseproject folder, all in the "UCI HAR Dataset" folder.

###Assumption

* The training and test datasets are available in folders named train and test respectively.

For each of these data sets:
* Measurements are present in X_<train/test>.txt files
* Subject information is present in subject_<train/test>.txt files
* Activity codes are present in y_<train/test>.txt files
* All activity codes and their labels are in a file named activity_labels.txt.
* Names of all measurements taken are present in file features.txt ordered and indexed as they appear in the X_<train/test>.txt files.
* All columns representing means contain ...mean() in them.
* All columns representing standard deviations contain ...std() in them
