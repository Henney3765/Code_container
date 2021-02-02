### Accuracy Code
### 2020.12.05
### Youngho Lee
### Encoding: UTF-8

# import packages
library(Metrics)

# import prediction data
data_path <- "~/data/pred/"
pred_ann <- read.csv(paste0(data_path, "pred_ann.csv"))
pred_rf <- read.csv(paste0(data_path, "pred_rf.csv"))
pred_krig <- read.csv(paste0(data_path, "pred_krig.csv"))

# calculate mae
mae(pred_ann$actual, pred_ann$ann)
mae(pred_rf$actual, pred_rf$rf)
mae(pred_krig$actual, pred_krig$krig)

# calculate rmse
rmse(pred_ann$actual, pred_ann$ann)
rmse(pred_rf$actual, pred_rf$rf)
rmse(pred_krig$actual, pred_krig$krig)

# calculate mape
mape(pred_ann$actual, pred_ann$ann)
mape(pred_rf$actual, pred_rf$rf)
mape(pred_krig$actual, pred_krig$krig)

# calculate mase
mase(pred_ann$actual, pred_ann$ann)
mase(pred_rf$actual, pred_rf$rf)
mase(pred_krig$actual, pred_krig$krig)
