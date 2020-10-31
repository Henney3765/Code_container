## 맵시 학술제 데이터 전처리

## import data
# counting vector(month)
num <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")

# import pm data 2014 ~ 2019
for (i in num) {
  assign(paste0("pm_2014_", i), 
         read.csv(paste0("pm_2014_", i, ".csv"), header = TRUE))
}

for (i in num) {
  assign(paste0("pm_2015_", i), 
         read.csv(paste0("pm_2015_", i, ".csv"), header = TRUE))
}

for (i in num) {
  assign(paste0("pm_2016_", i), 
         read.csv(paste0("pm_2016_", i, ".csv"), header = TRUE))
}

for (i in num) {
  assign(paste0("pm_2017_", i), 
         read.csv(paste0("pm_2017_", i, ".csv"), header = TRUE))
}

for (i in num) {
  assign(paste0("pm_2018_", i), 
         read.csv(paste0("pm_2018_", i, ".csv"), header = TRUE))
}

for (i in num) {
  assign(paste0("pm_2019_", i), 
         read.csv(paste0("pm_2019_", i, ".csv"), header = TRUE))
}

# remove last row(NULL) 2014 ~ 2019
for (i in num) {
  assign(paste0("pm_2014_", i),
         eval(parse(text = paste0("pm_2014_", i)))[1:nrow(
           eval(parse(text = paste0("pm_2014_", i))))-1, ])
}

for (i in num) {
  assign(paste0("pm_2015_", i),
         eval(parse(text = paste0("pm_2015_", i)))[1:nrow(
           eval(parse(text = paste0("pm_2015_", i))))-1, ])
}

for (i in num) {
  assign(paste0("pm_2016_", i),
         eval(parse(text = paste0("pm_2016_", i)))[1:nrow(
           eval(parse(text = paste0("pm_2016_", i))))-1, ])
}

for (i in num) {
  assign(paste0("pm_2017_", i),
         eval(parse(text = paste0("pm_2017_", i)))[1:nrow(
           eval(parse(text = paste0("pm_2017_", i))))-1, ])
}

for (i in num) {
  assign(paste0("pm_2018_", i),
         eval(parse(text = paste0("pm_2018_", i)))[1:nrow(
           eval(parse(text = paste0("pm_2018_", i))))-1, ])
}

for (i in num) {
  assign(paste0("pm_2019_", i),
         eval(parse(text = paste0("pm_2019_", i)))[1:nrow(
           eval(parse(text = paste0("pm_2019_", i))))-1, ])
}

# import climate data 2014 ~ 2017
cd_2014 <- read.csv("cd_2014.csv", header = TRUE)
cd_2015 <- read.csv("cd_2015.csv", header = TRUE)
cd_2016 <- read.csv("cd_2016.csv", header = TRUE)
cd_2017 <- read.csv("cd_2017.csv", header = TRUE)
cd_2018 <- read.csv("cd_2018.csv", header = TRUE)
cd_2019 <- read.csv("cd_2019.csv", header = TRUE)

# rbind each pm data(months) 2014 ~ 2017
pm_2014 <- data.frame()
for (i in num) {
  pm_2014 <- rbind(pm_2014, eval(parse(text = paste0("pm_2014_", i))))
}

pm_2015 <- data.frame()
for (i in num) {
  pm_2015 <- rbind(pm_2015, eval(parse(text = paste0("pm_2015_", i))))
}

pm_2016 <- data.frame()
for (i in num) {
  pm_2016 <- rbind(pm_2016, eval(parse(text = paste0("pm_2016_", i))))
}

pm_2017 <- data.frame()
for (i in num) {
  pm_2017 <- rbind(pm_2017, eval(parse(text = paste0("pm_2017_", i))))
}

pm_2018 <- data.frame()
for (i in num) {
  pm_2018 <- rbind(pm_2018, eval(parse(text = paste0("pm_2018_", i))))
}

pm_2019 <- data.frame()
for (i in num) {
  pm_2019 <- rbind(pm_2019, eval(parse(text = paste0("pm_2019_", i))))
}

# rbind all of pm(years)
pm <- data.frame()
for (i in c("14", "15", "16", "17", "18", "19")) {
  pm <- rbind(pm, eval(parse(text = paste0("pm_20", i))))
}

# remove last row(2020-01-01 00:00)
pm <- pm[-nrow(pm),]

# rbind all of cd(years)
cd <- data.frame()
for (i in c("14", "15", "16", "17", "18", "19")) {
  cd <- rbind(cd, eval(parse(text = paste0("cd_20", i))))
}

pm <- read.csv("pm.csv", header = TRUE)
cd <- read.csv("cd.csv", header = TRUE)

# rename pm, cd
names(pm) <- c("hour", "PM10", "Ozone", "NO2", "CO2", "SO2")
names(cd) <- c("month", "hour", "temp", "prec", "windV", "windD", "Humid",
               "vaporP", "dewpoint", "localP", "seelevelP", "sunhr", 
               "insolation", "totalcloud", "mid_low_cloud", "visibility",
               "Min_cloudheight", "groundC", "groundtemp")

# cbind pm and cd
total_data <- cbind(cd, pm)

# remove hour
total_data <- total_data[, -20]

# remove ground condition
total_data <- total_data[, -18]

# month, hour,  -> factor
total_data$month <- factor(total_data$month)
total_data$hour <- factor(total_data$hour)

# save data
# write.csv(pm, "pm.csv")
# write.csv(cd, "cd.csv")
write.csv(total_data, "total_data.csv")

