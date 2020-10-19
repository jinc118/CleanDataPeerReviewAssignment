#setting of the working directory is not included in this script. 
#working directory must include the unzipped downloaded UHC HAR dataset folder

library(dplyr)

#set relative paths for file names to be read from the UHC HAR dataset
wd<-getwd()
trX<-"./UCI HAR Dataset/train/X_train.txt"
trY<-"./UCI HAR Dataset/train/Y_train.txt"
trS<-"./UCI HAR Dataset/train/subject_train.txt"
tX<-"./UCI HAR Dataset/test/X_test.txt"
tY<-"./UCI HAR Dataset/test/Y_test.txt"
tS<-"./UCI HAR Dataset/test/subject_test.txt"
Act<-"./UCI HAR Dataset/activity_labels.txt"
Ft<-"./UCI HAR Dataset/features.txt"

#Read all files needed for assignment
rd_Xtr<-read.delim(trX, header = FALSE, sep = "")
rd_Ytr<-read.delim(trY, header = FALSE, sep = "")
rd_Str<-read.delim(trS, header = FALSE, sep = "")
rd_Xt<-read.delim(tX, header = FALSE, sep = "")
rd_Yt<-read.delim(tY, header = FALSE, sep = "")
rd_St<-read.delim(tS, header = FALSE, sep = "")
rd_Actlabel<-read.delim(Act, header = FALSE, sep = "")
rd_Ft<-read.delim(Ft, header = FALSE, sep = "")


#Label variables in training and test data sets
colnames(rd_Xtr)<-rd_Ft$V2
colnames(rd_Xt)<-rd_Ft$V2
colnames(rd_Actlabel)<-c("ActivityID","ActivityLabel")

#Merge Y Labels and subject data to variable datasets 
rd_Xtr$ActivityID<-rd_Ytr$V1
rd_Xt$ActivityID<-rd_Yt$V1

rd_Xtr$SubjectID<-rd_Str$V1
rd_Xt$SubjectID<-rd_St$V1

#Merge data from training and test data sets together in one dataframe
fullset<-rbind(rd_Xt,rd_Xtr)

#Extract only mean and standard deviation of measurements with merged columns
subset<-select(fullset,contains("std()") | contains("mean()")| "ActivityID"|"SubjectID")
subset<-left_join(subset,rd_Actlabel, by = "ActivityID")

#Calculate mean of all measurements per subject per activity
finalset<-subset%>%
         group_by(ActivityLabel, SubjectID)%>%
         summarize_all(list(mean))%>%
         select(-ActivityID)

#save output file
write.table(finalset,file = "finalset.txt")
