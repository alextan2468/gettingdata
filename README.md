#Notes on how to the script works
1. You must first download the zip file into your working directory.
2. Before running the script, you need to install dplyr and tidyr packages.
3. Save "run_analysis.R" into the same working directory.
4. source for the R script by typing
5. 	source("run_analysis.R")
5. There is only one function and type the following to run the function:
6. 	tidyup()
6. The function then does the following:
7. 	*unzip the data files
8. 	*load the dplyr and tidyr packages
9. 	*read the text files in the unzipped folder into data tables
10. 	*create test data frame "testdf" and train data frame "traindf" from respective data sets.
11. 	*create "mergedf" by combining both sets together by rbind
12. 	*create the header names for this "mergedf" data frame by creating a vector with the names:
13. 		"subject", "activity" and the variable names as read from the file "features.txt"
14. 	*assign the header names to the "mergedf" dataframe.
15. 	*the duplicate columns in the "mergedf" dataframe are then removed.
16. 	*from the resulting dataframe, only the columns with "mean" and "sd" are selected and assigned to "mergedfselect" data frame
17. 	*the activity of the dataframe is then renamed with the descriptive names, resulting in a "mergedfrename" data frame
18. 	*from the "mergedfrename", we want to summarize the averages of each variable by each subject and each activity, the script gathers all the variables names into a key column called "variable" and the values into a column called "reading".
19. 	*using piping, the above temporary dataframe is grouped subject, activity and variable and the mean of each  set is then calculated by using the summarize() function
20. 	*lastly this final dataframe is assigned to "SummaryOfAvg", written into a text file and returned from the function.
