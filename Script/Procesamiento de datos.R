#procesamiento de datos tidyr y dplyr
#sandro arias 
#3/8/21

library(tidyr)
library(dplyr)
library(ggplot2)

#leer la data de cultivo 
crop_data <- read.csv("Datos/Maize_Cordoba_Crop.csv")

#para que se lea como factor
crop_data <- read.csv("Datos/Maize_Cordoba_Crop.csv", stringsAsFactors = T)

summary(crop_data)

head(crop_data)

crop_data

#archivo paracido a DataFRAME
#se convierte a objeto tipo TIBLE
#dbl decimales


crop_data <- tibble(crop_data)

crop_data
is(crop_data)

#para ver informacion por columna/transpuesta, parecido a STR

glimpse(crop_data)

#para extraer rendimiento mayor a 8
#filter en base a una condición

crop_data[crop_data$Yield >8,]
?filter

filter(crop_data,Yield >8)

#con pipetas
crop_data %>% filter(Yield>8) %>% summary()

#otra regla rendimiento sea mayor a 8 y soting MECANIZADO

crop_data %>% filter(Yield >8, Sowing_Method=="Mecanizado")

#para ordenar base de datos

crop_data %>% arrange(Yield)

crop_data

#todavia no esta ordenado

#ordenar de forma decreciente
crop_data %>% arrange(desc(Yield))

#con varios criterios, primero por sowing methos y tambien por rendimiento decrecienteo

crop_data %>% arrange(Sowing_Method,desc(Yield))

#seleccionar las columnas de tiabble

crop_data %>% select(Cultivar,Yield)

#ordenar el DF
crop_data %>% select(Soil_ID, Former_Crop, everything())

#renombrar columnas rename
crop_data %>% rename(Rendimiento=Yield, Fecha_siembra = Planting_Date)

#para generar una nueva variable CBING
#funcion para genrar MUTATE, que se llame DATA SET

crop_data <- crop_data %>% mutate(Dataset ="Maiz_cordoba")
crop_data

crop_data <- crop_data %>% mutate(YielAvg = mean(Yield))
crop_data

is(crop_data$Planting_Date)

#para cambiar de texto a fecha, formatos 
#por fuera de la base de datos

is(as.Date(crop_data$Planting_Date,"%m/%d/%Y"))
#es tipo date

#para cambiar y quede mutate de fechas
crop_data <- crop_data%>%mutate(Planting_Date=as.Date(Planting_Date,"%m/%d/%Y"), 
                                Harvest_Date=as.Date(Harvest_Date, "%m/%d/%Y"))
crop_data



#para calcular otra variable, longitud de fecha

crop_data <- crop_data %>% mutate(length_cycle = Harvest_Date - Planting_Date)
crop_data
#que sea numericao

#calcular nueva variable LENGTH CYLCE la longitud del ciclo 

crop_data <- crop_data %>% mutate(length_cycle = as.numeric(Harvest_Date - Planting_Date))
crop_data

#agregar filas, FUNCION BASE DE R
tapply(crop_data$Yield, crop_data$Sowing_Method, mean)

#agregar filas con DPLYR
crop_data <- crop_data %>% group_by(Sowing_Method)
crop_data %>% summarise(promedioY = mean(Yield), maxY =max(Yield),
                        sdy = sd(Yield), promedioLC = mean(length_cycle, na.rm =T))

#agregacion por cultivar
agregado <-
  crop_data %>% group_by(Sowing_Method,Cultivar) %>% summarise(
    Avg_Yield = mean(Yield), Avg_LC = mean(Length_Cycle,na.rm=T), n = n()
  )

agregado %>% arrange(desc(n))

crop_data2 <- crop_data %>% mutate(fecha = as.character(Harvest_Date)) %>%
  separate(fecha, c("Anio","MEs", "Dia"), sep = "-")

crop_data2

# 1. Utilizar mutate para convertir el año en numerico
crop_data2 %>% mutate(Anio = as.numeric(Anio))
summary(crop_data2)

# 2. Filtrar solo los registros desde 2015 en adelante, filter
fcrop_data2 <- crop_data2%>% filter(Anio >= 2015)
fcrop_data2
summary(fcrop_data2)

# 3. Hacer un agregado por Former crop calculando promedio y mediana de rendimiento

crop_data2 %>% group_by(Former_Crop) %>% 
  summarise(PromedioY = mean(Yield), MedianaY = median(Yield))

# 4. Ordenar el conjunto de datos resultante agregado de manera ascendente por promedio de rendimiento
fcrop_data2 <- fcrop_data2 %>% arrange(PromedioY )

vrite.csv


