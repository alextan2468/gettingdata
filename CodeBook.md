#Code Book for the Course Project

##Raw Data Description  
*Raw data from both train and test data sets are organized in same way  
*Variables are as follows   
  
  Variable Name 		       | Variable Type | Values   | Data containing files  
---------------------------------------| --------------| -------- |-------------------------------------  
  subject       	               | Categorical   | 1 to 30  |subject_test.txt or subject_train.txt  
  activity      	               | Categorical   |  1 to 6  |y_test.txt of y_train.txt  
  561 items in the "features.txt" file | Continuous    |any number|X_test.txt or X_train.txt  
  
  
##Data Tidying and Summarizing Description  
*The "run_analysis.R" script is sourced and the tidyup() function inside the file was run  
*The function processed the data and creates a final SummaryOfAvg data table.  
*The function does the following:  
	+unzip the data files  
	+load the dplyr and tidyr packages  
	+read the text files in the unzipped folder into data tables  
	+create test data frame "testdf" and train data frame "traindf" from respective data sets.  
	+create "mergedf" by combining both sets together by rbind  
	+create the header names for this "mergedf" data frame by creating a vector with the names:  
		"subject", "activity" and the variable names as read from the file "features.txt"  
	+assign the header names to the "mergedf" dataframe.  
	+the duplicate columns in the "mergedf" dataframe are then removed.  
	+from the resulting dataframe, only the columns with "mean" and "sd" are selected and assigned to "mergedfselect" data frame  
	+the activity of the dataframe is then renamed with the descriptive names, resulting in a "mergedfrename" data frame  
	+from the "mergedfrename", we want to summarize the averages of each variable by each subject and each activity, the script gathers all the variables names into a key column called "variable" and the values into a column called "reading".  
	+using piping, the above temporary dataframe is grouped subject, activity and variable and the mean of each  set is then calculated by using the summarize() function  
	+lastly this final dataframe is assigned to "SummaryOfAvg", written into a text file and returned from the function.  
  
##SummaryOfAvg output data Description  
-The final output is a narrow format table consisting of 4 columns(variables):  
	1. Variable: subject (Type: Categorical)  
		Values: 1 to 30  
		Description: An ID of the participant  
	2. Variable: activity (Type: Categorical)  
		Values:"WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"  
		Description: This is the activity during which the data is recorded.  
	3. Variable: variable (Type: Categorical)  
		Values: any mean() or sd() value as listed inside the "features.txt" file  
		Description: This is the variable which is to be summarized.  
	4. Variable: average_of_each_variable (Type: Continuous numerical)  
		Values:Any numbers  
		Description: This is the final average of each variable as grouped by subject and activity  
  
**The data can be transformed to wide format by spread() function in dplyr but is maintained in narrow format which provides better clarity when there are too many variables to summarize.**
