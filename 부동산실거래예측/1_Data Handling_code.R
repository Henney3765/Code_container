### Data Handling Code
### 2021.01.20
### Myunghun Lee
### Encoding: UTF-8

# 패키지 불러오기
library(rgdal)

# 데이터 불러오기 (Real Estate Transactions Data (공유 드라이브) > 2020ver)
for (i in 2015:2019){
  assign(paste0("rt_sales_apartments_", i), 
         readOGR(paste0("rt_sales_apartments_", i, ".gpkg"), stringsAsFactors = F))
  assign(paste0("rt_sales_multi_", i), 
         readOGR(paste0("rt_sales_multi_", i, ".gpkg"), stringsAsFactors = F))
  assign(paste0("rt_sales_studio_", i), 
         readOGR(paste0("rt_sales_studio_", i, ".gpkg"), stringsAsFactors = F))
}

# 거래별 변수 생성
rt_sales_apartments <- rbind(rt_sales_apartments_2015@data, 
                             rt_sales_apartments_2016@data,
                             rt_sales_apartments_2017@data, 
                             rt_sales_apartments_2018@data,
                             rt_sales_apartments_2019@data)
rt_sales_multi <- rbind(rt_sales_multi_2015@data, rt_sales_multi_2016@data,
                        rt_sales_multi_2017@data, rt_sales_multi_2018@data,
                        rt_sales_multi_2019@data)
rt_sales_studio <- rbind(rt_sales_studio_2015@data, rt_sales_studio_2016@data,
                         rt_sales_studio_2017@data, rt_sales_studio_2018@data,
                         rt_sales_studio_2019@data)
rt_sales_apartments <- rt_sales_apartments[, c(16:22, 28:29, 36, 38:39, 41, 
                                               43:44, 51)]
rt_sales_multi <- rt_sales_multi[, c(16:22, 28:29, 36, 38:39, 41, 43:44, 51)]
rt_sales_studio <- rt_sales_studio[, c(16:22, 28:29, 36, 38:39, 41, 43:44, 51)]


# 거래별 변수 전처리(분석에 사용할 변수들 편집)
# 아파트
rt_sales_apartments$A13 <- as.numeric(substr(rt_sales_apartments$A13, 1, 4))
rt_sales_apartments$G9 <- as.numeric(rt_sales_apartments$G9)
rt_sales_apartments$G10 <- as.numeric(rt_sales_apartments$G10)
rt_sales_apartments$N5 <- as.numeric(rt_sales_apartments$N5)
Encoding(rt_sales_apartments$G7) <- "UTF-8"
Encoding(rt_sales_apartments$N12) <- "UTF-8"
rt_sales_apartments <- rt_sales_apartments[!(rt_sales_apartments$A12 == 0|
                                               rt_sales_apartments$A15 == 0|
                                               rt_sales_apartments$A16 == 0|
                                               rt_sales_apartments$A17 == 0|
                                               rt_sales_apartments$A18 == 0), ]
# 연립다세대
rt_sales_multi$A13 <- as.numeric(substr(rt_sales_multi$A13, 1, 4))
rt_sales_multi$G9 <- as.numeric(rt_sales_multi$G9)
rt_sales_multi$G10 <- as.numeric(rt_sales_multi$G10)
rt_sales_multi$N5 <- as.numeric(rt_sales_multi$N5)
Encoding(rt_sales_multi$G7) <- "UTF-8"
Encoding(rt_sales_multi$N12) <- "UTF-8"
rt_sales_multi <- rt_sales_multi[!(rt_sales_multi$A12 == 0|rt_sales_multi$A15 == 0|
                                     rt_sales_multi$A16 == 0|
                                     rt_sales_multi$A17 == 0|
                                     rt_sales_multi$A18 == 0), ]
# 오피스텔
rt_sales_studio$A13 <- as.numeric(substr(rt_sales_studio$A13, 1, 4))
rt_sales_studio$G9 <- as.numeric(rt_sales_studio$G9)
rt_sales_studio$G10 <- as.numeric(rt_sales_studio$G10)
rt_sales_studio$N5 <- as.numeric(rt_sales_studio$N5)
Encoding(rt_sales_studio$G7) <- "UTF-8"
Encoding(rt_sales_studio$N12) <- "UTF-8"
rt_sales_studio <- rt_sales_studio[!(rt_sales_studio$A12 == 0|
                                       rt_sales_studio$A15 == 0|
                                       rt_sales_studio$A16 == 0|
                                       rt_sales_studio$A17 == 0|
                                       rt_sales_studio$A18 == 0), ]


# 생성된 변수 한개의 파일로 통합
rt_sales_Three <- rbind(rt_sales_apartments, rt_sales_multi, rt_sales_studio)
rt_sales_Three <- na.omit(rt_sales_Three)

# 랜덤포레스트 분석을 위해 g7 과 n12 팩터로 변환
rt_sales_Three$G7 <- factor(rt_sales_Three$G7)
rt_sales_Three$N12 <- factor(rt_sales_Three$N12)

# 훈련용 데이터와 테스트용 데이터 생성
trainIdx <- sample(1:nrow(rt_sales_Three), size = nrow(rt_sales_Three)* 0.7)
train <- rt_sales_Three[trainIdx, ]
test <- rt_sales_Three[-trainIdx, ]

# 데이터 저장
write.csv(train, "rt_sales_train.csv", row.names = FALSE)
write.csv(test, "rt_sales_test.csv", row.names = FALSE)
