# README

## prerequisites

The script is using `dplyr` package, so it should be installed prior to running the script.

## data
Please run run_analysis.R in the directory where UCI HAR Dataset.zip is located and **unzipped**. The directory structure should be as follows:


* UCI HAR Dataset
  * test
    * X_test.txt		
    * subject_test.txt	
    * y_test.txt
  * train
    * X_train.txt		
    * subject_train.txt	
    * y_train.txt
  * README.txt		
  * activity_labels.txt	
  * features.txt		
  * features_info.txt
* run_analysis.R
* UCI HAR Dataset.zip


run_analysis.R script is using variable names defined in `UCI HAR Dataset/features.txt` filtered according to the instructions. After running the script, variable `answer` will contain result required in step 5 of the project.
