# Sentiment Analysis Project

## Introduction

Welcome to the Sentiment Analysis project! In this project, we explore the "Emotions" dataset – a collection of English Twitter messages annotated with six fundamental emotions: anger, fear, joy, love, sadness, and surprise. Through this project, we aim to build a sentiment analysis model to predict the predominant emotion conveyed in short-form text on social media.

## Dataset

The dataset consists of text segments representing Twitter messages and corresponding labels indicating the primary emotion conveyed. Emotions are classified into six categories: sadness (0), joy (1), love (2), anger (3), fear (4), and surprise (5).

**Key Features:**
- **text:** Content of the Twitter message.
- **label:** Classification label indicating the primary emotion.

Dataset Source: [Emotions Dataset on Kaggle](https://www.kaggle.com/datasets/nelgiriyewithana/emotions)

## Project Structure

- **data:** Contains the raw and preprocessed data files.
- **figures:** Stores generated plots and visualizations.
- **scripts:** Includes R scripts for data preprocessing, model training, and evaluation.
- **README.md:** The main project documentation file you're currently reading.

## Getting Started

To replicate this project or contribute to its development, follow these steps:

1. Clone this repository to your local machine.
2. Install necessary R packages listed in the R script files.
3. Run the R scripts in the following order:
   - `01_data_loading_and_exploration.R`: Preprocesses the raw data and saves the preprocessed data.
   - `02_preparation_and_machine_learning.R`: Trains an XGBoost model on the preprocessed data and evaluates its performance.
4. Explore the results and contribute to further improvements.

## Results

The sentiment analysis model achieved an overall accuracy of 87.42% on the test data. Class-wise performance analysis revealed varying precision, recall, and F1-scores for each emotion category.

For detailed analysis and results, refer to the project documentation and generated visualizations.

## Contributor

- [Pulkit](https://github.com/PulkitT01)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

