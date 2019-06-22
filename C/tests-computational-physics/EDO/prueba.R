#prueba para ejecutar desde consola
#comenzado: 18/10/2015

txtPrueba <- "C:\\Users\\Usuario\\Desktop\\HPC\\FISICA_COMPUTACIONAL\\Ch2-EDO\\posiciones.txt"
datos <- read.table(txtPrueba) 
plot(datos$V1, datos$V2, xlab="horizontal", ylab="altura")

 
