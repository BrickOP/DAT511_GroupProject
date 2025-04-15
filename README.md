---
title: "README"
author: "Alyssa Okon, Nuzaif Naveed, & Christie McGee-Ross"
date: "2025-04-12"
output: pdf_document
---

**Human Activity Recognition – Tidy Dataset Project**

##Project Overview

This repository contains a data cleaning and tidying project based on the UCI Human Activity Recognition Using Smartphones dataset. The dataset originates from experiments in which 30 subjects wore Samsung Galaxy S smartphones while performing six distinct activities (e.g., walking, sitting, standing). The raw data were collected from the embedded accelerometer and gyroscope sensors, resulting in a complex, multi-file dataset.

##Project Objectives:

-Merge Training and Test Sets: Combine the separate training and testing datasets into one unified dataset.

-Extract Key Measurements: Filter the dataset to retain only the measurements on the mean and standard deviation for each feature.

-Assign Descriptive Activity Names: Replace numeric activity codes with descriptive labels (e.g., "WALKING", "SITTING").

-Label Variables with Descriptive Names: Clean and expand abbreviated variable names for better clarity.

-Create a Tidy Dataset: Generate a second dataset that contains the average of each variable for each subject-activity pair, making it ideal for subsequent analysis.

##Repository Contents
File	Description
GroupWork.R	Main R script that performs the complete data cleaning and transformation process.
final_tidy_dataset.txt	The final, cleaned, and summarized tidy dataset, ready for further analysis.
CodeBook.md	Detailed documentation of the dataset—descriptions of variables, units, transformations, and processing steps.
README.md	This file: an overview of the project, step-by-step instructions for running the analysis, and details about the analysis process.

##How to Run the Script
Prerequisites
R: Ensure that a recent version of R is installed.

Required R Packages:

dplyr

data.table (if needed)
Install these packages using:

install.packages("dplyr")
install.packages("data.table")

## Running the Analysis
Clone or Download the Repository:
Make sure the repository is saved on your local machine.

Set Your Working Directory:
In R or RStudio, set the working directory to the repository folder:

setwd("path/to/repository")
Execute the Main Script:
Run the main R script that performs all data processing steps:

source("GroupWork.R")
The script will:

- Download and/or unzip the dataset if needed.

- Load separate training and test files.

- Merge the datasets.

- Extract only the measurements on the mean and standard deviation.

- Replace numeric activity codes with descriptive names.

- Clean and properly label the variable names.

- Create a final tidy dataset where each row corresponds to the average of each measurement variable for each subject-activity combination.

Check the Output:
After the script finishes running, the file final_tidy_dataset.txt will be generated in your working directory.

## Analysis Process
The analysis process implemented in this project follows these steps:

Data Loading and Merging:
The raw dataset is split into training and test sets, each containing separate files for subjects, activities, and feature measurements. The R script reads these files and uses cbind() and rbind() to merge the data into one comprehensive dataset. This ensures all observations are in a single table for subsequent operations.

Feature Extraction:
From the original 561 features, only those containing the strings mean() or std() are retained. These features represent the mean and standard deviation of various measurements, which are crucial for many statistical analyses and machine learning tasks. Special care is taken to match the sanitized variable names created by R.

Assigning Descriptive Labels:
The numeric activity labels are converted into descriptive names (e.g., "WALKING", "SITTING"), making the dataset more interpretable. Additionally, the feature variable names are transformed to replace abbreviations (such as "Acc" and "Gyro") with more descriptive terms (like "Accelerometer" and "Gyroscope"), and prefixes are added (e.g., "Time_" for time-domain signals and "Frequency_" for frequency-domain signals).

Creating the Tidy Data Set:
The cleaned dataset is then grouped by the subject and activity columns. The script calculates the average (mean) of each measurement variable for each group. This results in a tidy dataset where every row is uniquely identified by a subject-activity pair and columns represent the average values of each measurement.

Output:
Finally, the tidy data is exported as final_tidy_dataset.txt ensuring the data is in a format that complies with tidy data principles (each variable in one column, each observation in one row, and each type of observational unit in its own table). This format is highly suitable for further analysis, visualization, or predictive modeling.

## Why It Matters
Transforming raw sensor data into a tidy dataset enables:

Easier Analysis: Clean and structured data simplifies exploratory data analysis, visualization, and statistical testing.

Reproducibility: Using a well-documented processing pipeline ensures that other researchers can replicate or build on this work.

Modeling Applications: The tidy dataset serves as a robust foundation for applying machine learning techniques to predict human activities, contributing to advancements in health monitoring, fitness tracking, and smart device interaction.

For detailed variable descriptions, transformations, and the complete data processing rationale, refer to the CodeBook.md.

