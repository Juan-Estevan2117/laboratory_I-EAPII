
install.packages("mice")
install.packages("tidyr")
install.packages("dplyr")

library(mice)
library(DataExplorer)
library(ggplot2)
library(dplyr)
library(lattice)

#Poner todos los negativos a Na 
df_data_historica$horas_estudio[df_data_historica$horas_estudio < 0] <- NA
df_data_historica$horas_sueno[df_data_historica$horas_sueno< 0] <- NA
df_data_historica$uso_redes[df_data_historica$uso_redes< 0] <- NA
df_data_historica$ingresos_familiares[df_data_historica$ingresos_familiares < 0] <- NA
df_data_historica$asistencia[df_data_historica$asistencia < 0] <- NA
df_data_historica$estres[df_data_historica$estres < 0] <- NA


#Analisar si hay valores perdidos 
plot_missing(df_data_historica)


#poner todo en minuscula
df_data_historica$genero <- tolower(df_data_historica$genero)
df_data_historica$acceso_internet <- tolower(df_data_historica$acceso_internet)
df_data_historica$trabaja <- tolower(df_data_historica$trabaja)
df_data_historica$carrera <- tolower(df_data_historica$carrera)
df_data_historica$modalidad <- tolower(df_data_historica$modalidad)
df_data_historica$semestre <- tolower(df_data_historica$semestre)

#dejar todo en un mismo lenguaje

df_data_historica$acceso_internet[df_data_historica$acceso_internet == "yes"] <- "si"
df_data_historica$carrera[df_data_historica$carrera == "busines"]<-"business" 
df_data_historica$carrera[df_data_historica$carrera == "business"]<-"negocios" 
df_data_historica$carrera[df_data_historica$carrera == "cs"]<- "ciencias de la Computacion"
df_data_historica$genero[df_data_historica$genero == "female"] <- "mujer"
df_data_historica$genero[df_data_historica$genero == "male"] <- "hombre"
df_data_historica$carrera[df_data_historica$carrera == "data"]<-"datos" 
df_data_historica$trabaja[df_data_historica$trabaja == "sí"] <- "si"
#poner en Nan los numeros que estan fuera de rango para los datos fuera de rango de asistencia 


#minimoAsistencia <- 0
#maximoAsistencia <- 100

#df_data_historica$asistencia[df_data_historica$asistencia< minimoAsistencia 
 #                     | df_data_historica$asistencia > maximoAsistencia] <- NA



#poner en Nan los numeros que estan fuera de rango 24 horas al dia para la caracteristica uso de redes

minimoRedes <- 0
maximoRedes <- 24

df_data_historica$uso_redes[df_data_historica$uso_redes< minimoRedes
                            |df_data_historica$uso_redes > maximoRedes] <- NA 

#Datos Nulos por columna 
NulosPorColumna <- colSums(is.na(df_data_historica))
print(NulosPorColumna)


-----------------------------------------------------------------------------------------
#                                 IMPUTACION DE DATOS 
-----------------------------------------------------------------------------------------
  
  #para las variables con pocos datos la media 
  #ingresos familiares = 1
  #uso de redes = 19
  #horas_sueno = 4
  
  
  df_final <- df_data_historica
  
  
  variables_media <- c("ingresos_familiares", "horas_sueno", "uso_redes")
  
  for (v in variables_media) {
    df_final[[v]][is.na(df_final[[v]])] <- mean(df_final[[v]], na.rm = TRUE)
  }
  
  
#para carrera utilizaremos la moda
  
  moda_carrera <- names(sort(table(df_final$carrera),decreasing = TRUE))[1]
  df_final$carrera[is.na(df_final$carrera)] <- moda_carrera
  
#Para las variables con mas Nulos usamos MICE
#Asistencia = 103
#Horas de estudio = 123
#promedio previo = 74
#estres = 89
  
  vars_mice <- c("horas_estudio", "asistencia", "promedio_previo", "estres")
  imp <- mice(
    df_final[, vars_mice],
    m = 5,
    method = "pmm",
    seed = 123
  )
  
  df_final[, vars_mice] <- complete(imp, 1)
  
  colSums(is.na(df_final))
  
  
# variables numericas que se imputaron 
  vars <- c("ingresos_familiares", "horas_sueno", "uso_redes",
            "horas_estudio", "asistencia", "promedio_previo", "estres")
  
# histogramas 
  for (v in vars) {
    if (v %in% names(df_data_historica)) {
      hist(df_data_historica[[v]], breaks = 25, col = "#0000FF40", main = v,
           xlab = "valor", freq = FALSE, border = "blue", las = 1)
      hist(df_final[[v]], breaks = 25, col = "#FF000040", add = TRUE, freq = FALSE,
           border = "darkred")
      legend("topright", legend = c("original", "imputado"),
             fill = c("#0000FF40", "#FF000040"), border = c("blue","darkred"))
    }
  }
  
#stripplots para las variables imputadas
  stripplot(imp, pch = 20, cex = 1.1, layout = c(2, 2))
  
 
#densidad de los datos imputados 
  densityplot(imp)
  
  
