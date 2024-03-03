# Code Folder

This folder contains scripts for data loading, exploration, pre-processing, and analysis.

## 01_data_loading_and_exploration.R

This script performs data loading, initial exploration, and pre-processing for sentiment analysis.

### Purpose:
The purpose of this script is to:
- Load the dataset for sentiment analysis.
- Explore the dataset by viewing its structure, summary statistics, and label distribution.
- Plot a histogram of emotions to visualize the distribution of sentiment labels.
- Preprocess the text data by converting it to lowercase, removing punctuation, numbers, stopwords, and applying stemming.
- Save the pre-processed data to a CSV file!

### Usage:
To use this script:
1. Make sure R and the required libraries (tidyverse, tidytext, ggplot2, stringr, tm) are installed.
2. Update the file paths in the script to point to your dataset location and desired output locations.
3. Run the script in an R environment to load, explore, and preprocess the data.

### Contents:
- Libraries: Load necessary libraries for data manipulation and visualization.
- Data Loading: Import the dataset for sentiment analysis.
- Data Exploration: View the structure, summary statistics, and label distribution of the dataset.
- Plotting: Generate a histogram of emotions to visualize label distribution.
- Pre-processing: Perform text preprocessing by converting text to lowercase, removing punctuation, numbers, stopwords, and applying stemming.
- Save Preprocessed Data: Save the preprocessed data to a CSV file.
