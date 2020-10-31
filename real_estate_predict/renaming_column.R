### 부동산 실거래가 데이터 구축
### 2010.10.19
### JeongHyeon Kim


## Rents
# import packages
library(rgdal)

# import data
for (i in 2011:2019){
  assign(paste0("rt_rent_apartments_", i), 
         readOGR(paste0("rt_rent_apartments_", i, ".gpkg"), stringsAsFactors = F))
  assign(paste0("rt_rent_multi_", i), 
         readOGR(paste0("rt_rent_multi_", i, ".gpkg"), stringsAsFactors = F))
  assign(paste0("rt_rent_studio_", i), 
         readOGR(paste0("rt_rent_studio_", i, ".gpkg"), stringsAsFactors = F))
}

# renaming column
colnames(rt_rent_apartments_2012@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_apartments_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_apartments_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_apartments_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_multi_2015@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_multi_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_multi_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_multi_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_studio_2015@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_studio_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_studio_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_rent_studio_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                            "A2", "A3", "A4", "A5", "A6", "A7", 
                                            "A8", "A9", "A10", "A11", "A12", "A13", 
                                            "A14", "A15", "A16", "A17", "A18", 
                                            "A19", "A20", "A21", "A22", "V24", 
                                            "V32", "V33", "G1", "G2", "G3", 
                                            "G4", "G5", "G6", "G7", "G8", "G9", 
                                            "G10", "N1", "N2", "N3", "N4", "N5", 
                                            "N6", "N7", "N8", "N9", "N10", "N11", "N12")

## Sales
# import data
for (i in 2006:2019){
  assign(paste0("rt_sales_apartments_", i), 
         readOGR(paste0("rt_sales_apartments_", i, ".gpkg"), stringsAsFactors = F))
  assign(paste0("rt_sales_multi_", i), 
         readOGR(paste0("rt_sales_multi_", i, ".gpkg"), stringsAsFactors = F))
  assign(paste0("rt_sales_studio_", i), 
         readOGR(paste0("rt_sales_studio_", i, ".gpkg"), stringsAsFactors = F))
  assign(paste0("rt_sales_house_", i), 
         readOGR(paste0("rt_sales_house_", i, ".gpkg"), stringsAsFactors = F))
}
for (i in 2007:2019){
  assign(paste0("rt_sales_purchright_", i), 
         readOGR(paste0("rt_sales_purchright_", i, ".gpkg"), stringsAsFactors = F))
}

# Cheking colnames
# eval(parse(text = ~)) -> transfer character as object
for (i in 2006:2019) {
  cat(print(i))
  print(colnames(eval(parse(text = paste0("rt_sales_apartment_", i)))@data))
}

# renaming column
colnames(rt_sales_apartments_2015@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_apartments_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_apartments_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_apartments_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_house_2015@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_house_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_house_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_house_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_multi_2015@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_multi_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_multi_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_multi_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_purchright_2015@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_purchright_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_purchright_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_purchright_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_studio_2015@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_studio_2016@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_studio_2017@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
colnames(rt_sales_studio_2018@data) <- c("X", "mergecode", "V25", "A0", "A1",
                                             "A2", "A3", "A4", "A5", "A6", "A7", 
                                             "A8", "A9", "A10", "A11", "A12", "A13", 
                                             "A14", "A15", "A16", "A17", "A18", 
                                             "A19", "A20", "A21", "A22", "V24", 
                                             "V32", "V33", "G1", "G2", "G3", 
                                             "G4", "G5", "G6", "G7", "G8", "G9", 
                                             "G10", "N1", "N2", "N3", "N4", "N5", 
                                             "N6", "N7", "N8", "N9", "N10", "N11", "N12")
