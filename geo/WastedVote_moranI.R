# set working directory
getwd()
setwd("C:/Users/JH/Desktop/4-1/공간통계응용/팀플/20")

# import packages
library(readxl)
library(rgdal)
library(spdep)
library(RColorBrewer)
library(classInt)

## 전처리
# # import shp
# shp <- readOGR("20대총선선거구.shp", encoding = "utf-8")

# # 청주이름변경
# shp$선거구명1[c(189, 190)] <- c("청주시서원구", "청주시흥덕구")
# # 통영제거
# shp <- shp[-250, ]
# # 부평이름 변경
# total_20$선거구명[c(206, 207)] <- c("부평갑", "부평을")
# 
# 
# # import data
# gangwon_20 <- read_excel(path = "20강원.xlsx",
#                          col_names = TRUE)
# gyunggi_20 <- read_excel(path = "20경기.xlsx",
#                          col_names = TRUE)
# gyungnam_20 <- read_excel(path = "20경남.xlsx",
#                           col_names = TRUE)
# gyungbuk_20 <- read_excel(path = "20경북.xlsx",
#                           col_names = TRUE)
# gwangju_20 <- read_excel(path = "20광주.xlsx",
#                           col_names = TRUE)
# daegu_20 <- read_excel(path = "20대구.xlsx",
#                           col_names = TRUE)
# daejeon_20 <- read_excel(path = "20대전.xlsx",
#                          col_names = TRUE)
# busan_20 <- read_excel(path = "20부산.xlsx",
#                          col_names = TRUE)
# seoul_20 <- read_excel(path = "20서울.xlsx",
#                          col_names = TRUE)
# sejong_20 <- read_excel(path = "20세종.xlsx",
#                          col_names = TRUE)
# ulsan_20 <- read_excel(path = "20울산.xlsx",
#                          col_names = TRUE)
# incheon_20 <- read_excel(path = "20인천.xlsx",
#                          col_names = TRUE)
# jeonnam_20 <- read_excel(path = "20전남.xlsx",
#                          col_names = TRUE)
# jeonbuk_20 <- read_excel(path = "20전북.xlsx",
#                          col_names = TRUE)
# jeju_20 <- read_excel(path = "20제주.xlsx",
#                          col_names = TRUE)
# choongnam_20 <- read_excel(path = "20충남.xlsx",
#                          col_names = TRUE)
# choongbuk_20 <- read_excel(path = "20충북.xlsx",
#                          col_names = TRUE)
# 
# total_20 <- rbind(gangwon_20, gyunggi_20, gyungnam_20, gyungbuk_20, gwangju_20,
#                   daegu_20, daejeon_20, busan_20, seoul_20, sejong_20, ulsan_20,
#                   incheon_20, jeonnam_20, jeonbuk_20, jeju_20, choongnam_20, 
#                   choongbuk_20)
# 
# # export data
# write.csv(total_20, "20대총선전체.csv")

# import shp
shp <- readOGR("조인_20대선거구.shp", encoding = "utf-8")

# cha -> num
str(shp@data)

shp@data$선거인수 <- gsub(",", "", shp@data$선거인수)
shp@data$선거인수 <- as.numeric(shp@data$선거인수)
shp@data$유효표수 <- as.numeric(shp@data$유효표수)
shp@data$사표수 <- as.numeric(shp@data$사표수)

#사표율추가
shp@data <- transform(shp@data, 사표율 = 사표수 / 선거인수)
str(shp@data)

# 분석과정
plot(shp, col = "gray80", border = "gray50", 
     main = "Electoral precinct in South Korea")

# 사표율 단계구분도
shp.groups <- classIntervals(shp$사표율, 5, style = "jenks")
shp.colors <- findColours(shp.groups, brewer.pal(5, "YlGn"))
plot(shp, col = shp.colors, border = "gray20", 
     main = "Wasted Vote(%) in South Korea")
legend.text <- vector()
for (i in 1:(length(shp.groups$brks)-1)) {
  legend.text[i] <-
    paste(round(shp.groups$brks, 2)[i:(i+1)], collapse = " - ")
}

legend(locator(1), fill = attr(shp.colors, "palette"),
       legend = legend.text, border = "gray20", box.col = NA)


# Local moran's I
shp.lw <- poly2nb(shp, queen = TRUE)
shp.lI <- localmoran(shp$사표율, nb2listw(shp.lw, zero.policy=TRUE))
lI.groups <- classIntervals(shp.lI[, 1], 5, style = "quantile")
lI.colors <- findColours(lI.groups, brewer.pal(5, "YlOrBr"))
plot(shp, col = lI.colors, border = "gray20",
     main = "Wasted vote(%) in South korea (Local Moran's I)")

legend.text <- vector()
for (i in 1:(length(lI.groups$brks)-1)) {
  legend.text[i] <-
    paste(round(lI.groups$brks, 2)[i:(i+1)], collapse = " - ")
}

legend(locator(1), fill = attr(lI.colors, "palette"),
       legend = legend.text, border = "gray20", box.col = NA)

# 경기도만 해보자
View(shp)
shp_sudo <- subset(shp, shp$시도명 == "서울특별시" | shp$시도명 == "경기도")

# 사표율 단계구분도
shp_sudo.groups <- classIntervals(shp_sudo$사표율, 5, style = "jenks")
shp_sudo.colors <- findColours(shp_sudo.groups, brewer.pal(5, "YlGn"))
plot(shp_sudo, col = shp_sudo.colors, border = "gray20", 
     main = "Wasted Vote(%) in Metropolitan area")
legend.text <- vector()
for (i in 1:(length(shp_sudo.groups$brks)-1)) {
  legend.text[i] <-
    paste(round(shp_sudo.groups$brks, 2)[i:(i+1)], collapse = " - ")
}

legend("bottomleft", fill = attr(shp_sudo.colors, "palette"),
       legend = legend.text, border = "gray20", box.col = NA)


# Local moran's I
shp_sudo.lw <- poly2nb(shp_sudo, queen = TRUE)
shp_sudo.lI <- localmoran(shp_sudo$사표율, nb2listw(shp_sudo.lw, zero.policy=TRUE))
shp_sudo.lI.groups <- classIntervals(shp_sudo.lI[, 1], 5, style = "quantile")
shp_sudo.lI.colors <- findColours(shp_sudo.lI.groups, brewer.pal(5, "YlOrBr"))
plot(shp_sudo, col = shp_sudo.lI.colors, border = "gray20",
     main = "Wasted vote(%) in Metropolitan area (Local Moran's I)")

legend.text <- vector()
for (i in 1:(length(shp_sudo.lI.groups$brks)-1)) {
  legend.text[i] <-
    paste(round(shp_sudo.lI.groups$brks, 2)[i:(i+1)], collapse = " - ")
}

legend("bottomleft", fill = attr(shp_sudo.lI.colors, "palette"),
       legend = legend.text, border = "gray20", box.col = NA)
















