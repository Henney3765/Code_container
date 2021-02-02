### Random Forest Code
### 2020.10.20
### JeongHyeon Kim
### Encoding: UTF-8

# import packages
library(ranger)
library(caret)

# import data
train <- read.csv(file.choose()) # rt_sales_train.csv
test <- read.csv(file.choose()) # rt_sales_test.csv

# modeling
# hyperparameter gird
model_grid <- expand.grid(mtry = c(2, 4, 8), splitrule = "variance",
                          min.node.size = 5)

# model training
for (i in 1:6) {
  print(paste("트리 개수:", 50*i))
  
  set.seed(1)
  fit <- train(N4 ~ .,
               data = train,
               method = "ranger",
               trControl = trainControl(method = "cv", number = 10, 
                                        allowParallel = TRUE, verbose = TRUE),
               tuneGrid = model_grid,
               importance = "impurity",
               num.trees = 50 * i)
  
  assign(paste0("fit_", i), fit)
}

# Define RMSE function
rmse <- function(actual, predict) {
  if(length(actual) != length(predict))
    stop("실제값과 예측값의 길이가 다릅니다. \n")
  
  length <- length(actual)
  errorSum <- sum((actual - predict)^2)
  return(sqrt(errorSum / length))
}

# prediction
for (i in 1:6) {
  print(paste("모델", i, "의 예측"))
  
  pred <- predict(eval(parse(text = paste0("fit_", i))), test)
  assign(paste0("pred_", i), pred)
}

# model ~ rmse
for (i in 1:6) {
  print(rmse(test$N4, eval(parse(text=paste0("pred_", i)))))
}

# model ~ R-squared
fit_1$finalModel$r.squared
fit_2$finalModel$r.squared
fit_3$finalModel$r.squared
fit_4$finalModel$r.squared
fit_5$finalModel$r.squared
fit_6$finalModel$r.squared

# save predict value(fit_6)
write.csv(pred_6 ,"pred_rf.csv")

# variable importance
varImp(fit_6)
