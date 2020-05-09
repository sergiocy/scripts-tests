###################################
# generar imagenes
# version: 'V5.4'. Comenzado: 1/08/2015
######################################

library(MASS)#para funcion mvrnorm

#############################################
#funcion para definir parametros de muestra y de imagen
##############################################3
paramEjemplo1 <- function(){
  NPIXX <<- 25
  NPIXY <<- 20
  #dataframe para los estimadores, donde el número de filas
  #es el número de componentes de la mixtura
  estimadoresIni <<- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  #### EJEMPLO 1######
  #definimos aqui los parámetros de cinco componentes
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
  #dataframe para los estimadores, donde el número de filas
  #es el número de componentes de la mixtura
  estimadoresIni <<- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  ####EJEMPLO 2######
  #definimos aqui los parámetros de cinco componentes
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
  #dataframe para los estimadores, donde el número de filas
  #es el número de componentes de la mixtura
  estimadoresIni <<- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  #### EJEMPLO 3######
  #definimos aqui los parámetros de cinco componentes
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
  #editamos/asignamos MANUALMENTE los estimadores/parámetros...
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

  #número de elementos para generar la muestra
  NMUESTRA <<- 5000

  #valor sobre el que se ``montará'' la mixtura...
  #...el nombre ``offset'' no me lo coge... está reservado para algo...
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
  #...si hay más de una normal, entra en el if y añade las demás...
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
#funcion para reescalar (y plotear) muestra y estimadores según el pixelaje
#############################################################
reescala <- function(muestraOriginal){
  #muestraOriginal <- muestra
  
  #definimos y dimensionamos la nueva muestra reescalada...
  muestraRees <- matrix(nrow=nrow(muestraOriginal),ncol=ncol(muestraOriginal))
  
  #### REESCALAMOS LA MUESTRA ###################
  #definimos rangos en la imagen analogica usando los parametros del gráfico
  xmin <- par()$usr[1]
  xmax <- par()$usr[2]
  ymin <- par()$usr[3]
  ymax <- par()$usr[4]
  
  muestraRees[,1] <- NPIXX*( (muestraOriginal[,1]-xmin)/(xmax-xmin) ) 
  muestraRees[,2] <- NPIXY*( (muestraOriginal[,2]-ymin)/(ymax-ymin) ) 
  
  ##### PLOTEAMOS LA NUEVA MUESTRA REESCALADA ##############
  par(tck=1, lab=c(NPIXX,NPIXY,1), yaxp=c(0,NPIXY,1), xaxp=c(0,NPIXX,1))
  plot(muestraRees, pch='.', xlab="pixeles x", ylab="pixeles y")
  
  
  ##### REESCALAMOS ESTIMADORES ##################
  #definimos los estimadores reescalados haciendo una copia de los originales...
  estimadoresIniRees <- estimadoresIni
  
  #reescalamos la media y desviación en x
  estimadoresIniRees[,1] <- NPIXX*((estimadoresIni[,1]-xmin)/(xmax-xmin))
  estimadoresIniRees[,3] <- NPIXX*((estimadoresIni[,3])/(xmax-xmin))  
  #reescalamos media y desviación en y
  estimadoresIniRees[,2] <- NPIXY*((estimadoresIni[,2]-ymin)/(ymax-ymin)) 
  estimadoresIniRees[,4] <- NPIXY*((estimadoresIni[,4])/(ymax-ymin)) 
  
  
  #cargamos muestra y estimadores reescalados en una lista para devolver
  reescalados <- list(muestraRees,estimadoresIniRees) 

  
  return(reescalados)   
}


###############################################
#funcion para obtener las frecuencias absolutas
###############################################
discretizaMuestra <- function(muestraReesc){
  
  frecAbsPorPix <- matrix(nrow=NPIXY,ncol=NPIXX)
  
  #bucle para recorrer filas/pixeles de la matriz
  for(fil in 1:(NPIXY)){
    #bucle para recorrer columnas/pixeles de la matriz
    for(col in 1:(NPIXX)){
      #las condiciones en el which, para el eje vertical, tienen en cuenta que
      #el extremo superior del rango en y coincide con la posicion (1,1) de la 
      #matriz. Así grafico y matriz tienen coherencia visual
      frecAbsPorPix[fil,col] <- length(which( muestraReesc[,1]>=(col-1)&
                                              muestraReesc[,1]<(col)&
                                              muestraReesc[,2]<(NPIXY-(fil-1))&
                                              muestraReesc[,2]>=(NPIXY-fil)  
                                              )) 
    }
  }
  

  return(frecAbsPorPix)
}


###############################################
#funcion para graficar una matriz de frecuencias
###############################################
plotea3d_V2 <- function(frecuencias){
  frecuencias <- as.matrix(frecuencias)
  
  #dim(frecuencias)
  #pixeles_x <- seq(0.5,NPIXX,by=1)         # Generamos una malla de puntos (x,y)
  pixeles_x <- seq(0.5,ncol(frecuencias)-0.5,by=1)#seq(0.5,10,by=0.5)
  #length(pixeles_x)
  #pixeles_x <- c(1:nPixImg_x)
  pixeles_y <- seq(0.5,nrow(frecuencias)-0.5,by=1)
  #pixeles_y <- seq(0.5,NPIXY,by=1)
  eventos <- matrix(nrow=nrow(frecuencias),ncol=ncol(frecuencias))
  eventos <- frecuencias[pixeles_y+0.5,pixeles_x+0.5]
  
  persp(pixeles_y,pixeles_x,eventos, zlab="brillo", zlim=c(0,max(frecuencias)), phi=30, theta=60)  # Un gráfico en perspectiva
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
  
  #fil <- 0
  #col <- 0
  
  #parámetros lambda=(promedio de eventos detectados por pixel)
  #...el tamaño de la muestra (``NMUESTRA'') entre el número de pixeles (``NPIXX''*``NPIXY'')
  #lambda <- NMUESTRA/(NPIXX*NPIXY)
  
  #lambda <- sum(frecuencias)/(NPIXX*NPIXY)
  
  #lambda <- max(frecuencias)-min(frecuencias)
  
  #ruido de fondo proporcional al offset. En este caso, el 2% de dicho offset
  ruidoFondo <- (2/100)*offs
  
  
  for(fil in 1:NPIXY){
    for(col in 1:NPIXX){
      #añadimos el ruido de poisson proporcional al brillo de cada pixel
      lambda <- frecuencias[fil,col]
      #frecuencias[fil,col] <- frecuencias[fil,col]+(rpois(1,lambda))
      #frecuencias[fil,col] <- frecuencias[fil,col]+rpois(1,ruidoFondo)
      
      ##########3
      #poisson en los picos y uniforme asociado al offset
      frecuencias[fil,col] <- (rpois(1,lambda))+runif(1,min=-ruidoFondo,max=ruidoFondo)
      ##########
      #frecuencias[fil,col] <- frecuencias[fil,col]+runif(1,min=-ruidoFondo,max=ruidoFondo)
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
paramEjemplo1()
#paramEjemplo2()
#paramEjemplo3()
#paramManual()

#...y demás variables y constantes que usaremos...
defineParametros()


#GENERAMOS LA MUESTRA
muestra <- generaMuestra()

#REESCALAMOS MUESTRA Y ESTIMADORES ORIGINALES DE ACUERDO CON LOS PIXELES QUE TENEMOS
reesc <- reescala(muestra)
muestraReescalada <- as.data.frame(reesc[1])
estimadoresIniReescalados <- as.data.frame(reesc[2])
#dim(muestraReescalada)
#typeof(muestraReescalada)

#DISCRETIZAMOS LA MUESTRA Y OBTENEMOS FRECUENCIAS DE APARICION POR PIXEL
matrizFrecuencias <- discretizaMuestra(muestraReescalada)#(max(matrizFrecuencias+offs)-min(matrizFrecuencias+offs))/min(matrizFrecuencias+offs)
#...añadimos offset...
#...y ploteamos...
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
matrizFrecuenciasNoise <- introduceRuido(matrizFrecuencias)
#(max(matrizFrecuenciasNoise+offs)-min(matrizFrecuenciasNoise+offs))/min(matrizFrecuenciasNoise+offs)
#matrizFrecuenciasNoise2 <- matrizFrecuenciasNoise+offs
plotea3d_V2(round(matrizFrecuenciasNoise+offs))
#sum(matrizFrecuenciasNoise)


#ESCRIBIMOS DATOS Y PARAMETROS
#...podemos añadir el valor de offset....

##matriz de frecuencias relativas
#escribeDatos(matrizFrecuenciasRelatNoise)

##matriz de frecuencias con ruido
#escribeDatos(matrizFrecuenciasNoise)

##matriz de frecuencias absolutas con ruido y offset
escribeDatos(round(matrizFrecuenciasNoise+offs))

##matriz de frecuencias absolutas sin ruido pero con offset
#escribeDatos(matrizFrecuencias+offs)

#####################################




