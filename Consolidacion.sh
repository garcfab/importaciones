#!/bin/bash


# Este script mueve los archivos procesados con el script lecturaArchivos.R a una sola carpeta para el posterior procesamiento


for ((a=2011; a <= 2014 ; a++))
do
   ruta="/Users/fabiangarcia/Documents/BBVA/Importaciones/"
   ruta=$ruta$a
   echo $ruta
   cd $ruta      
   mv *.Rda ../Total
done
