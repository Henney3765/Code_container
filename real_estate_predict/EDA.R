## 부동산실거래가 EDA

# import data
apt_2018 <- read.csv("rt_sales_apartments_2018.csv", stringsAsFactors = FALSE)
apt_2019 <- read.csv("rt_sales_apartments_2019.csv", stringsAsFactors = FALSE)
multi_2018 <- read.csv("rt_sales_multi_2018.csv", stringsAsFactors = FALSE)
multi_2019 <- read.csv("rt_sales_multi_2019.csv", stringsAsFactors = FALSE)
studio_2018 <- read.csv("rt_sales_studio_2018.csv", stringsAsFactors = FALSE)
studio_2019 <- read.csv("rt_sales_studio_2019.csv", stringsAsFactors = FALSE)

# 엑셀 열 순서, 열 이름 다른거 고침
# apt_2019 <- apt_2019[, -2]
# multi_2018 <- multi_2018[, -1]
# multi_2019 <- multi_2019[, -2]
# studio_2018 <- studio_2018[, -1]
# studio_2019 <- studio_2019[, -2]
# 
# 
# multi_2019 <- multi_2019[, c(1, 3, 2, 4:51)]
# studio_2019 <- studio_2019[, c(1:49, 51, 50)]

# names(apt_2019) <- c("X", "V25", "mergecode", "A0", "A1", "A2", "A3", "A4",
#                      "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", 
#                      "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21",
#                      "A22", "V24", "V32", "V33", "G6", "G7", "G8", "G1", "G2", 
#                      "G3", "B.name", "J.area", "G4", "G5", "Price", "Floor",
#                      "G9", "G10", "Type", "D.area", "Pricetype", "B.price", 
#                      "M.price", "B.type","Roadc", "By.type")
# names(multi_2019) <- c("X", "V25", "mergecode", "A0", "A1", "A2", "A3", "A4",
#                        "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", 
#                        "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21",
#                        "A22", "V24", "V32", "V33", "G6", "G7", "G8", "G1", "G2", 
#                        "G3", "B.name", "J.area", "G4", "G5", "Price", "Floor",
#                        "G9", "G10", "Type", "D.area", "Pricetype", "B.price", 
#                        "M.price", "B.type","Roadc", "By.type")
# 
# names(studio_2019) <- c("X", "V25", "mergecode", "A0", "A1", "A2", "A3", "A4",
#                         "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", 
#                         "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21",
#                         "A22", "V24", "V32", "V33", "G6", "G7", "G8", "G1", "G2", 
#                         "G3", "B.name", "J.area", "G4", "G5", "Price", "Floor",
#                         "G9", "G10", "Type", "D.area", "Pricetype", "B.price", 
#                         "M.price", "B.type","Roadc", "By.type")
# 
# names(apt_2018) == names(apt_2019)
# names(apt_2018) == names(multi_2018)
# names(multi_2018) == names(multi_2019)
# names(studio_2018) == names(studio_2019)
# 
# apt_2019 <- apt_2019[, c(1, 3, 2, 4:29, 34, 35, 36, 46, 37, 38, 39, 47, 48, 
#                          41, 30, 31, 32, 42, 43, 33, 45, 40, 49, 51, 50, 44)]
# multi_2019 <- multi_2019[, c(1, 3, 2, 4:29, 34, 35, 36, 46, 37, 38, 39, 47, 48,
#                              41, 30, 31, 32, 42, 43, 33, 45, 40, 49, 51, 50, 44)]
# studio_2019 <- studio_2019[, c(1, 3, 2, 4:29, 34, 35, 36, 46, 37, 38, 39, 47, 48,
#                              41, 30, 31, 32, 42, 43, 33, 45, 40, 49, 51, 50, 44)]

# write.csv(apt_2018, "apt_2018.csv")
# write.csv(apt_2019, "apt_2019.csv")
# write.csv(multi_2018, "multi_2018.csv")
# write.csv(multi_2019, "multi_2019.csv")
# write.csv(studio_2018, "studio_2018.csv")
# write.csv(studio_2019, "studio_2019.csv")

# 2018년도 Price에서 , 제거
apt_2018$Price <- gsub(",", "", apt_2018$Price)
apt_2019$Price
multi_2018$Price <- gsub(",", "", multi_2018$Price)
multi_2019$Price
studio_2018$Price <- gsub(",", "", studio_2018$Price)
studio_2019$Price

# 2018년도 Price 숫자형 변환
apt_2018$Price <- as.numeric(apt_2018$Price)
multi_2018$Price <- as.numeric(multi_2018$Price)
studio_2018$Price <- as.numeric(studio_2018$Price)

# 변수 데이터 타입
apt18_type <- c()
for (i in 1:51) {
  apt18_type <- c(apt18_type, typeof(apt_2018[, i]))
}
apt19_type <- c()
for (i in 1:51) {
  apt19_type <- c(apt19_type, typeof(apt_2019[, i]))
}
multi18_type <- c()
for (i in 1:51) {
  multi18_type <- c(multi18_type, typeof(multi_2018[, i]))
}
multi19_type <- c()
for (i in 1:51) {
  multi19_type <- c(multi19_type, typeof(multi_2019[, i]))
}
studio18_type <- c()
for (i in 1:51) {
  studio18_type <- c(studio18_type, typeof(studio_2018[, i]))
}
studio19_type <- c()
for (i in 1:51) {
  studio19_type <- c(studio19_type, typeof(studio_2019[, i]))
}


# 변수 범주 개수 파악
apt18_categories <- c()
for (i in 1:51) {
  apt18_categories <- c(apt18_categories, length(unique(apt_2018[, i])))
}
apt19_categories <- c()
for (i in 1:51) {
  apt19_categories <- c(apt19_categories, length(unique(apt_2019[, i])))
}
multi18_categories <- c()
for (i in 1:51) {
  multi18_categories <- c(multi18_categories, length(unique(multi_2018[, i])))
}
multi19_categories <- c()
for (i in 1:51) {
  multi19_categories <- c(multi19_categories, length(unique(multi_2019[, i])))
}
studio18_categories <- c()
for (i in 1:51) {
  studio18_categories <- c(studio18_categories, length(unique(studio_2018[, i])))
}
studio19_categories <- c()
for (i in 1:51) {
  studio19_categories <- c(studio19_categories, length(unique(studio_2019[, i])))
}


# 최소
apt18_min <- c()
for (i in 1:51) {
  if (typeof(apt_2018[, i]) == "integer" | typeof(apt_2018[, i]) == "numeric" |
      typeof(apt_2018[, i]) == "double") {
    apt18_min <- c(apt18_min, min(apt_2018[, i]))
  } else {apt18_min <- c(apt18_min, NA)}
}
apt19_min <- c()
for (i in 1:51) {
  if (typeof(apt_2019[, i]) == "integer" | typeof(apt_2019[, i]) == "numeric" |
      typeof(apt_2019[, i]) == "double") {
    apt19_min <- c(apt19_min, min(apt_2019[, i]))
  } else {apt19_min <- c(apt19_min, NA)}
}
multi18_min <- c()
for (i in 1:51) {
  if (typeof(multi_2018[, i]) == "integer" | typeof(multi_2018[, i]) == "numeric" |
      typeof(multi_2018[, i]) == "double") {
    multi18_min <- c(multi18_min, min(multi_2018[, i]))
  } else {multi18_min <- c(multi18_min, NA)}
}
multi19_min <- c()
for (i in 1:51) {
  if (typeof(multi_2019[, i]) == "integer" | typeof(multi_2019[, i]) == "numeric" |
      typeof(multi_2019[, i]) == "double") {
    multi19_min <- c(multi19_min, min(multi_2019[, i]))
  } else {multi19_min <- c(multi19_min, NA)}
}
studio18_min <- c()
for (i in 1:51) {
  if (typeof(studio_2018[, i]) == "integer" | typeof(studio_2018[, i]) == "numeric" |
      typeof(studio_2018[, i]) == "double") {
    studio18_min <- c(studio18_min, min(studio_2018[, i]))
  } else {studio18_min <- c(studio18_min, NA)}
}
studio19_min <- c()
for (i in 1:51) {
  if (typeof(studio_2019[, i]) == "integer" | typeof(studio_2019[, i]) == "numeric" |
      typeof(studio_2019[, i]) == "double") {
    studio19_min <- c(studio19_min, min(studio_2019[, i]))
  } else {studio19_min <- c(studio19_min, NA)}
}


# 평균
apt18_mean <- c()
for (i in 1:51) {
  if (typeof(apt_2018[, i]) == "integer" | typeof(apt_2018[, i]) == "numeric" |
      typeof(apt_2018[, i]) == "double") {
    apt18_mean <- c(apt18_mean, mean(apt_2018[, i]))
  } else {apt18_mean <- c(apt18_mean, NA)}
}
apt19_mean <- c()
for (i in 1:51) {
  if (typeof(apt_2019[, i]) == "integer" | typeof(apt_2019[, i]) == "numeric" |
      typeof(apt_2019[, i]) == "double") {
    apt19_mean <- c(apt19_mean, mean(apt_2019[, i]))
  } else {apt19_mean <- c(apt19_mean, NA)}
}
multi18_mean <- c()
for (i in 1:51) {
  if (typeof(multi_2018[, i]) == "integer" | typeof(multi_2018[, i]) == "numeric" |
      typeof(multi_2018[, i]) == "double") {
    multi18_mean <- c(multi18_mean, mean(multi_2018[, i]))
  } else {multi18_mean <- c(multi18_mean, NA)}
}
multi19_mean <- c()
for (i in 1:51) {
  if (typeof(multi_2019[, i]) == "integer" | typeof(multi_2019[, i]) == "numeric" |
      typeof(multi_2019[, i]) == "double") {
    multi19_mean <- c(multi19_mean, mean(multi_2019[, i]))
  } else {multi19_mean <- c(multi19_mean, NA)}
}
studio18_mean <- c()
for (i in 1:51) {
  if (typeof(studio_2018[, i]) == "integer" | typeof(studio_2018[, i]) == "numeric" |
      typeof(studio_2018[, i]) == "double") {
    studio18_mean <- c(studio18_mean, mean(studio_2018[, i]))
  } else {studio18_mean <- c(studio18_mean, NA)}
}
studio19_mean <- c()
for (i in 1:51) {
  if (typeof(multi_2019[, i]) == "integer" | typeof(studio_2019[, i]) == "numeric" |
      typeof(studio_2019[, i]) == "double") {
    studio19_mean <- c(studio19_mean, mean(studio_2019[, i]))
  } else {studio19_mean <- c(studio19_mean, NA)}
}

# 중위수
apt18_median <- c()
for (i in 1:51) {
  if (typeof(apt_2018[, i]) == "integer" | typeof(apt_2018[, i]) == "numeric" |
      typeof(apt_2018[, i]) == "double") {
    apt18_median <- c(apt18_median, median(apt_2018[, i]))
  } else {apt18_median <- c(apt18_median, NA)}
}
apt19_median <- c()
for (i in 1:51) {
  if (typeof(apt_2019[, i]) == "integer" | typeof(apt_2019[, i]) == "numeric" |
      typeof(apt_2019[, i]) == "double") {
    apt19_median <- c(apt19_median, median(apt_2019[, i]))
  } else {apt19_median <- c(apt19_median, NA)}
}
multi18_median <- c()
for (i in 1:51) {
  if (typeof(multi_2018[, i]) == "integer" | typeof(multi_2018[, i]) == "numeric" |
      typeof(multi_2018[, i]) == "double") {
    multi18_median <- c(multi18_median, median(multi_2018[, i]))
  } else {multi18_median <- c(multi18_median, NA)}
}
multi19_median <- c()
for (i in 1:51) {
  if (typeof(multi_2019[, i]) == "integer" | typeof(multi_2019[, i]) == "numeric" |
      typeof(multi_2019[, i]) == "double") {
    multi19_median <- c(multi19_median, median(multi_2019[, i]))
  } else {multi19_median <- c(multi19_median, NA)}
}
studio18_median <- c()
for (i in 1:51) {
  if (typeof(studio_2018[, i]) == "integer" | typeof(studio_2018[, i]) == "numeric" |
      typeof(studio_2018[, i]) == "double") {
    studio18_median <- c(studio18_median, median(studio_2018[, i]))
  } else {studio18_median <- c(studio18_median, NA)}
}
studio19_median <- c()
for (i in 1:51) {
  if (typeof(studio_2019[, i]) == "integer" | typeof(studio_2019[, i]) == "numeric" |
      typeof(studio_2019[, i]) == "double") {
    studio19_median <- c(studio19_median, median(studio_2019[, i]))
  } else {studio19_median <- c(studio19_median, NA)}
}

# 최대
apt18_max <- c()
for (i in 1:51) {
  if (typeof(apt_2018[, i]) == "integer" | typeof(apt_2018[, i]) == "numeric" |
      typeof(apt_2018[, i]) == "double") {
    apt18_max <- c(apt18_max, max(apt_2018[, i]))
  } else {apt18_max <- c(apt18_max, NA)}
}
apt19_max <- c()
for (i in 1:51) {
  if (typeof(apt_2019[, i]) == "integer" | typeof(apt_2019[, i]) == "numeric" |
      typeof(apt_2019[, i]) == "double") {
    apt19_max <- c(apt19_max, max(apt_2019[, i]))
  } else {apt19_max <- c(apt19_max, NA)}
}
multi18_max <- c()
for (i in 1:51) {
  if (typeof(multi_2018[, i]) == "integer" | typeof(multi_2018[, i]) == "numeric" |
      typeof(multi_2018[, i]) == "double") {
    multi18_max <- c(multi18_max, max(multi_2018[, i]))
  } else {multi18_max <- c(multi18_max, NA)}
}
multi19_max <- c()
for (i in 1:51) {
  if (typeof(multi_2019[, i]) == "integer" | typeof(multi_2019[, i]) == "numeric" |
      typeof(multi_2019[, i]) == "double") {
    multi19_max <- c(multi19_max, max(multi_2019[, i]))
  } else {multi19_max <- c(multi19_max, NA)}
}
studio18_max <- c()
for (i in 1:51) {
  if (typeof(studio_2018[, i]) == "integer" | typeof(studio_2018[, i]) == "numeric" |
      typeof(studio_2018[, i]) == "double") {
    studio18_max <- c(studio18_max, max(studio_2018[, i]))
  } else {studio18_max <- c(studio18_max, NA)}
}
studio19_max <- c()
for (i in 1:51) {
  if (typeof(studio_2019[, i]) == "integer" | typeof(studio_2019[, i]) == "numeric" |
      typeof(studio_2019[, i]) == "double") {
    studio19_max <- c(studio19_max, max(studio_2019[, i]))
  } else {studio19_max <- c(studio19_max, NA)}
}



# 결측값 개수
apt18_NA <- apply(apply(apt_2018, 2, is.na), 2, sum)
apt19_NA <- apply(apply(apt_2019, 2, is.na), 2, sum)
multi18_NA <- apply(apply(multi_2018, 2, is.na), 2, sum)
multi19_NA <- apply(apply(multi_2019, 2, is.na), 2, sum)
studio18_NA <- apply(apply(studio_2018, 2, is.na), 2, sum)
studio19_NA <- apply(apply(studio_2019, 2, is.na), 2, sum)

# 합치기
apt18_eda <- cbind(apt18_type, apt18_categories, apt18_min, apt18_mean, 
                   apt18_median, apt18_max, apt18_NA)
apt19_eda <- cbind(apt19_type, apt19_categories, apt19_min, apt19_mean, 
                   apt19_median, apt19_max, apt19_NA)
multi18_eda <- cbind(multi18_type, multi18_categories, multi18_min, 
                     multi18_mean, multi18_median, multi18_max, multi18_NA)
multi19_eda <- cbind(multi19_type, multi19_categories, multi19_min, 
                     multi19_mean, multi19_median, multi19_max, multi19_NA)
studio18_eda <- cbind(studio18_type, studio18_categories, studio18_min, 
                      studio18_mean, studio18_median, studio18_max, studio18_NA)
studio19_eda <- cbind(studio19_type, studio19_categories, studio19_min, 
                      studio19_mean, studio19_median, studio19_max, studio19_NA)
###############################################################################
total_eda <- cbind(apt18_eda, apt19_eda, multi18_eda, multi19_eda, studio18_eda,
                   studio19_eda)
View(total_eda)

write.csv(total_eda, "total_eda.csv")




