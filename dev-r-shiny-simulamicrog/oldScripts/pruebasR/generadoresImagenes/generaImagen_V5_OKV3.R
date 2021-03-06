###################################
# generar imagenes
# version: 'V5.3'. Comenzado: 15/07/2015
######################################

library(MASS)#para funcion mvrnorm
#library(rgl)#para funcion plot3d()
#library(plot3D)

#############################################
#funcion para definir parametros de muestra y de imagen
##############################################3
paramEjemplo1 <- function(){
  NPIXX <<- 25
  NPIXY <<- 20
  #dataframe para los estimadores, donde el n�mero de filas
  #es el n�mero de componentes de la mixtura
  estimadoresIni <<- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  #### EJEMPLO 1 y EJEMPLO 2######
  #definimos aqui los par�metros de cinco componentes
  estimadoresIni[1,1] <<- -5
  estimadoresIni[1,2] <<- 5
  estimadoresIni[1,3] <<- 2
  estimadoresIni[1,4] <<- 2.5
  estimadoresIni[1,5] <<- 0.1
  estimadoresIni[1,6] <<- 0.225
  
  estimadoresIni[2,1] <<- 5
  estimadoresIni[2,2] <<- 5
  estimadoresIni[2,3] <<- 2
  estimadoresIni[2,4] <<- 2.5
  estimadoresIni[2,5] <<- 0.1
  estimadoresIni[2,6] <<- 0.225
  
  estimadoresIni[3,1] <<- -5
  estimadoresIni[3,2] <<- -5
  estimadoresIni[3,3] <<- 2
  estimadoresIni[3,4] <<- 2.5
  estimadoresIni[3,5] <<- 0.1
  estimadoresIni[3,6] <<- 0.225
  
  estimadoresIni[4,1] <<- 5
  estimadoresIni[4,2] <<- -5
  estimadoresIni[4,3] <<- 2
  estimadoresIni[4,4] <<- 2.5
  estimadoresIni[4,5] <<- 0.1
  estimadoresIni[4,6] <<- 0.225
  
  estimadoresIni[5,1] <<- 0
  estimadoresIni[5,2] <<- 0
  estimadoresIni[5,3] <<- 2
  estimadoresIni[5,4] <<- 2
  estimadoresIni[5,5] <<- -0.1
  estimadoresIni[5,6] <<- 0.1  
}
paramEjemplo2 <- function(){
  NPIXX <<- 45
  NPIXY <<- 45
  #dataframe para los estimadores, donde el n�mero de filas
  #es el n�mero de componentes de la mixtura
  estimadoresIni <<- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  #### EJEMPLO 1 y EJEMPLO 2######
  #definimos aqui los par�metros de cinco componentes
  estimadoresIni[1,1] <<- -5
  estimadoresIni[1,2] <<- 5
  estimadoresIni[1,3] <<- 2
  estimadoresIni[1,4] <<- 2.5
  estimadoresIni[1,5] <<- 0.1
  estimadoresIni[1,6] <<- 0.225
  
  estimadoresIni[2,1] <<- 5
  estimadoresIni[2,2] <<- 5
  estimadoresIni[2,3] <<- 2
  estimadoresIni[2,4] <<- 2.5
  estimadoresIni[2,5] <<- 0.1
  estimadoresIni[2,6] <<- 0.225
  
  estimadoresIni[3,1] <<- -5
  estimadoresIni[3,2] <<- -5
  estimadoresIni[3,3] <<- 2
  estimadoresIni[3,4] <<- 2.5
  estimadoresIni[3,5] <<- 0.1
  estimadoresIni[3,6] <<- 0.225
  
  estimadoresIni[4,1] <<- 5
  estimadoresIni[4,2] <<- -5
  estimadoresIni[4,3] <<- 2
  estimadoresIni[4,4] <<- 2.5
  estimadoresIni[4,5] <<- 0.1
  estimadoresIni[4,6] <<- 0.225
  
  estimadoresIni[5,1] <<- 0
  estimadoresIni[5,2] <<- 0
  estimadoresIni[5,3] <<- 2
  estimadoresIni[5,4] <<- 2
  estimadoresIni[5,5] <<- -0.1
  estimadoresIni[5,6] <<- 0.1  
}
paramEjemplo3 <- function(){
  NPIXX <<- 40
  NPIXY <<- 20
  #dataframe para los estimadores, donde el n�mero de filas
  #es el n�mero de componentes de la mixtura
  estimadoresIni <<- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  #### EJEMPLO 1 y EJEMPLO 2######
  #definimos aqui los par�metros de cinco componentes
  estimadoresIni[1,1] <<- -10
  estimadoresIni[1,2] <<- 5
  estimadoresIni[1,3] <<- 2.5
  estimadoresIni[1,4] <<- 2
  estimadoresIni[1,5] <<- 0.1
  estimadoresIni[1,6] <<- 0.2
  
  estimadoresIni[2,1] <<- 0
  estimadoresIni[2,2] <<- 5
  estimadoresIni[2,3] <<- 2.5
  estimadoresIni[2,4] <<- 2
  estimadoresIni[2,5] <<- -0.1
  estimadoresIni[2,6] <<- 0.2
  
  estimadoresIni[3,1] <<- 10
  estimadoresIni[3,2] <<- 5
  estimadoresIni[3,3] <<- 2.5
  estimadoresIni[3,4] <<- 2
  estimadoresIni[3,5] <<- 0.2
  estimadoresIni[3,6] <<- 0.2
  
  estimadoresIni[4,1] <<- -5
  estimadoresIni[4,2] <<- -5
  estimadoresIni[4,3] <<- 2.5
  estimadoresIni[4,4] <<- 2
  estimadoresIni[4,5] <<- -0.15
  estimadoresIni[4,6] <<- 0.06
  
  estimadoresIni[5,1] <<- 5
  estimadoresIni[5,2] <<- -5
  estimadoresIni[5,3] <<- 2.5
  estimadoresIni[5,4] <<- 2
  estimadoresIni[5,5] <<- -0.2
  estimadoresIni[5,6] <<- 0.06  
  
  estimadoresIni[6,1] <<- 20
  estimadoresIni[6,2] <<- 5
  estimadoresIni[6,3] <<- 2.5
  estimadoresIni[6,4] <<- 2
  estimadoresIni[6,5] <<- -0.2
  estimadoresIni[6,6] <<- 0.2 
  
  estimadoresIni[7,1] <<- 15
  estimadoresIni[7,2] <<- -5
  estimadoresIni[7,3] <<- 2.5
  estimadoresIni[7,4] <<- 2
  estimadoresIni[7,5] <<- -0.2
  estimadoresIni[7,6] <<- 0.08 
}
paramManual <- function(){
  #editamos/asignamos MANUALMENTE los estimadores/par�metros...
  estimadoresIni <<- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  while(sum(estimadoresIni[,6])!=1){
    estimadoresIni <<- edit(estimadoresIni)
    if(sum(estimadoresIni[,6])!=1){
      print("la suma de pesos debe de ser 1. Vuelve a introducirlos.")
    }
  }
    
  #asignacion MANUAL  de parametros de la imagen digital
  nPixeles <- data.frame(nPixeles_x=numeric(0),nPixeles_y=numeric(0))
  nPixeles <- edit(nPixeles)
  NPIXX <<- as.numeric(nPixeles[1,1])#numero de columnas de pixeles
  NPIXY <<- as.numeric(nPixeles[1,2])#numero de filas de pixeles
}
defineParametros <- function(){
  txtDatosOUT <<- "C:\\Users\\Usuario\\Desktop\\txtsPruebasR\\datosOUT.txt"
  txtEstimadoresOUT <<- "C:\\Users\\Usuario\\Desktop\\txtsPruebasR\\estimadoresOUT.txt"
  txtFactorCalidad <<- "C:\\Users\\Usuario\\Desktop\\txtsPruebasR\\factorCalidadOUT.txt"

  #numero de normales(grupos) considerados
  G <<- nrow(estimadoresIni)

  #n�mero de elementos para generar la muestra
  NMUESTRA <<- 5000

  #valor sobre el que se ``montar�'' la mixtura...
  #...el nombre ``offset'' no me lo coge... est� reservado para algo...
  offs <<- 500
}#...fin de la funcion ``defineParametros''


###########################################
#funcion para generar (y plotear) la muestra normal 2-d
###########################################
generaMuestra <- function(){
  #definimos variables
  mu <- matrix(nrow=G,ncol=2)
  sigmaArray <- array(dim=c(2,2,G))
  
  #``llenamos'' los arreglos
  i <- numeric(0)
  for(i in 1:G){
    mu[i,] <- c(estimadoresIni[i,1],estimadoresIni[i,2])
    sigmaArray[,,i] <- matrix(c(estimadoresIni[i,3]^2,
                                estimadoresIni[i,5]*estimadoresIni[i,4]*estimadoresIni[i,3],
                                estimadoresIni[i,5]*estimadoresIni[i,4]*estimadoresIni[i,3],
                                estimadoresIni[i,4]^2),2,byrow=T) 
  }

  #genera muestra normal con 5000 puntos
  set.seed(1)
  muestra <- mvrnorm(n=NMUESTRA*estimadoresIni[1,6], mu[1,], sigmaArray[,,1])
  #dim(muestra)
  #...si hay m�s de una normal, entra en el if y a�ade las dem�s...
  if(G>1){
    i <- 0
    for(i in 2:G){
      set.seed(i)
      muestra2 <- mvrnorm(n=NMUESTRA*estimadoresIni[i,6],mu[i,],sigmaArray[,,i])
      muestra <- rbind(muestra,muestra2)
      #muestra <- rbind(muestra, mvrnorm(n=NMUESTRA*estimadoresIni[i,6],mu[i,],sigmaArray[,,i]))
    }
  } 
  
  #ploteamos la muestra generada
  plot(muestra, pch='.', xlab="coordenada x", ylab="coordenada y")
  
  return(muestra)
}


#############################################################
#funcion para reescalar (y plotear) muestra y estimadores seg�n el pixelaje
#############################################################
reescala <- function(muestraOriginal){
  #muestraOriginal <- muestra
  
  #definimos y dimensionamos la nueva muestra reescalada...
  muestraRees <- matrix(nrow=nrow(muestraOriginal),ncol=ncol(muestraOriginal))
  
  ####REESCALAMOS LA MUESTRA
  #definimos rangos en la imagen analogica usando los parametros del gr�fico
  xmin <- par()$usr[1]
  xmax <- par()$usr[2]
  ymin <- par()$usr[3]
  ymax <- par()$usr[4]
  #rangox <<- c(par()$usr[1],par()$usr[2])
  #rangoy <<- c(par()$usr[3],par()$usr[4])
  #rangox <- max(muestraOriginal[,1])-min(muestraOriginal[,1])
  #rangoy <- max(muestraOriginal[,2])-min(muestraOriginal[,2])
  
  #definimos nuevos limites ampliando un poco el rango para no tener puntos en los bordes
  #limx <- c(min(muestraOriginal[,1])-((1/100)*rangox),max(muestraOriginal[,1])+((1/100)*rangox))
  #limy <- c(min(muestraOriginal[,2])-((1/100)*rangoy),max(muestraOriginal[,2])+((1/100)*rangoy))
  
  #muestra reescalada dentro de estos nnuevos limites
  #for(i in 1:nrow(muestraRees)){
  muestraRees[,1] <- NPIXX*( (muestraOriginal[,1]-xmin)/(xmax-xmin) ) 
  muestraRees[,2] <- NPIXY*( (muestraOriginal[,2]-ymin)/(ymax-ymin) ) 
  #muestraRees[,1] <- NPIXX*( (muestraOriginal[,1]-limx[1])/(limx[2]-limx[1]) ) 
  #muestraRees[,2] <- NPIXY*( (muestraOriginal[,2]-limy[1])/(limy[2]-limy[1]) ) 
  #} 
  
  #min(muestraRees[,1])
  #min(muestraRees[,2])
  #max(muestra[,2])
  #limy[2]
  #dim(muestraRees)
  #dim(muestraOriginal)
  
  
  ###PLOTEAMOS LA NUEVA MUESTRA REESCALADA
  par(tck=1, lab=c(NPIXX,NPIXY,1), yaxp=c(0,NPIXY,1), xaxp=c(0,NPIXX,1))
  plot(muestraRees, pch='.', xlab="pixeles x", ylab="pixeles y")
  
  
  ###REESCALAMOS ESTIMADORES
  #definimos los estimadores reescalados haciendo una copia de los originales...
  estimadoresIniRees <- estimadoresIni
  
  #reescalamos la media y desviaci�n en x
  estimadoresIniRees[,1] <- NPIXX*((estimadoresIni[,1]-xmin)/(xmax-xmin))
  estimadoresIniRees[,3] <- NPIXX*((estimadoresIni[,3])/(xmax-xmin))  
  #reescalamos media y desviaci�n en y
  estimadoresIniRees[,2] <- NPIXY*((estimadoresIni[,2]-ymin)/(ymax-ymin)) 
  estimadoresIniRees[,4] <- NPIXY*((estimadoresIni[,4])/(ymax-ymin)) 
  
  
  #cargamos muestra y estimadores reescalados en una lista para devolver
  reescalados <- list(muestraRees,estimadoresIniRees) 
  
  #reescalados[1]
  
  return(reescalados)   
}


###############################################
#funcion para obtener las frecuencias absolutas
###############################################
discretizaMuestra <- function(muestraReesc){
  ########33
  #muestraReesc <- muestraReescalada
  ############
  #dim(muestraReesc)
  frecAbsPorPix <- matrix(nrow=NPIXY,ncol=NPIXX)
  
  #bucle para recorrer filas/pixeles de la matriz
  for(fil in 1:(NPIXY)){
    #bucle para recorrer columnas/pixeles de la matriz
    for(col in 1:(NPIXX)){
      #las condiciones en el which, para el eje vertical, tienen en cuenta que
      #el extremo superior del rango en y coincide con la posicion (1,1) de la 
      #matriz. As� grafico y matriz tienen coherencia visual
      frecAbsPorPix[fil,col] <- length(which( muestraReesc[,1]>=(col-1)&
                                              muestraReesc[,1]<(col)&
                                              muestraReesc[,2]<(NPIXY-(fil-1))&
                                              muestraReesc[,2]>=(NPIXY-fil)  
                                              )) 
    }
  }
  

  #sum(frecAbsPorPix)
  return(frecAbsPorPix)
}


###############################################
#funcion para graficar una matriz de frecuencias
###############################################
plotea3d_V2 <- function(frecuencias){
  frecuencias <- as.matrix(frecuencias)
  
  #dim(frecuencias)
  #pixeles_x <- seq(0.5,NPIXX,by=1)         # Generamos una malla de puntos (x,y)
  pixeles_x <- seq(0.5,ncol(frecuencias)-0.5,by=0.5)#seq(0.5,10,by=0.5)
  #length(pixeles_x)
  #pixeles_x <- c(1:nPixImg_x)
  pixeles_y <- seq(0.5,nrow(frecuencias)-0.5,by=0.5)
  #pixeles_y <- seq(0.5,NPIXY,by=1)
  eventos <- matrix(nrow=nrow(frecuencias),ncol=ncol(frecuencias))
  eventos <- frecuencias[pixeles_y+0.5,pixeles_x+0.5]
  
  persp(pixeles_y,pixeles_x,eventos, zlab="brillo", zlim=c(0,max(frecuencias)), phi=30, theta=60)  # Un gr�fico en perspectiva
  #par(lty=3)
  #plot3d(pixeles_y,pixeles_x,eventos, zlim=c(0,max(frecuencias)), phi=30, theta=60)
  
}


##############################
#funcion para introducir ruido
##############################
introduceRuido <- function(frecuencias){
  #introducimos ruido de poisson y de fondo (uniforme)
  
  #...el de fondo, un 1% del maximo de frecuencias
  #ruidoFondo <- (1/100)*max(frecuencias)
  
  fil <- 0
  col <- 0
  
  lambda <- max(frecuencias)-min(frecuencias)
  
  for(fil in 1:NPIXY){
    for(col in 1:NPIXX){
      #lambda <- frecuencias[fil,col]
      #frecuencias[fil,col] <- frecuencias[fil,col]+rpois(1,lambda)+round(runif(1,min=-ruidoFondo,max=ruidoFondo))
      
      #lambda <- frecuencias[fil,col]-min(frecuencias)
      #signo <- rnorm(1,mean=0,sd=1)
      #if(signo>=0){
      #  signo <- 1
      #} else{
      #  signo <- -1
      #}
      #frecuencias[fil,col] <- frecuencias[fil,col]+(signo*rpois(1,lambda))
      frecuencias[fil,col] <- frecuencias[fil,col]+(rpois(1,lambda))
    }
  }

  return(frecuencias)
}


#################################
#funcion que escribe datos en txt
#################################
escribeDatos <- function(frecuencias){
  write.table(frecuencias, txtDatosOUT) 
  write.table(estimadoresIniReescalados, txtEstimadoresOUT) 
  
  #factorCalidad <- 0
  #factorCalidad <- edit(factorCalidad)
  #write.table(factorCalidad,  txtFactorCalidad)
   
}





########################################
################## MAIN ################
########################################

#DEFINIMOS PARAMETROS
#...definimos los ``estimadoresIni'' y pixelaje de uno u otro ejemplo...
#paramEjemplo1()
#paramEjemplo2()
paramEjemplo3()
#paramManual()

#...y dem�s variables y constantes que usaremos...
defineParametros()


#GENERAMOS LA MUESTRA
muestra <- generaMuestra()
#plotea2d(muestra)
#dim(muestra)
#min(muestra[,1]);max(muestra[,1])
#min(muestra[,2]);max(muestra[,2])



#REESCALAMOS MUESTRA Y ESTIMADORES ORIGINALES DE ACUERDO CON LOS PIXELES QUE TENEMOS
reesc <- reescala(muestra)
muestraReescalada <- as.data.frame(reesc[1])
estimadoresIniReescalados <- as.data.frame(reesc[2])
#dim(muestraReescalada)
#typeof(muestraReescalada)

#DISCRETIZAMOS LA MUESTRA Y OBTENEMOS FRECUENCIAS DE APARICION POR PIXEL
matrizFrecuencias <- discretizaMuestra(muestraReescalada)
#...a�adimos offset...
#matrizFrecuencias <- matrizFrecuencias+offs
#plotea3d(matrizFrecuencias)
#sum(matrizFrecuencias)
#y ploteamos...
plotea3d_V2(matrizFrecuencias)
plotea3d_V2(matrizFrecuencias+offs)
#View(matrizFrecuencias+offs)

###########################PLOTEA ARCHIVO DE DM##########################
#m<-read.table("C:\\Users\\Usuario\\Desktop\\txtsDatos\\datosImgDM_OUT.txt")
#m<-m-min(m)
#plotea3d_V2(m)
###########################deteccion de picos###########3

#######################test de shapiro-wilk###############
#h <- c(449634, 449418, 454251, 476939, 482821, 488044, 495400, 486484, 484862, 468701, 461693, 460468, 450369 )
#x <- c(1,2,3,4,5,6,7,8,9,10,11,12,13)
#shapiro.test(h)
#plot(x,h)
########################################################################

#INTRODUCIMOS RUIDO
#introducimos ruido de poisson...
matrizFrecuenciasNoise <- introduceRuido(matrizFrecuencias+offs)
#matrizFrecuenciasNoise2 <- matrizFrecuenciasNoise+offs
plotea3d_V2(matrizFrecuenciasNoise)
#sum(matrizFrecuenciasNoise)


#normalizamos...
#matrizFrecuenciasRelatNoise <- normalizaMuestra(matrizFrecuenciasNoise)
#sum(matrizFrecuenciasRelatNoise)



#ESCRIBIMOS DATOS Y PARAMETROS
#...podemos a�adir el valor de offset....

##matriz de frecuencias relativas
#escribeDatos(matrizFrecuenciasRelatNoise)

##matriz de frecuencias con ruido
#escribeDatos(matrizFrecuenciasNoise)

##matriz de frecuencias absolutas con ruido y offset
#escribeDatos(matrizFrecuenciasNoise+offs)

##matriz de frecuencias absolutas sin ruido pero con offset
escribeDatos(matrizFrecuencias+offs)

#####################################



########################################
#aqui cargamos el script donde esta el algoritmo.
#este script recibe una tabla de datos (frecuencias por pixel)
#como par�metro
#source("C:\\Users\\Usuario\\Desktop\\TFM\\pruebasR\\algoritmoLM_v2.R")
#txtLectura <- "C:\\Users\\Usuario\\Desktop\\TFM\\pruebasR\\datosSinteticosR.txt"

#datosOriginales <- leerTxt(txtLectura)
#datosAjustados <- algoritmoLM(datosOriginales
                              #,estimadores
                              )

#datosAjustados <- algoritmoLM(leerTxt(txtLectura),estimadores)


