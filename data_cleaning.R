
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

#poner en Nan los numeros que estan fuera de rango para los datos fuera de rango de asistencia 

minimoAsistencia <- 0
maximoAsistencia <- 100

df_data_historica$asistencia[df_data_historica$asistencia< minimo 
                      | df_data_historica$asistencia > maximo] <- NA



#poner en Nan los numeros que estan fuera de rango 24 horas al dia para la caracteristica uso de redes

minimoRedes <- 0
maximoRedes <- 24

df_data_historica$uso_redes[df_data_historica$uso_redes< minimo
                            |df_data_historica$uso_redes > maximo] <- NA 




