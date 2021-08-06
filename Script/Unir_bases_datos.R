#unir bases de datos en R
#sandro arias
#05/08/2021

#Unir base de datos de suelos con un mismo ID
library(tidyr)
library(dplyr)

crop_data <- tibble(read.csv("Datos/Maize_cordoba_crop.csv"))

soil_data <- tibble(read.csv("Datos/Maize_cordoba_soil.csv"))

#se va unir con los ID's
#todos los IDs deben quitarse 

crop_data ; soil_data

#left join, pra garantizar

alldata <- crop_data %>% left_join(soil_data,by="Soil_ID")
alldata
summary(alldata)
#todo lo lee como factor

soil_data_low_OM <- soil_data %>% filter(Organic_Matter_Content == "BAJA")
soil_data_low_OM

left_crop <- crop_data %>% left_join(soil_data_low_OM, by = c("Soil_ID"="Soil_ID"))
inner_crop <- crop_data %>% left_join(soil_data_low_OM, by="Soil_ID"="Soil_ID")
right_crop <- crop_data %>% left_join(soil_data_low_OM, by="Soil_ID"="Soil_ID")

#semi join
crop_data %>% semi_join(soil_data_low_OM, by="Soil_ID")

#full join
band_members
band_instruments

band_members %>% full_join(band_instruments2, by=c("name" = "artist"))

