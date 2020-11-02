### particulate matter predict
### 2020.10.31
### Jeonghyeon Kim

# import packages
library(car)
library(mice)

# import data
data <- read.csv("total_data.csv")
data <- data[, -1]
str(data)


## EDA
summary(data)
ex <- na.omit(data)
plot(data$temp, data$PM10)
plot(data$prec, data$PM10)
plot(data$windV, data$PM10)
plot(data$windD, data$PM10)
plot(data$vaporP, data$PM10)
plot(data$totalcloud, data$PM10)

## NA 처리
# 결측치 비율 확인 함수
pMiss <- function(x){sum(is.na(x)) / length(x)*100}
apply(data, 2, pMiss)

# sunhr, insolation, visibility -> 결측치가 너무 많아서 변수 삭제
data <- data[, c(-12, -13, -16)]

# 결측치 대체
mice_result <- mice(data, seed = 1234, m = 5)
mice_result

data <- complete(mice_result, 1)
str(data)

# devide train, test dataset
set.seed(1)
trainIdx <- sample(1:nrow(data), size = 0.7 * nrow(data))
train <- data[trainIdx , ]
test <- data[-trainIdx, ]

## MLR_1
pm_MLR_1 <- lm(PM10 ~ ., data = train, na.action = na.omit)
summary(pm_MLR_1)

# p-value가 높은 localP, sealevelP 제거
data <- data[, c(-10, -11)]


# re-devide train, test dataset
set.seed(1)
trainIdx <- sample(1:nrow(data), size = 0.7 * nrow(data))
train <- data[trainIdx , ]
test <- data[-trainIdx, ]

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
vif(pm_MLR_1)

# dewpoint 삭제
data <- data[, -9]

# devide train, test dataset
set.seed(1)
trainIdx <- sample(1:nrow(data), size = 0.7 * nrow(data))
train <- data[trainIdx , ]
test <- data[-trainIdx, ]

## MLR_2
pm_MLR_2 <- lm(PM10 ~ ., data = train, na.action = na.omit)
summary(pm_MLR_2)
pm_MLR_pred_2 <- predict(pm_MLR_2, test)

# 다중공산성 확인
vif(pm_MLR_2)

# rmse of MLR_2
rmse(test$PM10, pm_MLR_pred_2)

# visualization
par(mfrow = c(2, 2))
plot(pm_MLR_2)

################################################################################

## randomForest
# import packages
library(caret)
library(ranger)

# Modeling
model_grid <- expand.grid(mtry = 4, splitrule = "variance",
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
