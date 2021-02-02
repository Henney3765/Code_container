### Random Forest Code
### 2020.02.01
### JeongHyeon Kim
### Encoding: UTF-8

# import packages
library(ranger)
library(caret)

# import data
train <- read.csv(file.choose()) # rt_sales_train.csv
test <- read.csv(file.choose()) # rt_sales_test.csv

# function RMSE
rmse <- function(actual, predict) {
  if(length(actual) != length(predict))
    stop("실제값과 예측값의 길이가 다릅니다. \n")
  
  length <- length(actual)
  errorSum <- sum((actual - predict)^2)
  return(sqrt(errorSum / length))
}

# ******************************************************************************
# 변경사항1: log scale
# ******************************************************************************

# 가격 분포 확인
hist(train$N4)
hist(test$N4)

# 로그 스케일 변환 후 분포 확인
hist(log(train$N4))
hist(log(test$N4))

# 가격(N4)를 로그 스케일로 변환
train_log <- train
test_log <- test
train_log$N4 <- log(train_log$N4)
test_log$N4 <- log(test_log$N4)

# 회귀분석의 경우 mtry = n_feature 하는게 일반적, 따라서 mtry = 15
set.seed(1)
fit_rf_log <- ranger(N4 ~.,
                   data = train_log,
                   mtry = 15,
                   num.trees = 500,
                   splitrule = "variance",
                   min.node.size = 5,
                   importance = "permutation")

# 예측
rf_log_pred <- predict(fit_rf_log, test_log)

# 다시 exp한 이후 rmse비교
rmse(exp(train_log$N4), exp(fit_rf_log$predictions))

rmse(exp(test_log$N4), exp(rf_log_pred$predictions))


# ******************************************************************************
# 변경사항2: type별로 나눠서 진행
# ******************************************************************************

train_apt <- subset(train, N12 == 'apartments')
train_mul <- subset(train ,N12 == 'multi')
train_std <- subset(train, N12 == 'studio')
test_apt <- subset(test, N12 == 'apartments')
test_mul <- subset(test ,N12 == 'multi')
test_std <- subset(test, N12 == 'studio')

train_apt <- train_apt[, -16]
train_mul <- train_mul[, -16]
train_std <- train_std[, -16]
test_apt <- test_apt[, -16]
test_mul <- test_mul[, -16]
test_std <- test_std[, -16]

# apartment model
set.seed(1)
fit_rf_apt <- ranger(N4 ~.,
                     data = train_apt,
                     mtry = 14,
                     num.trees = 300,
                     splitrule = "variance",
                     min.node.size = 5,
                     importance = "permutation"
)
fit_rf_apt_pred <- predict(fit_rf_apt, test_apt)
rmse(test_apt$N4, fit_rf_apt_pred$predictions)

# multi model
set.seed(1)
fit_rf_mul <- ranger(N4 ~.,
                     data = train_mul,
                     mtry = 14,
                     num.trees = 300,
                     splitrule = "variance",
                     min.node.size = 5,
                     importance = "permutation"
)
fit_rf_mul_pred <- predict(fit_rf_mul, test_mul)
rmse(test_mul$N4, fit_rf_mul_pred$predictions)

# studio model
set.seed(1)
fit_rf_std <- ranger(N4 ~.,
                     data = train_std,
                     mtry = 14,
                     num.trees = 300,
                     splitrule = "variance",
                     min.node.size = 5,
                     importance = "permutation"
)
fit_rf_std_pred <- predict(fit_rf_std, test_std)
rmse(test_std$N4, fit_rf_std_pred$predictions)


# ******************************************************************************
# 변경사항3: 가격을 면적으로 나눠서 진행
# ******************************************************************************

# 원본 데이터 냅두고 복사
train_clone <- train
test_clone <- test

# 가격을 면적으로 나눔
train_clone$N4 <- train_clone$N4 / train_clone$N2
test_clone$N4 <- test_clone$N4 / test_clone$N2

# 면적 삭제
train_clone <- train_clone[, -13]
test_clone <- test_clone[, -13]

fit_rf_clone <- ranger(N4 ~.,
                       data = train_clone,
                       mtry = 14,
                       num.trees = 200,
                       splitrule = "variance",
                       min.node.size = 5,
                       importance = "permutation")

# 예측
fit_rf_clone_pred <- predict(fit_rf_clone, test_clone)
rmse(test_clone$N4, fit_rf_clone_pred$predictions)

# 변수중요도
imp <- fit_rf_clone$variable.importance
names(imp) <- c("건축물면적", "사용승인일자", "연면적", "대지면적", "높이",
                "건폐율", "용적율", "X", "Y", "구", "계약년", "계약월", 
                "층", "유형")
options(scipen = 1000)
imp <- sort(imp)
barplot(imp / imp[14] * 100, horiz = TRUE, main = "Variable Importance")



fit_rf_clone_2 <- ranger(N4 ~.,
                       data = train_clone,
                       mtry = 4,
                       num.trees = 200,
                       splitrule = "variance",
                       min.node.size = 5,
                       importance = "permutation")

# 예측
fit_rf_clone_pred_2 <- predict(fit_rf_clone_2, test_clone)
rmse(test_clone$N4, fit_rf_clone_pred_2$predictions)

# 변수중요도
imp <- fit_rf_clone_2$variable.importance
names(imp) <- c("건축물면적", "사용승인일자", "연면적", "대지면적", "높이",
                "건폐율", "용적율", "X", "Y", "구", "계약년", "계약월", 
                "층", "유형")
options(scipen = 1000)
imp <- sort(imp)
barplot(imp / imp[14] * 100, horiz = TRUE, main = "Variable Importance")

fit_rf_clone_3 <- ranger(N4 ~.,
                         data = train_clone,
                         mtry = 2,
                         num.trees = 200,
                         splitrule = "variance",
                         min.node.size = 5,
                         importance = "permutation")

# 예측
fit_rf_clone_pred_3 <- predict(fit_rf_clone_3, test_clone)
rmse(test_clone$N4, fit_rf_clone_pred_3$predictions)

# 변수중요도
imp <- fit_rf_clone_3$variable.importance
names(imp) <- c("건축물면적", "사용승인일자", "연면적", "대지면적", "높이",
                "건폐율", "용적율", "X", "Y", "구", "계약년", "계약월", 
                "층", "유형")
options(scipen = 1000)
imp <- sort(imp)
barplot(imp / imp[14] * 100, horiz = TRUE, main = "Variable Importance")

