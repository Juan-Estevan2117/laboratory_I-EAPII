install.packages("corrplot")
install.packages("Hmisc")
install.packages("naniar")
install.packages("tidyverse")
install.packages("mice")


library(openxlsx)
library(corrplot)
library(ggplot2)
library(Hmisc)
library(naniar)
library(tidyverse)
library(mice)




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
describe(df_data_historica)

#observar la cantidad de datos negativos por columnas 
vars <- c("horas_sueno","asistencia","horas_estudio",
          "uso_redes","ingresos_familiares")
colSums(df_data_historica[vars] < 0 , na.rm = TRUE)

#graficas para observar outliers 

hist(df_data_historica$uso_redes)
boxplot(df_data_historica$uso_redes)

#limpieza

#poner todo en lowercase
df_data_historica$genero <- tolower(df_data_historica$genero)
df_data_historica$acceso_internet <- tolower(df_data_historica$acceso_internet)
df_data_historica$trabaja <- tolower(df_data_historica$trabaja)
df_data_historica$carrera <- tolower(df_data_historica$carrera)
df_data_historica$modalidad <- tolower(df_data_historica$modalidad)
df_data_historica$semestre <- tolower(df_data_historica$semestre)

#dejar todo en un mismo lenguaje

df_data_historica$trabaja[df_data_historica$trabaja == "si"] <- "yes"
df_data_historica$carrera[df_data_historica$carrera == "busines"]<-"business" 
df_data_historica$carrera[df_data_historica$carrera == "ingenieria"]<-"engineer" 
df_data_historica$carrera[df_data_historica$carrera == "cs"]<- "computer science"
df_data_historica$modalidad[df_data_historica$modalidad == "presencial"] <- "in-person"
df_data_historica$semestre[df_data_historica$semestre == "sem1"] <- "week1"
df_data_historica$semestre[df_data_historica$semestre == "sem2"] <- "week2"

#cambiar datos negativos de algunas columnas especificas por NA 

df_data_historica$horas_estudio[df_data_historica$horas_estudio < 0] <- NA
df_data_historica$horas_sueno[df_data_historica$horas_sueno< 0] <- NA
df_data_historica$uso_redes[df_data_historica$uso_redes< 0] <- NA
df_data_historica$ingresos_familiares[df_data_historica$ingresos_familiares < 0] <- NA


#Analisis de datos faltantes

miss_var_summary(df_data_historica)
#grafico de datos faltantes
gg_miss_var(df_data_historica, show_pct = TRUE)

#grafico de datos faltantes por caracteristica
vis_miss(df_data_historica)

#grfico para observar datos 
gg_miss_upset(df_data_historica)

#imputacion de datos con el metodo de imputacion multivariada por ecuaciones concatenadas con pmm para
# datos numericos 


#convertimos la caracteristica carrera a factor 
df_data_historica$carrera <- as.factor(df_data_historica$carrera)
str(df_data_historica$carrera)

metodos <- make.method(df_data_historica)

metodos[c("horas_sueno",
          "uso_redes",
          "promedio_previo",
          "estres",
          "asistencia",
          "horas_estudio")] <- "pmm"

metodos["carrera"]<- "polyreg"


impData <- mice(df_data_historica,
                method =  metodos,
                m = 5,
                maxit = 50,
                seed = 500)



plot(impDta)

#modelo de regresion multiple
modelo <- with(impData,
               lm(puntaje_final ~ 
                    horas_estudio +
                    asistencia +
                    promedio_previo +
                    estres +
                    uso_redes +
                    horas_sueno +
                    edad +
                    ingresos_familiares +
                    genero +
                    carrera +
                    modalidad))

summary(pool(modelo))

#Modelo solo con las variables significativas

modelo_reducido <- with(impData,
                        lm(puntaje_final ~ 
                             horas_estudio +
                             asistencia +
                             promedio_previo +
                             estres +
                             uso_redes +
                             carrera +
                             modalidad))

summary(pool(modelo_reducido))


