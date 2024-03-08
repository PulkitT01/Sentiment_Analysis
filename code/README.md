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
- Save the pre-processed data to a CSV file.

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

### Additional Functionality and Insights:
- **Variable Scoping and Environments**: The script demonstrates the concept of variable scoping and environments in R. It illustrates how variables created within a function are encapsulated within their own environment, distinct from the global environment. This is exemplified by the creation of an unnecessary variable within the `preprocesstext` function and the observation of different contents and memory addresses for variables inside and outside the function.

- **Benchmarking Performance**: A benchmarking comparison between `sapply` and `lapply` functions is conducted to assess the efficiency of different approaches in converting the corpus to a character vector. This benchmarking provides insights into the relative performance of these functions, aiding in optimization and code efficiency.

- **Detailed ReadME Updates**: The README file now includes detailed instructions for usage, including updating file paths and running the script in an R environment. Additionally, it outlines the contents of the script and its purpose, providing comprehensive guidance for users.



## 02_preparation_and_machine_learning.R

This code file, "02_preparation_and_machine_learning.R", contains R code for preparing the pre-processed data and training a machine learning model for sentiment analysis. Below is a summary of the tasks performed in this code:

1. **Data Preparation**: Reads the pre-processed data file and splits it into features (X) and target (y).

2. **Vectorization**: Converts the text data into numerical vectors using the text2vec package.

3. **Data Splitting**: Splits the data into training and testing sets.

4. **Model Training**: Trains an XGBoost model on the training data.

5. **Model Evaluation**: Evaluates the model's accuracy on the testing data and prints the confusion matrix, precision, recall, and F1-score for each class.

### Results

The model achieved an overall accuracy of 87.43% on the testing data. Additionally, class-wise performance metrics such as precision, recall, and F1-score were computed for each sentiment category. The model performed well across most categories, with room for improvement particularly in predicting 'love' and 'surprise' sentiments.

### Instructions

To run the code:

1. Ensure that the necessary R libraries (text2vec, caTools, xgboost, caret) are installed.
2. Make sure the pre-processed data file is available at the specified location.
3. Run the code file "02_preparation_and_machine_learning.R" in your R environment.
