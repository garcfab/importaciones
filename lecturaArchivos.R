# Este es un script que lee los archivos planos de exportaciones del DANE
# Input: Arhivo plano del mes
# Output: Data Frame del mes, con columnas seleccionadas

rm(list=ls())
library(readr)

# Modificar WD a conveniencia. La data esta organizada por carpetas por año.
ruta <- "/Users/fabiangarcia/Documents/BBVA/Importaciones/" 

# Cambiar ano a conveniencia y correr
year = "2011"
ano = substr(year, 3, 4)

# Directorio
setwd(paste0(ruta,year))


# Definimos los nombres de nuestras variables
nombres <- c("FECHA", "ADUA", "PAISGEN", "PAISPRO", "PAISCOM", "DEPTODES", "VIATRANS", "BANDERA", 
             "REGIMEN", "ACUERDO", "PBK", "PNK", "CANU", "CODA", "NABAN", "VAFODO", "FLETE", "VACID", 
             "VACIP", "IMP1", "OTDER", "CLASE", "CUIDAIMP", "CUIDAEXP", "ACTECON", "CODADAD", "VADUA", 
             "VRAJUS", "BASEIVA", "OTROSP", "OTROSBASE", "TOTALIVAYO", "SEGUROS", "OTROSG", "LUIN", 
             "CODLUIN", "DEPIM", "COPAEX", "TIPOIM", "PORARA", "NIT", "DIGV", "RZIMP", "DEREL")


# Creamos funcion que carga el archivo y devuelve las columnas que nos interesan (PAIS DESTINO, VALOR FOB, PESO, y PARTIDA)
# y el nombre del archivo tiene en cuenta el nombre y el ano 
# del archivo

procesamiento <- function(archivo, ano, mes) {
  data <- read_fwf(archivo, fwf_widths( c(4, 2, 3, 3, 3, 2, 2, 3, 4, 3, 13, 13, 13, 3, 18, 11, 11, 13, 15, 
                                          14, 14, 1, 29, 29, 4, 2, 11, 11, 14, 8, 14, 14, 13, 13, 15, 3, 2,
                                          3, 2, 8, 16, 1, 60, 14), col_names = nombres),
                 col_types =  'cnnnnnnnccnnncnnnnnnnccccnnnnnnnnnccncnncccn')
  name <- paste0(ano,"_",mes,".Rda")
  print(name)
  data <- data[, c("PAISPRO", "PBK",  "NABAN", "VAFODO", "VACID")]
  data$date <- as.Date(paste(ano,mes,'01'), format = "%Y %m %d")
  data[nchar(data[,3])==9,3] <- paste("0", data[nchar(data[,3])==9,3], sep="") # Para uniformar el codigo de la partida
  data$NABAN <- substr(data$NABAN,1,10)
  save(file = name, x = data)
}

# Procesameniento mes a mes. Conveniente para ir pricesando el mes, a medida que vaya saliendo
procesamiento(paste0("M101", ano, ".ASU"), year, "01")
procesamiento(paste0("M102", ano, ".ASU"), year, "02")
procesamiento(paste0("M103", ano, ".ASU"), year, "03")
procesamiento(paste0("M104", ano, ".ASU"), year, "04")
procesamiento(paste0("M105", ano, ".ASU"), year, "05")
procesamiento(paste0("M106", ano, ".ASU"), year, "06")
procesamiento(paste0("M107", ano, ".ASU"), year, "07")
procesamiento(paste0("M108", ano, ".ASU"), year, "08")
procesamiento(paste0("M109", ano, ".ASU"), year, "09")
procesamiento(paste0("M110", ano, ".ASU"), year, "10")
procesamiento(paste0("M111", ano, ".ASU"), year, "11")
procesamiento(paste0("M112", ano, ".ASU"), year, "12")
