# -------------------------------------------------------------------------
# loading packages
# -------------------------------------------------------------------------
# Usa el directorio actual como directorio raiz, evitando escribir setwd()

library(here)

here()

# -------------------------------------------------------------------------
# CASO 1
# -------------------------------------------------------------------------

# 

# -------------------------------------------------------------------------
# Analisis exploratorio
# -------------------------------------------------------------------------

# Carga de archivos .csv

df_2021_sem1 = read.csv("data/Caso_1/rendimiento_2021_sem1.csv")
df_2021_sem2 = read.csv("data/Caso_1/rendimiento_2021_sem2.csv")
df_2022_sem1 = read.csv("data/Caso_1/rendimiento_2022_sem1.csv")
df_2022_sem2 = read.csv("data/Caso_1/rendimiento_2022_sem2.csv")
df_2023_sem1 = read.csv("data/Caso_1/rendimiento_2023_sem1.csv")
df_2023_sem2 = read.csv("data/Caso_1/rendimiento_2023_sem2.csv")
df_2024_sem1 = read.csv("data/Caso_1/rendimiento_2024_sem1.csv")
df_2024_sem2 = read.csv("data/Caso_1/rendimiento_2024_sem2.csv")
df_2025_sem1 = read.csv("data/Caso_1/rendimiento_2025_sem1.csv")
df_2025_sem2 = read.csv("data/Caso_1/rendimiento_2025_sem2.csv")

archivos <- list(
  df_2021_sem1,
  df_2021_sem2,
  df_2022_sem1,
  df_2022_sem2,
  df_2023_sem1,
  df_2023_sem2,
  df_2024_sem1,
  df_2024_sem2,
  df_2025_sem1,
  df_2025_sem2
)

columnas <- lapply(archivos, colnames)

all(sapply(columnas, function(x) identical(x, columnas[[1]])))

# revisamos los archivos manualmente para verificar que tuviesen las mismas
# columnas.

df_data_historica = rbind(df_2021_sem1, df_2021_sem2, df_2022_sem1, df_2022_sem2, 
                          df_2023_sem1, df_2023_sem2, df_2024_sem1, df_2024_sem2, 
                          df_2025_sem1, df_2025_sem2)

summary(df_data_historica)



