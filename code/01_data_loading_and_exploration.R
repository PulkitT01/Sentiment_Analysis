# Load necessary libraries
library(tidyverse)
library(tidytext)
library(ggplot2)

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


