#prueba para ejecutar desde consola
#comenzado: 22/10/2015

txtPrueba <- "C:\\Users\\Usuario\\Desktop\\HPC\\FISICA_COMPUTACIONAL\\Ch3-EDP\\evolucion.txt"
datos <- read.table(txtPrueba)

plot(seq(1:ncol(datos)), datos[1,], xlab="longitud", ylab="temperatura")
for(i in 2:nrow(datos)){
  points(seq(1:ncol(datos)), datos[i-1,], col="white")
  Sys.sleep(0.1)
  points(seq(1:ncol(datos)), datos[i,])
  Sys.sleep(0.1)
}

