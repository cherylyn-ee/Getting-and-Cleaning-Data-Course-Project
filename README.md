# Getting-and-Cleaning-Data-Course-Project
Run run_analysis.R to obtain tidydata.txt which summarises mean and standard deviation measurements by subject code & activity type.
run_analysis.R does the following:
  1. Creates a folder (Get&Clean) to store file 
  2. Downloads file from url and unzips content (UCI HAR Dataset)
  3. Imports label files into R - activity labels (actlabel & features of measurements (features)
  4. Imports test data & label variables using label files
  5. Imports train data & label variables using label files
  6. Combines both test & train data
  7. Extracts only the measurements on the mean and standard deviation for each measurement
  8. Cleans variable names & labels data with descriptive names
  9. Summarises each variable by activity & subject ID
  10. Creates "tidydata.txt" (tab delimited) from the summarised data
