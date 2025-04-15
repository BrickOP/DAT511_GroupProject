rm(list = ls())

#setwd("C:/Users/19all/Desktop/DAT511/UCI HAR Dataset") - Ally WD
setwd("D:/MS Data Analytics/Fall 2024/DAT 511/Group Project/UCI HAR Dataset") 

#install.packages("tinytex")
#install.packages("dplyr")
#install.packages("tidyverse")
library(dplyr)
library(tidyverse)
# Load feature names and activity labels
features <- read.table("features.txt", col.names = c("index", "feature"))
activity_labels <- read.table("activity_labels.txt", col.names = c("label", "activity"))

# Load training data
X_train <- read.table("train/X_train.txt", col.names = features$feature)
y_train <- read.table("train/y_train.txt", col.names = "activity")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")

# Load test data
X_test <- read.table("test/X_test.txt", col.names = features$feature)
y_test <- read.table("test/y_test.txt", col.names = "activity")
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
# Combine subject, activity, and features for train and test datasets
train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)

# Merge train and test data
merged_data <- rbind(train_data, test_data)


# Select only columns with mean() or std() in their names from original feature names
selected_columns <- grep("mean\\(\\)|std\\(\\)", features$feature, value = TRUE)

# Convert these names to the sanitized format (as in merged_data)
selected_columns_clean <- make.names(selected_columns)

# Keep subject, activity, and the selected measurement columns
tidy_data <- merged_data %>%
  select(subject, activity, all_of(selected_columns_clean))

# Replace numeric activity codes with descriptive names
tidy_data$activity <- factor(tidy_data$activity, 
                             levels = activity_labels$label, 
                             labels = activity_labels$activity)

# Convert variable names to snake_case and improve readability
names(tidy_data) <- names(tidy_data) %>%
  gsub("\\.", "_", .) %>%                           # Replace dots with underscores
  gsub("^t", "time_", .) %>%                        # Prefix 't' becomes 'time_'
  gsub("^f", "frequency_", .) %>%                   # Prefix 'f' becomes 'frequency_'
  gsub("Acc", "accelerometer", .) %>%               # Expand abbreviations
  gsub("Gyro", "gyroscope", .) %>%
  gsub("Mag", "magnitude", .) %>%
  gsub("BodyBody", "Body", .) %>%                   # Fix duplicated word
  gsub("([a-z])([A-Z])", "\\1_\\2", .) %>%          # Add underscore between camelCase
  tolower() %>%                                     # Convert to lowercase
  gsub("_+", "_", .) %>%                            # Remove multiple underscores
  gsub("_$", "", .)                                 # Remove trailing underscores

# Create the final tidy dataset with the average of each variable for each subject and activity
final_tidy_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

# Save the final tidy dataset to a text file
write.table(final_tidy_data, "final_tidy_dataset.txt", row.name = FALSE)


