# CleanDataPeerReviewAssignment
Data Science Course : Clean Data Week 4 Peer Review Assignment

#Following files are available in this submission
1. "Codebook.MD"  - provides details about the data in the final output file named "finalset.R"
2. "README.MD"      - explains the steps in detail taken to clean up the raw data for the assignment
3. "finalset.txt"   - final output file with the expected tidy data
4. "run_analysis.R" - R script file that transforms the original data for the assignment into the final output data.

# How to generate the "finalset.txt" file submitted in this assignment? 
# Skip to step 3 if only reading the final output file.

#Step 1:Before running the analysis file named "run_anlaysis.R"
Make sure that the original assignment data set found in the link below has been extracted into your working directory https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Step 2: 
    Source the "run_analysis.R" file and let it run to clean up the data and product the finalset.txt file

#Step 3:
    Read the output file using code read.table("finalset.txt", header = TRUE, sep = "")
    

#Method to clean up used in the accompanying R script file. dplyr package was loaded and used as part of the script to clean up.

1. The original data set was read into separate variables using relative paths. This created a dataset each for training measurement file, training activity type file, training subject identity file, test measurement file, test activity type file, and test subject identity file. In addition the activity labels and feature labels were read in from the provided original data.

2. In the next step the variables in measurement file from training and test were labeled with appropriate variable names from the feature label file. It was assumed that the data is in the appropriate order in the original dataset. In addition, the activity labels dataset was given appropriate column names for use later in the script. ("ActivityID" and "ActivityLabel")

3. The activity type was added to the training and test measurement file by creating a new column in the respective datasets using row data from the activity type datasets created in step 1. (rd_Yt and rd_Ytr)

4. Subject identity was added to the training and test measurement file by creating a new column in the respective datasets using row data from the subject identity files created during step 1. (rd_St, rd_Str)

5. The training and test datasets with variable descriptions and added activity and subject identified were combined together using rbind method. This created a new dataset called "fullset"

6. A subset of the full data file was created using "select" and "contains" method, that only extracted columns that contained string "std()" and "mean()" and the columns named "ActivityID" and "SubjectID". This filterd out any columns that were not a standard deviation of the measurement or a mean of the measurement (angle data as well as frequency mean was discarded in this part as they are not part of the measurement data requested for this assignment.)

7. The subset data from Step 6 was merged with the activity label file (rd_Actlabel) using the "left_join" method by "ActivityID" column. This gave a descriptive value to the activities identified in the activity type data.

8. A final dataset was created using chain method to group the subset data by ActivityLable and Subject ID and then summarizing the data by averaging all column data based on that grouping. In this step the additional column of ActivityID was removed as well.

9. In the last step the final dataset was exported to the create a clean file named "finalset.txt"
    

#Read the Codebook.MD file for details on the data in file named "finalset.txt""