# 1. Loading the data!

act_labels <- read.table("./activity_labels.txt")
head(act_labels)
str(act_labels)

features <- read.table("./features.txt")
head(features)
str(features)

## Train data
subj_train <- read.table("./train/subject_train.txt")
head(subj_train)
x_train <- read.table("./train/X_train.txt")
head(x_train)
str(x_train)
y_train <- read.table("./train/y_train.txt")
head(y_train)

## Test data
subj_test <- read.table("./test/subject_test.txt")
head(subj_test)
x_test <- read.table("./test/X_test.txt")
head(x_test)
y_test <- read.table("./test/y_test.txt")
head(y_test)

## Extract only feature descriptions to be used as header!
feat_header <- gsub("-","",features$V2)

# 2. Adding column names!

## Adding the column names!
colnames(x_train)<-c(feat_header)
colnames(y_train)<-c("trainlabels")
colnames(subj_train)<-c("subject")
colnames(x_test)<-c(feat_header)
colnames(y_test)<-c("trainlabels")
colnames(subj_test)<-c("subject")
colnames(act_labels)<-c("id","description")

# 3. Merging all data

## Merging x_train, y_train and subj_train first
train_data <- cbind(x_train, y_train, subj_train)
dim(train_data)

## Merging x_test, y_test and subj_test second
test_data <- cbind(x_test, y_test, subj_test)
dim(test_data)

## Mergind train and test data!
merged_data <- rbind(train_data, test_data)
dim(merged_data)

# 4. Extraction of measurements for mean and std

merged_mstd <- merged_data[,grep("mean|std|trainlabels|subject",names(merged_data))]

# 5. Adding the description of the label activities in the merged dataframe

library(plyr)
merged <- merge(merged_mstd, act_labels, by.x = "trainlabels", by.y = "id", all=TRUE)
library(dplyr)
merged <- rename(merged, trainid=trainlabels, traindescription=description)

# 6. Computing mean for every column (other than subject and traindescription)
# based on values in traindescription and subject

install.packages("reshape2")
library(reshape2)
var_columns<-select(merged, "tBodyAccmean()X":"fBodyBodyGyroJerkMagmeanFreq()")
merged_melt <- melt(merged, id=c("subject", "traindescription"), measure.vars = names(var_columns))
final <- dcast(merged_melt, subject+traindescription~variable, mean)

# 7. Write down to a file

write.table(final,"./final_set.txt", row.name=FALSE)
