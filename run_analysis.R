tidyup <- function(){
  unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  
  #load dply & tidyr
  library(dplyr)
  library(tidyr)
  
  #read the text files to tables
  subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE,stringsAsFactors=FALSE)
  Xtest <-read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE,stringsAsFactors=FALSE)
  ytest <-read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE,stringsAsFactors=FALSE)
  subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE,stringsAsFactors=FALSE)
  Xtrain <-read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE,stringsAsFactors=FALSE)
  ytrain <-read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE,stringsAsFactors=FALSE)
  featureheader<-read.table("UCI HAR Dataset/features.txt",header=FALSE,stringsAsFactors=FALSE)
  activityname<-read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,stringsAsFactors=FALSE)
  
  #create test data frame and train data frame
  testdf<-tbl_df(cbind(subjecttest,ytest,Xtest))
  traindf<-tbl_df(cbind(subjecttrain,ytrain,Xtrain))
  
  #Requirement1:Merges the training and the test sets to create one data set
  mergedf<-rbind(testdf,traindf)
  
  #Requirement4:Appropriately labels the data set with descriptive variable names
  headernames <- c("subject","activity",featureheader[,2])
  headernames<-tolower(headernames) #change to lowercase for easy access
  headernames<-make.names(headernames) #make into syntactically valid names
  #Set the header names to the merged data frame
  colnames(mergedf) <- headernames
  
  #Requirement2:Extracts only the measurements on the mean and standard deviation for each measurement.
  mergedf <- mergedf[!duplicated(names(mergedf))] #need remove duplicate columns
  mergedfselect <- select(mergedf,subject,activity,contains("mean"),contains("sd"))
  
  #Requirement3:Uses descriptive activity names to name the activities in the data set
  mergedfrename<-mutate(mergedfselect,activity=activityname[activity,2])
  
  #Requirement5:creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  mergedfrename %>% gather(variable,reading,-subject,-activity) %>% group_by(subject,activity
  ,variable) %>% summarize(average_of_each_variable=mean(reading,na.rm=TRUE)) -> SummaryOfAvg
  
  ##mergefrename is the table up to requirement 4
  ##and the SummaryOfAvg is the final summary table of requirement 5
  
  write.table(SummaryOfAvg,file="tidydataset.txt",row.names=FALSE)
  
  SummaryOfAvg
  
}
