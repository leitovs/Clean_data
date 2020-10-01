# Clean_data

The run_analysis.R code downloads the data from the link:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

They are extracted in the working directory and the necessary .txt data for both training and testing are read, then the data of the training and testing xs are joined and the mean and standard deviation characteristics are extracted.

Then the activities and subjects are added to the data, the activity numbers are replaced by their respective texts, the average is calculated by grouping them by activity and subjects, and the resulting table is saved as average_act_subj.txt
