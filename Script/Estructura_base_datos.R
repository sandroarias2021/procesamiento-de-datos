
#estructura base de datos
#sandro arias 
#3/8/2021
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)
data_long <- read.csv("Datos/Cierre_agricola_mun_long.csv")
#remplazar valorex textos 
str_replace_all(data_long$Nommunicipio, c("Ã³" = "O", "Ã¡" = "a", "Ã" = "i"))


#pasando a tibble
data_long <- tibble(data_long)      
data_long

#grafico sin editar
data_long %>% ggplot(aes(x=Nommodalidad, y=value)) + geom_boxplot()+
  facet_wrap(~Variable, scales = "free")

#para poner en columnas

datos_censo <- data_long %>% pivot_wider(id_cols = c("Nommunicipio","Nommodalidad"),
                                         names_from = "Variable", 
                                         values_from = "value")

datos_censo

summary(datos_censo)

datos_censo %>% pivot_wider(id_cols = "Nommunicipio", names_from = "Nommodalidad", values_from = "Rendimiento")

#para cambiar al formato inicial
datos_censo %>% pivot_longer(cols = c("Area", "Rendimiento"

Nommunicipio", names_from = "Nommodalidad", values_from = "Rendimiento")



#para reemplazar cambiar los errores en la bade de datos


