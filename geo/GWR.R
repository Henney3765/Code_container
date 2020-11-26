### Geographically weighted regression as an exploratory tool
### 2020.11.26
### JeongHyeon Kim
### UTF-8

getwd()
setwd("C:/Users/JH/Desktop/4-1/공간통계응용/lab8")

# import packages
# # install.packages("C:/Users/JH/Desktop/4-1/공간통계응용/lab8/GWmodel_2.2-2.zip",
#                   repos = NULL)
library(GWmodel)

# import data
data(LondonHP)
head(data.frame(londonhp))
data(LondonBorough)

# PPSQM histogram
londonhp$PPSQM <- londonhp$PURCHASE / londonhp$FLOORSZ
hist(londonhp$PPSQM, main = "Price per Square Meter (Pounds)",
     xlab = "Cost per Sq. Meter", ylab = "Frequency")

# mean & sd
mean(londonhp$PPSQM)
sd(londonhp$PPSQM)

# PROF histogram 
hist(londonhp$PROF,
     main = "Proportion of Workforce in Professional occupations",
     xlab = "Proportion", ylab = "Frequency")

# linear regression model
linmod <- lm(PPSQM ~ PROF, data = londonhp)
summary(linmod)

# PPSQM ~ PROF plot
plot(PPSQM ~ PROF, data = londonhp,
     xlab = "Proportion Professional / Managerial",
     ylab = "Cost per Square Metre")
abline(linmod)

# to make panel
panel.lm <- function(x, y, ...) {
  points(x, y, pch = 16)
  abline(lm(y~x))
}

# coplot PPSQM ~ PROF
coplot(PPSQM ~ PROF | coords.x1 * coords.x2,
       data = data.frame(londonhp), panel = panel.lm, overlap = 0.8)

## Geographically Weighted Regression
plot(londonborough)
plot(londonhp, pch = 16, col = "firebrick", add = TRUE)

# to make grid
grd <- SpatialGrid(GridTopology(c(503400, 155400),
                                c(1000, 1000), c(60, 48)))
plot(grd)
plot(londonborough, add = TRUE,
     col = adjustcolor("navyblue", alpha.f = 0.5))

# distance between points and grid
DM <- gw.dist(dp.locat = coordinates(londonhp),
              rp.locat = coordinates(grd))

# GWR
gwr.res <- gwr.basic(PPSQM ~ PROF, data = londonhp, bw = 10000,
                     regression.points = grd, dMat = DM, kernel = "gaussian")
gwr.res

image(gwr.res$SDF, "PROF")
plot(londonborough, add = TRUE)
plot(londonhp, add = TRUE, pch = 16, col = "blueviolet")
plot(londonborough, border = "lightgrey")
contour(gwr.res$SDF, "PROF", lwd = 3, add = TRUE)
plot(londonhp, add = TRUE, pch = 16,
     col = adjustcolor("blueviolet", alpha.f = 0.4))


