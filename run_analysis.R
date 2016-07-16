# download file from given link
if (!file.exists("Get&Clean")) {dir.create("Get&Clean")}
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./Get&Clean/wearablecomputing.zip", method = "curl")
unzip("./Get&Clean/wearablecomputing.zip", exdir = "./Get&Clean")
list.files("./Get&Clean")

# import label files into R
actlabel <- read.table("./Get&Clean/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./Get&Clean/UCI HAR Dataset/features.txt")

names(actlabel) <- c("activityID", "activity")

# import test data & rename column names
test_sub <- read.table("./Get&Clean/UCI HAR Dataset/test/subject_test.txt")
test_x <- read.table("./Get&Clean/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./Get&Clean/UCI HAR Dataset/test/y_test.txt")

names(test_sub) <-"subjectID"
names(test_y) <- "activityID"
names(test_x) <- features[,2]

# import training data & rename column names
train_sub <- read.table("./Get&Clean/UCI HAR Dataset/train/subject_train.txt")
train_x <- read.table("./Get&Clean/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./Get&Clean/UCI HAR Dataset/train/y_train.txt")

names(train_sub) <-"subjectID"
names(train_y) <- "activityID"
names(train_x) <- features[,2]

# combine all test & train data into 1 table
testfull <- cbind(test_sub, test_y, test_x)
trainfull <- cbind(train_sub, train_y, train_x)

fuldat <- rbind(testfull, trainfull)

# extracts only the measurements on the mean and standard deviation for each measurement
match <- c("mean\\(\\)","std\\(\\)","subjectID","activityID")
matchvect <- grep(paste(match, collapse="|"), names(fuldat), ignore.case = TRUE)

fuldat <- fuldat[matchvect]

# uses descriptive activity names to name the activities in the data set
fuldata <- merge(fuldat,actlabel,by = "activityID", all.x = TRUE)

# appropriately labels the data set with descriptive variable names
names(fuldata)<-gsub("^t","time",names(fuldata))
names(fuldata)<-gsub("^f","freq",names(fuldata))
names(fuldata)<-gsub("BodyBody","Body",names(fuldata))
remove <- c("[(]","[)]") 
names(fuldata)<-gsub(paste(remove,collapse = "|"),"",names(fuldata))

# creates tidy data set with the average of each variable for each activity and each subject
aggdata <- aggregate(.~subjectID + activity, fuldata, mean)         
aggdata <- aggdata[order(aggdata$subjectID,aggdata$activity),]
write.table(aggdata, file = "tidydata.txt",sep = "\t" ,row.name=FALSE)


