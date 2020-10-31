### 부동산 실거래가 randomForest modeling
### 2020.10.20
### JeongHyeon Kim

# import packages
library(randomForest)
library(ranger)
library(caret)

# import data
# data <- read.csv("rt_sales_Three.csv")
# str(data)
# View(data)
# 
# # transfer character(district, type) as factor
# data$G7 <- factor(data$G7)
# data$N12 <- factor(data$N12)
# 
# # remove comma(,) of N4
# data$N4 <- gsub(",", "", data$N4)
# 
# # transfer character(price) as numeric
# data$N4 <- as.numeric(data$N4)
# 
# # devide train, test dataset
# trainIdx <- sample(1:nrow(data), size = nrow(data)* 0.7)
# train <- data[trainIdx, ]
# test <- data[-trainIdx, ]
# 
# # check portion
# nrow(subset(train, train$N12 == "아파트매매")) / nrow(train)
# nrow(subset(train, train$N12 == "연립매매")) / nrow(train)
# nrow(subset(train, train$N12 == "오피스텔매매")) / nrow(train)
# 
# nrow(subset(test, test$N12 == "아파트매매")) / nrow(test)
# nrow(subset(test, test$N12 == "연립매매")) / nrow(test)
# nrow(subset(test, test$N12 == "오피스텔매매")) / nrow(test)

# save
# write.csv(train, "rt_sales_train.csv", row.names = FALSE)
# write.csv(test, "rt_sales_test.csv", row.names = FALSE)

# RMSE
rmse <- function(actual, predict) {
  if(length(actual) != length(predict))
    stop("실제값과 예측값의 길이가 다릅니다. \n")
  
  length <- length(actual)
  errorSum <- sum((actual - predict)^2)
  return(sqrt(errorSum / length))
}

# import data
train <- read.csv("rt_sales_train.csv", stringsAsFactors = TRUE)
test <- read.csv("rt_sales_test.csv", stringsAsFactors = TRUE)

# modeling
model_grid <- expand.grid(mtry = c(4, 5, 8), splitrule = "variance",
                          min.node.size = 5)
set.seed(1)

fit <- train(N4 ~ .,
             data = train,
             method = "ranger",
             trControl = trainControl(method = "cv", number = 10, 
                                      allowParallel = TRUE, verbose = TRUE),
             tuneGrid = model_grid,
             importance = "impurity",
             num.trees = 3000)
fit

# cheack importance of variable
varImp(fit)

# predict
pred <- predict(fit, test)

# checking RMSE
rmse(test$N4, pred)

# save RData
save(fit, file = "fit.RData")


