#gramatica dplyr
#sandro arias
#2 agosto 2021

library(dplyr)
library(nycflights13)
library(ggplot2)

#paquete para hacer pasos simultaneos, una estructura de procedimientos y reduce
#reduce las lineas
mean(flights$distance)

sqrt (mean(flights$distance))

flights$distance %>% mean()

flights$distance %>% mean() %>% sqrt()

#leer una base datos

#primero ubicamos la base de datos, luego pedimos que se lea la bd
#solo estamos leyendo

"Datos/eventos_de_platano.csv" %>% read.csv() %>% summary()
#luego leeemos el texto como caracter, para que lo lea como factor STRINGASFACTOR


"Datos/eventos_de_platano.csv" %>% read.csv(stringsAsFactors = T) %>% summary()
datos_platano <- "Datos/eventos_de_platano.csv" %>% read.csv(stringsAsFactors = T)  
datos_platano %>% head()

#HACER UN GRAFICO DE NUMERO DE ARBOLES VS AREA
#PRIMERO GGPLOT SE LE DICE LA BD, LUEGO LLAMO A LA FUNCION GGPLOT
#FUNCION PARA DIAGRMA DE DISPERCION ES GEOM POINTS
#

datos_platano %>% ggplot(aes(x=NO_ARBOLES, y=AREA_UM)) + 
  geom_point() + theme_bw()

#PARA GUARDAR DENTOR DE UN VECTOR
ggplot <- datos_platano %>% ggplot(aes(x=NO_ARBOLES, y=AREA_UM)) + 
  geom_point() + theme_bw()

#para guardar

ggsave("Resultados/plot_area_arboles.png", ggplot)

#descargar git y rmarkdown
#rmarkdown para generar graficos y reportes en PDF




