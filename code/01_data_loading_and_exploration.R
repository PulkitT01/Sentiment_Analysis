# Load necessary libraries
library(tidyverse)
library(tidytext)
library(ggplot2)
library(stringr)
library(tm)

# Import the data
data<- read.csv("C:/Users/pulki/Documents/R projects/Sentiment_Analysis/data/text.csv")

# View the first few rows to see what the data is like
head(data)

# Get the summary of the data
summary(data)

# Check for missing values
sum(is.na(data))

# Explore the distribution of labels in the data
table(data$label)

# Defining a mapping from labels to emotions
label_to_emotion<- c("sadness", "joy", "love", "anger", "fear", "surprise")

# Create a new column "emotion" by mapping "label" column to emotions
data$emotion<- label_to_emotion[data$label+1]

# Plotting the histogram of emotions
ggplot(data, aes(x=emotion)) +
  geom_histogram(stat="count") +
  xlab("Emotion") +
  ylab("Count") +
  ggtitle("Histogram of Emotions") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))  # This line centers the title

# Now, we need to do some preprocessing to the data. We use tidytext library for this.

clean_text <- function(text) {
  # making the text lowercase
  data$text<- tolower(data$text)
  
  # removing text in square brackets
  data$text <- gsub("\\[.*?\\]", "", data$text)
  
  # removing links
  data$text <- gsub("https?://\\S+|www\\.\\S+", "", data$text)
  
  # removing punctuation
  data$text <- gsub("[[:punct:]]", "", data$text)
  
  # removing words containing numbers
  data$text <- gsub("\\w*\\d\\w*", "", data$text)
  
  return(data$text)
  
}  

# Applying the clean_text() function to the "text" column of the dataset
data$cleaned_text <- clean_text(data)

# Viewing the head of the dataset with the new cleaned_text column
head(data)
