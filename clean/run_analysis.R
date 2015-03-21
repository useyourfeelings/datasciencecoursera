#xcc 20150322

#read original data
train_x <- read.table("X_train.txt")
train_y <- read.table("y_train.txt")
train_sub <- read.table("subject_train.txt")

test_x <- read.table("X_test.txt")
test_y <- read.table("y_test.txt")
test_sub <- read.table("subject_test.txt")

#read labels
labels <- read.table("activity_labels.txt")
lv <- labels[2]

#number to string
for(i in 1:length(test_y[[1]]))
{
    test_y[[1]][i] <- as.character(lv[[1]][as.integer(test_y[[1]][i])])
}

for(i in 1:length(train_y[[1]]))
{
    train_y[[1]][i] <- as.character(lv[[1]][as.integer(train_y[[1]][i])])
}

#combine data
#subject test/train walking/sitting.... data
test_bind <- cbind(test_sub, test_y, test_x)
train_bind <- cbind(train_sub, train_y, train_x)

#rbind test data and train data
data_1 <- rbind(test_bind, train_bind)

#read features
features <- read.table("features.txt")
features[[2]] <- as.character(features[[2]])

#set column names
column_names = c("subject", "activity", features[[2]])
colnames(data_1) <- column_names

#delete the useless data
columns_to_keep = grepl("mean", features[[2]]) | grepl("std", features[[2]])
columns_to_keep <- c(TRUE, TRUE, columns_to_keep)
data_2 <- data_1[, columns_to_keep]

#calculate mean
data_3 <- aggregate(. ~ subject + activity, data = data_2, mean)

#write clean_data to file
write.table(data_3, "clean_data.txt", row.names = FALSE)


