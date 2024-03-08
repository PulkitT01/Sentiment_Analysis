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
corpus_outside <- Corpus(VectorSource(data$text))

preprocesstext <- function(corpus){
  # Unnecessary variable created inside the function
  unnecessary_var <- "This is unnecessary"
  
  # Save the environment inside the function
  env_inside <- environment()
  
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
  
  return(list(corpus = corpus, env_inside = env_inside))
}

# Pre-process the text
# Call the function and save the outputs as variables
output <- preprocesstext(corpus_outside)
corpus <- output$corpus
env_inside <- output$env_inside

# Print out the contents of the environments
print("Contents of the environment outside the function:")
print(ls(envir = environment()))

print("Contents of the environment inside the function:")
print(ls(envir = env_inside))

# When printing the contents of the environment outside the function, I observe a list of variables including "corpus", "cleaned_text", "plot", and others. This environment captures the variables defined in the global scope.
# 
# When inspecting the environment inside the function, I notice fewer variables compared to the global environment. This environment includes "corpus", "env_inside", and an additional variable named "unnecessary_var". This variable was created within the function but is not needed outside, demonstrating the scoping and encapsulation of variables within functions.

corpus_inside <- corpus

# Check if the corpus variable inside and outside the function points to the same memory address
cat("Memory address of corpus outside the function:", tracemem(corpus_outside), "\n")
cat("Memory address of corpus inside the function:", tracemem(corpus_inside), "\n")

# The memory addresses for corpus_outside and corpus_inside differ because each variable exists within its respective scope. Variables declared outside the function (corpus_outside) and those created within it (corpus_inside) occupy distinct memory locations due to the scoping rules in R. As a result, changes made to corpus_inside within the function do not affect corpus_outside outside the function's scope. This encapsulation principle ensures that modifications made within a function remain isolated, reflecting the notion: "What happens in the function stays in the function."


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
