rm(list=ls())

# Script que une toda la data
# Modificar WD a conveniencia
setwd('/Users/fabiangarcia/Documents/BBVA/Importaciones/Total/')

# Cambiar ano
year = "2014"

# Cargamos el ultimo mes
load("2014_12.Rda")
mm <- data

for ( n in seq(2011, 2014) ) {
  for (m in seq(1,12) ) {
    if (m < 10) {
      ruta <- (paste0(n,"_0",m,".Rda"))
    } else {
      ruta <- (paste0(n,"_",m,".Rda"))
    }
   
    if (n == 2014 & m == 12) {
      break
    }
    load(ruta)
    mm <- rbind(mm,data)
  } 
}

# Finalmente salvamos la data
save(xx, file= "mm.Rda")
 