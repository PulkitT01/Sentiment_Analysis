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

