### particulate matter predict
### 2020.10.31
### Jeonghyeon Kim

# import packages
library(car)

# import data
data <- read.csv("total_data.csv")
str(data)

## EDA
summary(data)
plot(data$totalcloud, data$PM10)


# NA 처리
data$temp[is.na(data$temp)] <- mean(data$temp, na.rm = TRUE)
data$prec[is.na(data$prec)] <- 0

for (i in 1:ncol(data)) {
  if(sum(is.na(data[, i])) > 0){
    data[, i][is.na(data[, i])] <- mean(data[, i], na.rm = TRUE)
  }
}


# devide train, test dataset
set.seed(1)
trainIdx <- sample(1:nrow(data), size = 0.7 * nrow(data))
train <- data[trainIdx , ]
test <- data[-trainIdx, ]


## MLR_1
pm_MLR_1 <- lm(PM10 ~ ., data = train, na.action = na.omit)
summary(pm_MLR_1)
pm_MLR_pred_1 <- predict(pm_MLR_1, test)

# RMSE
rmse <- function(actual, predict) {
  if(length(actual) != length(predict))
    stop("실제값과 예측값의 길이가 다릅니다. \n")
  
  length <- length(actual)
  errorSum <- sum((actual - predict)^2)
  return(sqrt(errorSum / length))
}

# rmse of MLR
rmse(test$PM10, pm_MLR_pred_1)

# 다중공산성 확인
vif(pm_MLR_3)

# dewpoint, localp, seelevelp, groundtemp 제거
data <- data[, c(-9, -10, -11, -18)]
str(data)

# devide train, test dataset
set.seed(1)
trainIdx <- sample(1:nrow(data), size = 0.7 * nrow(data))
train <- data[trainIdx , ]
test <- data[-trainIdx, ]

## MLR_2
pm_MLR_2 <- lm(PM10 ~ ., data = train, na.action = na.omit)
summary(pm_MLR_2)
pm_MLR_pred_2 <- predict(pm_MLR_2, test)

# 유의하지 않은 독립변수 제거(temp, vaporP)
data <- data[, c(-3, -8)]

# devide train, test dataset
set.seed(1)
trainIdx <- sample(1:nrow(data), size = 0.7 * nrow(data))
train <- data[trainIdx , ]
test <- data[-trainIdx, ]

## MLR_3
pm_MLR_3 <- lm(PM10 ~ ., data = train, na.action = na.omit)
summary(pm_MLR_3)
pm_MLR_pred_3 <- predict(pm_MLR_3, test)

rmse(test$PM10, pm_MLR_pred_3)
coef(pm_MLR_3)


################################################################################

## randomForest
# import packages
library(caret)
library(ranger)

# Modeling
model_grid <- expand.grid(mtry = c(2, 4, 8), splitrule = "variance",
                          min.node.size = 5)

set.seed(1)
fit <- train(PM10 ~ .,
             data = train,
             method = "ranger",
             trControl = trainControl(method = "cv", number = 10,
                                      allowParallel = TRUE, verbose = TRUE),
             tuneGrid = model_grid,
             importance = "impurity",
             num.trees = 2000)
fit$finalModel
varImp(fit)
fit_pred <- predict(fit, test)
rmse(test$PM10, fit_pred)

################################################################################

## gradient boosting
library(xgboost)
trainMat <- data.matrix(train[, -13])
trainLabel <- train$PM10
testMat <- data.matrix(test[, -13])
testLabel <- test$PM10

xgb_model <- xgboost(data = trainMat, label = trainLabel,
                     max.depth = 10, eta = 0.5, subsample = 1, nrounds = 10)
xgb_pred <- predict(xgb_model, testMat)
rmse(test$PM10, xgb_pred)
