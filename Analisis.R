rm(list=ls())
#library(dplyr)
library(data.table)

# Script que une toda la data
# Modificar WD a conveniencia
setwd('/Users/fabiangarcia/Documents/BBVA/Importaciones/Total/')

load(file = "mm.Rda")

# Creacion de grupos
dt <- data.table(mm)

dt[NABAN %in% c("2711210000", "2711210010"), grupo := "Gas Natural"]
dt[NABAN %in% c("2709000000"), grupo := "Petroleo"]
dt[NABAN %in% c("2710111100"), grupo := "Gasolina aviación"]
dt[NABAN %in% c("2710111200", "2710111300", "2710111900", "2710112000"), grupo := "Gasolina motor"]
dt[NABAN %in% c("2710191100", "2710191500"), grupo := "Querosene.Jet Fuel"]
dt[NABAN %in% c("2710191400"), grupo := "Otro Kerosene"]
dt[NABAN %in% c("2710192100", "2710005010"), grupo := "Gas/Diesel/Fuel Oil"]
dt[NABAN %in% c("2711120000", "2711130000", "2711140000"), grupo := "Gasolina licuado de petroleo"]

peso <- dt[,.(FOB.Sum = sum(PBK)),by=.(date,grupo)]
valor <- dt[,.(FOB.Sum = sum(PBK)),by=.(date,grupo)]

write.csv(peso, file = "/Users/fabiangarcia/Documents/BBVA/Scripts/importaciones/peso.csv")

write.csv(valor, file = "/Users/fabiangarcia/Documents/BBVA/Scripts/importaciones/valor.csv")

# Link donde saque las partidas: https://www.dane.gov.co/files/investigaciones/pib/ambientales/Flujos_energetico.pdf



mm <- mm %>% mutate(grupo = ifelse(NABAN == "2711210000" | NABAN == "2711210010", "Gas Natural", "Otro") )

mm <- mm %>% mutate(grupo = ifelse(NABAN == "2709000000" , "Petróleo", "Otro") )
 
mm <- mm %>% mutate(grupo = ifelse(NABAN == "2710111100", "Gasolina aviación", "Otro") )

mm <- mm %>% mutate(grupo = ifelse(NABAN == "2710111200" | NABAN == "2710111300" | NABAN == "2710111900" | NABAN == "2710112000", "Gasolina motor", "Otro") )

mm <- mm %>% mutate(grupo = ifelse(NABAN == "2710191100" | NABAN == "2710191500", "Querosene jet fuel", "Otro") )

mm <- mm %>% mutate(grupo = ifelse(NABAN == "2710191400" , "Otro Querosene", "Otro") )

mm <- mm %>% mutate(grupo = ifelse(NABAN == "2710192100" | NABAN == "2710005010", "Gas/Diesel/Fuel Oil", "Otro") )

mm <- mm %>% mutate(grupo = ifelse(NABAN == "2711120000" | NABAN == "2711130000" | NABAN == "2711140000", "Gas Licuado del Petroleo", "Otro") )

