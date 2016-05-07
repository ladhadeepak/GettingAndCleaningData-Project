# Getting and Cleaning Data

In this project, we work on the data collected from the accelerometers from the Samsung Galaxy S smartphone.

Following steps are followed to process the data -
* Download and unzip the data
* Load sampled user data from both (train and test) datasets and merge
* Load sampled activity information from both (train and test) datasets and merge
* Load volunteers information from both (train and test) datasets and merge
* Filter sampled user data by keeping only "mean" and "std" features (columns)
* Merge all the datasets - volunteers (subject) data, sampled activity data, filtered sampled user data
* Calculate average of each variable for each activity and each subject and store in a file (tidy_data.txt)