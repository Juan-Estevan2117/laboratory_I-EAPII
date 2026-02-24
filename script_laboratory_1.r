install.packages("corrplot")

library(openxlsx)
library(corrplot)
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

#Comparacion de Nombres 

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


#convertir en un dataset unificado 

df_data_historica = rbind(R_2021_sem1,R_2021_sem2,R_2022_sem1,R_2022_sem2,R_2023_sem1,R_2023_SEM2,R_2024_s1,
                        R_2024_sem2,R_2025_sem1,R_2025_sem2) 


summary(df_data_historica)

