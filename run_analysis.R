getwd()
setwd("~/Desktop/R/Coursera/data cleaning/courseproject/UCI HAR Dataset")
###step 1

trainx  <- read.table("train/X_train.txt")
testx  <- read.table("test/X_test.txt")
datax  <- rbind(trainx,testx)
str(datax)
trainlables  <- read.table("train/y_train.txt")
testlables  <- read.table("test/y_test.txt")
datalables  <- rbind(trainy,testy)

trainsubject  <- read.table("train/subject_train.txt")
testsubject  <- read.table("test/subject_test.txt")
datasubject  <- rbind(trainsubject,testsubject)

###step 2
features  <- read.table("features.txt")
neededcol  <- grep("-(mean|std)\\(\\)", features[,2])
datax  <- datax[,neededcol]

###step 3
activities  <- read.table("activity_labels.txt")
datay[,1]  <- activities[datay[,1],2]

###step 4
names(datax)  <- features[neededcol,2]
names(datay)  <- "activity"
names(datasubject)  <- "subject"
onedataset  <- cbind(datax,datay,datasubject)
names(onedataset)

###step5
library(plyr)
averagedata  <- ddply(onedataset,c("subject","activity"),function(onedataset) colMeans(onedataset[, 1:66]))
write.table(averagedata, "averagedata.txt", row.name=FALSE)
data  <- read.table("averagedata.txt", header=TRUE)

