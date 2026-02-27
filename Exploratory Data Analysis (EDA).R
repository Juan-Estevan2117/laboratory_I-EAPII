install.packages("pastecs")
install.packages("summarytools")
install.packages("DataExplorer")

library(pastecs)
library(summarytools)
library(DataExplorer)
library(openxlsx)
library(ggplot2)

setwd("C:/RecursosEstadistica2/laboratory_I-EAPII")

R_2021_sem1 = read.csv("data/Caso_1/rendimiento_2021_Sem1.csv")
R_2021_sem2= read.csv("data/Caso_1/rendimiento_2021_Sem2.csv" )
R_2022_sem1 = read.csv("data/Caso_1/rendimiento_2022_Sem1.csv")
R_2022_sem2 = read.csv("data/Caso_1/Rendimiento_2022_Sem2.csv")
R_2023_sem1 = read.csv("data/Caso_1/rendimiento_2023_Sem1.csv" )
R_2023_SEM2 = read.csv("data/Caso_1/rendimiento_2023_SEM2.csv")
R_2024_s1 =  read.csv("data/Caso_1/rendimiento_2024_S1.csv"   )
R_2024_sem2 = read.csv("data/Caso_1/rendimiento_2024_Sem2.csv")
R_2025_sem1 = read.csv("data/Caso_1/rendimiento_2025_Sem1.csv" )
R_2025_sem2 = read.csv("data/Caso_1/Rendimiento_2025_Sem2.csv")


#Primero revisamos que cada  archivo csv tengan las mismas columnas

archivos <- list(
  R_2021_sem1,
  R_2021_sem2,
  R_2022_sem1,
  R_2022_sem2,
  R_2023_sem1,
  R_2023_SEM2,
  R_2024_s1,
  R_2024_sem2,
  R_2025_sem1,
  R_2025_sem2
)
columnas <- lapply(archivos, colnames)  

all(sapply(columnas, function(x) identical(x, columnas[[1]])))


df_data_historica = rbind(R_2021_sem1,R_2021_sem2,R_2022_sem1,R_2022_sem2,R_2023_sem1,R_2023_SEM2,R_2024_s1,
                          R_2024_sem2,R_2025_sem1,R_2025_sem2) 

#Primera vista de los datos 
head(df_data_historica)
summary(df_data_historica)


#observar la cantidad de datos negativos por columnas 
vars <- c("horas_sueno","asistencia","horas_estudio",
          "uso_redes","ingresos_familiares")
colSums(df_data_historica[vars] < 0 , na.rm = TRUE)




#Analisar si hay valores perdidos 
plot_missing(df_data_historica)


#Histograma de  densidades para variables cuantitativas 

plot_histogram(df_data_historica)

#Identificar dato de las caracteristicas 

str(df_data_historica)

#Grafica de matriz de correlacion 

plot_correlation(df_data_historica, type = "continuous")


#grafica para datos categoricos 

plot_bar(df_data_historica)


#Revisar rango de valores para horas de estudio por semana no mayor a 168 

any(df_data_historica$horas_estudio > 168, na.rm = TRUE)

#Revisar si el rango de valores esta entre 0 y 100 para la caracteristica asistencia 
any(df_data_historica$asistencia < 0 | df_data_historica$asistencia > 100, na.rm = TRUE)
datos_fuera <- which(!(df_data_historica$asistencia >= 0 & df_data_historica$asistencia <= 100))
length(datos_fuera)


