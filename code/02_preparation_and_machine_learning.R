# Reading the pre-processed file
data1<- read.csv("C:/Users/pulki/Documents/R projects/Sentiment_Analysis/data/preprocessed_data.csv")

# Load the necessary libraries
library(text2vec)
library(caTools)
library(xgboost)
library(caret)

# Split the data into features (X) and target (y)
X <- data1$cleaned_text
y <- data1$label

# Convert the text data into numerical vectors
it <- itoken(X, progressbar = FALSE)
v <- create_vocabulary(it)
vectorizer <- vocab_vectorizer(v)
dtm <- create_dtm(it, vectorizer)

# Split the data into training and testing sets
set.seed(123)
split <- sample.split(y, SplitRatio = 0.8)
X_train <- dtm[split, ]
y_train <- y[split]
X_test <- dtm[!split, ]
y_test <- y[!split]

# Print the shapes of the training and testing sets
cat("Training set:", dim(X_train), "y_train:", length(y_train), "\n")
cat("Testing set:", dim(X_test), "y_test:", length(y_test), "\n")

# Let's try xgboost

# Convert the sparse matrix to a format xgboost can handle
dtrain <- xgb.DMatrix(X_train, label = y_train)
dtest <- xgb.DMatrix(X_test, label = y_test)

# Set parameters for the xgboost model
params <- list(
  objective = "multi:softmax",
  num_class = length(unique(y_train)),
  max_depth = 6,
  eta = 0.3
)

# Train the xgboost model
model <- xgb.train(params, dtrain, nrounds = 100)

# Make predictions on the test data
predictions <- predict(model, dtest)

# Evaluate the model
accuracy <- sum(predictions == y_test) / length(y_test)
print(paste("Accuracy:", accuracy))

# We get an accuracy of 87.42%, which looks pretty good. 

# Let's try to find the best parameters for this model by trying out a few different ones and comparing them together

# Define the parameter grid
param_grid <- list(
  eta = c(0.1, 0.3, 0.5),
  max_depth = c(3, 6, 9),
  subsample = c(0.7, 0.8, 0.9),
  colsample_bytree = c(0.7, 0.8, 0.9)
)

# Perform grid search
cv_results <- xgb.cv(
  params = params,
  data = dtrain,
  nfold = 5,
  nrounds = 100,
  metrics = "mlogloss",
  grid = param_grid,
  verbose = TRUE
)

# Get the best parameters
best_params <- cv_results$best_params

# best_params has NULL value


# Let's see how accurately each emotion is being predicted

# Convert the predictions and actual values to factors
predictions_factor <- as.factor(predictions)
y_test_factor <- as.factor(y_test)

# Create a confusion matrix
cm <- confusionMatrix(predictions_factor, y_test_factor)

# Print the confusion matrix
print(cm)

# Calculate precision, recall, and F1-score for each class
precision <- cm$byClass[, "Precision"]
recall <- cm$byClass[, "Recall"]
F1 <- cm$byClass[, "F1"]

# Print precision, recall, and F1-score for each class
print(paste("Precision:", precision))
print(paste("Recall:", recall))
print(paste("F1-score:", F1))


# From the confusion matrix and the statistics, we can infer the following:
#   
#   Overall Accuracy: The overall accuracy of the model is 87.43%, which means the model correctly predicted the emotion 87.43% of the time.

# Class-wise Performance:

#   Sadness (0): The model has a high precision (92.11%) and recall (90.69%) for predicting ‘sadness’, indicating that it is performing well for this class.
# Joy (1): The model also performs well in predicting ‘joy’ with a precision of 89.06% and recall of 89.72%.
# Love (2): The precision and recall drop for ‘love’ to 75.58% and 76.37% respectively, indicating that the model has some difficulty in correctly predicting this emotion.
# Anger (3): The model performs well in predicting ‘anger’ with a precision of 90.22% and recall of 84.07%.
# Fear (4): The model has a good precision (85.79%) and recall (82.98%) for predicting ‘fear’.
# Surprise (5): The precision drops significantly for ‘surprise’ to 65.88%, but the recall is high at 91.95%. This indicates that while the model is able to capture most of the ‘surprise’ instances, it also incorrectly classifies other emotions as ‘surprise’.

# Balanced Accuracy: The balanced accuracy for each class is quite high (ranging from 87.07% to 95.09%), indicating that the model performs well across all classes, not just the majority class.

# F1-score: The F1-score, which is the harmonic mean of precision and recall, gives us a single metric to evaluate the model. The F1-scores for the different classes range from 75.98% (‘love’) to 91.39% (‘sadness’), indicating that the model performs best for ‘sadness’ and worst for ‘love’.

# In conclusion, the model performs well overall, but there is room for improvement, especially for the ‘love’ and ‘surprise’ classes.