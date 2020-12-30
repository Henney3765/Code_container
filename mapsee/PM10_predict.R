### particulate matter predict
### 2020.10.31
### Jeonghyeon Kim

# import packages
library(caret)
library(ranger)
library(xgboost)
library(missForest)
library(tidyverse)
library(VIM)

# import data
data <- read.csv("total_data.csv")
data <- data[, -1]
str(data)

## EDA
# 결측치 확인
map(data, is.na) %>%
    map_df(., sum) %>%
    gather(variable, miss_num) %>%
    arrange(desc(miss_num))

# 결측치 시각화
missing_plot <- VIM::aggr(data, col=c('lightgreen','red'),
                          numbers=FALSE, sortVars=TRUE,
                          labels=names(data), cex.axis=.7,
                          combined = FALSE,
                          gap=3, ylab=c("Missing data","Pattern"))

# 강수량 NA -> 0으로 대체
data$prec[is.na(data$prec) == 1] <- 0

# 결측값이 너무 많은 visibility, sunhr, insolation 제외
# data <- data[, c(-12, -13, -16)]
# str(data)

# 결측치 내삽
data_imp_df <- missForest(data, ntree = 50, mtry = 10, verbose = TRUE)
# 결측치 정제한 데이터 저장
# write.csv(data_imp_df$ximp, "refine_data.csv")
data <- data_imp_df$ximp

# 데이터 정규화
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

data_normalized <- data
for (i in 1:20) {
  data_normalized[, i] <- normalize(data[, i])
}

summary(data_normalized)
################################################################################
## 평가지표
# RMSE
rmse <- function(actual, predict) {
  if(length(actual) != length(predict))
    stop("실제값과 예측값의 길이가 다릅니다. \n")
  
  length <- length(actual)
  errorSum <- sum((actual - predict)^2)
  return(sqrt(errorSum / length))
}

# MAE
mae <- function(actual, predict){
  if(length(actual) != length(predict))
    stop("실제값과 예측값의 길이가 다릅니다. \n")
  
  length <- length(actual)
  errorSum <- sum(abs(actual - predict))
  return(errorSum / length)
}





################################################################################
# 데이터 분할
set.seed(1234)
trainIdx <- sample(1:nrow(data), nrow(data)*0.7)
train <- data[trainIdx, ]
test <- data[-trainIdx, ]

## randomForest
model_grid <- expand.grid(mtry = c(2, 4, 8, 16), 
                          splitrule = "variance",
                          min.node.size = 5)
set.seed(1234)
for (i in 1:4) {
  model_rf <- train(PM10 ~.,
                    data = train,
                    method = "ranger",
                    trControl = trainControl(method = "cv", number = 10,
                                             allowParallel = TRUE, verbose = TRUE),
                    tuneGrid = model_grid,
                    importance = "impurity",
                    num.trees = 50*i)
  
  assign(paste0("model_rf_", i), model_rf)
}

# predict
pred_1 <- predict(model_rf_1, test)
pred_2 <- predict(model_rf_2, test)
pred_3 <- predict(model_rf_3, test)
pred_4 <- predict(model_rf_4, test)

rmse(test$PM10, pred_1)
rmse(test$PM10, pred_2)
rmse(test$PM10, pred_3)
rmse(test$PM10, pred_4)

################################################################################

## gradient boosting
train_mat <- data.matrix(train)
test_mat <- train %>% pull(PM10)

xgb_grid <- expand.grid(subsample = seq(0.2, 0.8, by = 0.1),
                        max_depth = seq(3, 10, by = 1),
                        eta = seq(0.01, 0.05, by = 0.01),
                        nround = seq(50, 300, by = 50))

xgb_rmse_box <- c()
for (i in 1:nrow(xgb_grid)) {
  model_xgb <- xgboost(data = train_mat[, -16], 
                       label = test_mat,
                       booster = "gbtree",
                       nrounds = xgb_grid[i, ]$nround,
                       metrics = "rmse",
                       nfold = 5,
                       subsample = xgb_grid[i, ]$subsample,
                       max_depth = xgb_grid[i, ]$max_depth,
                       eta = xgb_grid[i, ]$eta)
  
  pred_xgb <- predict(model_xgb, data.matrix(test)[, -16])
  xgb_rmse_box <- c(xgb_rmse_box, rmse(test$PM10, pred_xgb))
}

# 최적결과 위치찾기
which(xgb_rmse_box == min(xgb_rmse_box))
xgb_grid[1390, ]

# 모델링
set.seed(1234)
model_xgb_final <- xgboost(data = train_mat[, -16], 
                     label = test_mat,
                     booster = "gbtree",
                     nrounds = 250,
                     metrics = "rmse",
                     nfold = 5,
                     subsample = 0.5,
                     max_depth = 9,
                     eta = 0.05)
xgboost::xgb.ggplot.importance(xgb.importance(feature_names = colnames(train),
                                              model = model_xgb_final))
pred_xgb <- predict(model_xgb_final, data.matrix(test)[, -16])
rmse(test$PM10, pred_xgb)

################################################################################
## 정규화 이후 다시 수행
# 데이터 분할
set.seed(1234)
trainIdx <- sample(1:nrow(data_normalized), nrow(data_normalized)*0.7)
train <- data_normalized[trainIdx, ]
test <- data_normalized[-trainIdx, ]

## randomForest
model_grid <- expand.grid(mtry = c(2, 4, 8, 16), 
                          splitrule = "variance",
                          min.node.size = 5)
set.seed(1234)
for (i in 1:4) {
  model_rf_nor <- train(PM10 ~.,
                    data = train,
                    method = "ranger",
                    trControl = trainControl(method = "cv", number = 10,
                                             allowParallel = TRUE, verbose = TRUE),
                    tuneGrid = model_grid,
                    importance = "impurity",
                    num.trees = 50*i)
  
  assign(paste0("model_rf_nor_", i), model_rf_nor)
}

# predict
pred_nor_1 <- predict(model_rf_nor_1, test)
pred_nor_2 <- predict(model_rf_nor_2, test)
pred_nor_3 <- predict(model_rf_nor_3, test)
pred_nor_4 <- predict(model_rf_nor_4, test)

rmse(test$PM10, pred_nor_1)
rmse(test$PM10, pred_nor_2)
rmse(test$PM10, pred_nor_3)
rmse(test$PM10, pred_nor_4)

mae(test$PM10, pred_nor_1)
mae(test$PM10, pred_nor_2)
mae(test$PM10, pred_nor_3)
mae(test$PM10, pred_nor_4)

varImp(model_rf_nor_3)
################################################################################
## 정규화 이후 다시 수행
## gradient boosting
train_mat <- data.matrix(train)
test_mat <- train %>% pull(PM10)


xgb_grid <- expand.grid(subsample = seq(0.2, 0.8, by = 0.1),
                        max_depth = seq(3, 10, by = 1),
                        eta = seq(0.01, 0.05, by = 0.01),
                        nround = seq(50, 300, by = 50))

xgb_rmse_box_nor <- c()
for (i in 1:nrow(xgb_grid)) {
  model_xgb_nor <- xgboost(data = train_mat[, -16], 
                       label = test_mat,
                       booster = "gbtree",
                       nrounds = xgb_grid[i, ]$nround,
                       metrics = "rmse",
                       nfold = 5,
                       subsample = xgb_grid[i, ]$subsample,
                       max_depth = xgb_grid[i, ]$max_depth,
                       eta = xgb_grid[i, ]$eta)
  
  pred_xgb_nor <- predict(model_xgb_nor, data.matrix(test)[, -16])
  xgb_rmse_box_nor <- c(xgb_rmse_box_nor, rmse(test$PM10, pred_xgb_nor))
}

# 최적결과 위치찾기
which(xgb_rmse_box_nor == min(xgb_rmse_box_nor))
xgb_grid[1679, ]
nrow(xgb_grid)

xgb_rmse_box_nor == min(xgb_rmse_box_nor)

# 모델링
set.seed(1234)
model_xgb_final <- xgboost(data = train_mat[, -16], 
                           label = test_mat,
                           booster = "gbtree",
                           nrounds = 300,
                           metrics = "rmse",
                           nfold = 5,
                           subsample = 0.7,
                           max_depth = 10,
                           eta = 0.05)

xgboost::xgb.importance(feature_names = colnames(train_mat[, -16]), 
                        model = model_xgb_final)



pred_xgb <- predict(model_xgb_final, data.matrix(test)[, -16])
rmse(test$PM10, pred_xgb)
mae(test$PM10, pred_xgb)
