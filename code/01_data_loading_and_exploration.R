# Load necessary libraries
library(microbenchmark)
library(tidyverse)
library(tidytext)
library(ggplot2)
library(stringr)
library(tm)

# Use searchpaths() to see all the currently loaded packages
searchpaths()

# The output of `searchpaths()` reveals all paths searched by R to locate functions and data. It includes explicitly loaded libraries, implicit dependencies, system directories, autoloads, and RStudio tools, ensuring accessibility of required resources.


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
plot <- ggplot(data, aes(x=emotion)) +
  geom_histogram(stat="count") +
  xlab("Emotion") +
  ylab("Count") +
  ggtitle("Histogram of Emotions") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, color = "black"), 
        plot.background = element_rect(fill = "white"))  

# Saving this plot in figures folder
ggsave("C:/Users/pulki/Documents/R projects/Sentiment_Analysis/figures/histogram_emotions.png", plot, width = 8, height = 6, units = "in")


# Let's do some pre-processing to the data

# Create a Corpus
corpus <- Corpus(VectorSource(data$text))

preprocesstext <- function(corpus){
  # Convert text to lowercase
  corpus <- tm_map(corpus, tolower)
  
  # Remove punctuation
  corpus <- tm_map(corpus, removePunctuation)
  
  # Remove numbers
  corpus <- tm_map(corpus, removeNumbers)
  
  # Remove stopwords from the corpus
  corpus <- tm_map(corpus, removeWords, stopwords("english"))
  
  # Apply stemming transformation to the corpus
  corpus <- tm_map(corpus, stemDocument)
  
  return(corpus)
}

# Pre-process the text
corpus <- preprocesstext(corpus)

# Convert the corpus back to a character vector
cleaned_text <- sapply(corpus, as.character)


# Let's see if there's a difference in efficiency if the same task is done by using lapply instead of sapply

# Define the functions to be benchmarked
f_sapply <- function(corpus) {
  sapply(corpus, as.character)
}

f_lapply <- function(corpus) {
  unlist(lapply(corpus, as.character))
}

# Perform the benchmarking
bench <- microbenchmark(
  sapply = f_sapply(corpus),
  lapply = f_lapply(corpus),
  times = 100
)

# Plot the results
autoplot(bench)

# Save the benchmark plot
ggsave("C:/Users/pulki/Documents/R projects/Sentiment_Analysis/figures/benchmark_plot.png", autoplot(bench), width = 8, height = 6, units = "in")


# Adding the cleaned_text back to the original dataframe
data$cleaned_text <- cleaned_text

# View the head of the data frame with the new cleaned_text column
head(data)

# Save the preprocessed data to a CSV file
write.csv(data, file = "C:/Users/pulki/Documents/R projects/Sentiment_Analysis/data/preprocessed_data.csv", row.names = FALSE)
