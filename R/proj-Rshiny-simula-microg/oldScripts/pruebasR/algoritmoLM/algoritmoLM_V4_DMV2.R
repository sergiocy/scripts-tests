###########################################
# script para algoritmo Levenberg-Marquardt
# - lo adaptaremos para recoger los datos que nos da DM
# - aqui ya usaremos como origen en todos los cálculos, el propio de la imagen (esquina superior izda)
#   siendo ``x'' el número de columnas e ``y'' el número de filas
# version V4.  (comenzado: 17/05/2015)
##########################################

#library(MASS)

##################################
#FUNCION PARA LEER DATOS DE UN TXT
##################################
datosEntrada <- function(){
  txtDatosIN <- "C:\\Users\\Usuario\\Desktop\\txtsDatos\\datosImgDM_OUT.txt"
  txtEstimadoresIni <- "C:\\Users\\Usuario\\Desktop\\txtsDatos\\estimImgDM_OUT.txt"
  
  DATOS_IN <<- read.table(txtDatosIN)
  #ESTIMADORES_REALES <<- read.table(txtEstimadoresIni)
  #numero de pixeles en X e Y...
  NPIXX <<- dim(DATOS_IN)[2]
  NPIXY <<- dim(DATOS_IN)[1]
  #suma de brillos de pixeles para normalización de los datos
  SUMA_BRILLO <<- sum(DATOS_IN)
  
  #definimos unos estimadores iniciales para iniciar el algoritmo
  #dataframe para los estimadores, donde el número de filas
  #es el número de componentes de la mixtura
  ESTIMADORES_INICIALES <<- read.table(txtEstimadoresIni)
  
  #definimos el número de componentes en la mixtura
  G <<- nrow(ESTIMADORES_INICIALES)
}

######################################
#FUNCION PARA NORMALIZAR LOS DATOS
####################################
normalizaDatos <- function(matrizImagen){
  #N <- sum(frecuencias)
  
  matrizImagen <- matrizImagen/SUMA_BRILLO
  
  return (matrizImagen)
}  

#############################
#FUNCION PARA CONVERTIR LA MATRIZ DE DATOS EN UNA TABLA
#################################
convierteMatrizATabla <- function(matrizImagen){
  #matrizDatos <- matrizImagen
  #escribimos los datos en forma de tabla en vez de como matriz...
  tablaDatos <- data.frame(x=numeric(0),y=numeric(0),z=numeric(0))
  #...los cogemos y organizamos de la matriz ``frecuencias''...
  #fil <- 1
  #col <- 1
  for(col in 1:ncol(matrizImagen)){
    for(fil in 1:nrow(matrizImagen)){
      #individuo <- c(col,-fil,datos[fil,col])
      tablaDatos <- rbind(tablaDatos,c(col-0.5,fil-0.5,matrizImagen[fil,col]))
      #tablaDatos <- rbind(tablaDatos,c(col-0.5,fil-0.5,matrizImagen[nrow(matrizImagen)-fil+1,col]))
    }
  }
  names(tablaDatos) <- c("x","y","z") 
  return(tablaDatos)
}

####################################3
#FUNCION PARA CALCULAR EL GRADIENTE
######################################3
calculaGradiente <- function(){
  #fórmula de UNA normal bivariante
  formulaNormal2d <- expression( peso*(( 1/(2*pi*sx*sy*sqrt(1-rho^2)) )*( exp( (-1/(2*(1-rho^2)))*(((x-mx)^2/sx^2)+((y-my)^2/sy^2)-(2*rho*(x-mx)*(y-my)/(sx*sy))) ) )) )
  #exp1
  
  #calculamos el gradiente de una normal (una de las componentes)....
  #...el gradiente de la mixtura será un vector tal que (gradiente_comp1,...,gradiente_compG)
  parcialmx <- D(formulaNormal2d, "mx")
  parcialmy <- D(formulaNormal2d, "my")
  parcialsx <- D(formulaNormal2d, "sx")
  parcialsy <- D(formulaNormal2d, "sy")
  parcialrho <- D(formulaNormal2d, "rho")
  parcialpeso <- D(formulaNormal2d, "peso")
  
  gradiente <- c(parcialmx,parcialmy,parcialsx,parcialsy,parcialrho,parcialpeso)
  #if(dim(ESTIMADORES_INI)[1]>1){  
  #  for(G in 2:dim(ESTIMADORES_INI)[1]){
  #    gradiente <- c(gradiente,c(parcialmx,parcialmy,parcialsx,parcialsy,parcialrho,parcialpeso))
  #  }
  #}    
  return(gradiente)
}

##############################################
#FUNCION PARA ALGORITMO DE LEVENBERG-MARQUARDT
##############################################
#la funcion recibe la matriz de frecuencias y el gradiente de una componente de la mixtura
algoritmoLM <- function(tablaDatos,gradiente){
  #####variable local que quitaremos...
  #tablaDatos<-tablaDatosIn
  #gradiente<-grad
  #########
  ESTIMADORES_INI <- ESTIMADORES_INICIALES
  
  funcion <- expression(peso*( 1/(2*pi*sx*sy*sqrt(1-rho^2)) )*( exp( (-1/(2*(1-rho^2)))*(((x-mx)^2/sx^2)+((y-my)^2/sy^2)-(2*rho*(x-mx)*(y-my)/(sx*sy))) ) ))
  
  lambda <- 10#parametro de amortiguamiento de Levenberg
  J <- matrix(ncol=dim(ESTIMADORES_INI)[1]*dim(ESTIMADORES_INI)[2],nrow=dim(tablaDatos)[1])
  error_z <- matrix(nrow=dim(tablaDatos)[1])
  delta <- numeric(dim(ESTIMADORES_INI)[1]*dim(ESTIMADORES_INI)[2]) 
  RSS <- 1
  RSSvector <<- 0
  
  ###habrá que cambiar el iterador por condición
  iterador <- 1
  while(RSS > 0.00001){
    #...caculamos J y el error (y_obs - y_est)...
    #i <- 1
    for(i in 1:dim(tablaDatos)[1]){
      x <- tablaDatos$x[i]
      y <- tablaDatos$y[i]
      error_z[i] <- 0
      mixtura <- 0
      for(componente in 1:G){
        mx <- ESTIMADORES_INI[componente,1] 
        my <- ESTIMADORES_INI[componente,2]
        sx <- ESTIMADORES_INI[componente,3]
        sy <- ESTIMADORES_INI[componente,4]
        rho <- ESTIMADORES_INI[componente,5]
        peso <- ESTIMADORES_INI[componente,6]
    
        for( m in 1:length(gradiente) ){
          J[i,(componente*ncol(ESTIMADORES_INI))-ncol(ESTIMADORES_INI)+m] <- eval(parse(text = gradiente[m]))
        } 
        
        #calculamos el valor de la mixtura para los estimadores ajustados
        mixtura <- mixtura + eval(parse(text = funcion))
      }
      #calculamos la diferencia entre el valor observado y el ajustado
      error_z[i] <- tablaDatos$z[i] - mixtura
    } 
    #calculamos la suma cuadratica de errores
    RSS <- sum(error_z^2)
    
    #calculamos el incremento ``delta'' para los estimadores ajustados
    A <- (t(J)%*%J)+( (lambda/2^iterador)*diag(length(gradiente)*G) )#lambda*diag(t(J)%*%J)#
    b <- t(J)%*%error_z
    delta <- solve(A,b)
  
    #recalculamos estimadores para la siguiente iteración
    for(componente in 1:G){
      for(m in 1:ncol(ESTIMADORES_INI)){
        ESTIMADORES_INI[componente,m] <- ESTIMADORES_INI[componente,m] + delta[(componente*ncol(ESTIMADORES_INI))-6+m] 
      }
    }
    
  print(c(iterador,RSS))
  
  #####################
  #vamos graficando el RSS...
  RSSvector <<- c(RSSvector,RSS)
  #plot(seq(1:iterador),RSSvector)
  ####################
  
  iterador <- iterador+1
  }
  return(ESTIMADORES_INI)
}

##########################################################
#FUNCION PARA CALCULAR LOS VALORES PREDICHOS POR EL MODELO
#########################################################
calculaPuntosAjustados <- function(tablaDatos,estimadores){
  #######3
  #tablaDatos <- tablaDatosIn
  #estimadores <- estimadoresAjustados
  ##########3
  funcion <- expression(peso*( 1/(2*pi*sx*sy*sqrt(1-rho^2)) )*( exp( (-1/(2*(1-rho^2)))*(((x-mx)^2/sx^2)+((y-my)^2/sy^2)-(2*rho*(x-mx)*(y-my)/(sx*sy))) ) ))
  
  for(fil in 1:nrow(tablaDatos)){
    x <- tablaDatos[fil,1]
    y <- tablaDatos[fil,2]
    z <- 0
    for(componente in 1:nrow(estimadores)){
      mx <- estimadores[componente,1] 
      my <- estimadores[componente,2]
      sx <- estimadores[componente,3]
      sy <- estimadores[componente,4]
      rho <- estimadores[componente,5]
      peso <- estimadores[componente,6] 
      
      z <- z + eval(parse(text = funcion))
    }
    tablaDatos[fil,3] <- z
  }
  
  return(tablaDatos)
}

############################################
#FUNCION PARA CONVERTIR TABLA DE DATOS A MATRIZ
#######################################
convierteTablaAMatriz <- function(tablaDatos){
  ###########3
  #tablaDatos <- tablaDatosOut
  ############
  matrizImagen <- matrix(nrow=nrow(DATOS_IN),ncol=ncol(DATOS_IN))
  
  for(col in 1:ncol(matrizImagen)){
    #col <- 1
    #for(fil in 1:nrow(matrizImagen)){
      columna <- tablaDatos[which(tablaDatos[,1]==(col-0.5)),3]
      #length(columna)
      matrizImagen[,col] <- columna
      ##################
    #}
  }
  
  return(matrizImagen)
}

######################################
#FUNCION PARA ``DESNORMALIZAR'' LOS DATOS
#####################################3
desnormalizaDatos <- function(matrizImagen){
  #N <- sum(frecuencias)
  
  matrizImagen <- matrizImagen*SUMA_BRILLO
  
  return (matrizImagen)
}  

#############################################
#funcion para escribir datos
##############################
datosSalida <- function(estimAjustados,datosAjustados){
  txtDatosOUT <- "C:\\Users\\Usuario\\Desktop\\txtsDatos\\datosImgDM_IN.txt"
  txtEstimadoresOUT <- "C:\\Users\\Usuario\\Desktop\\txtsDatos\\estimImgDM_IN.txt"
  
  write.table(estimAjustados,txtEstimadoresOUT, row.names=F, col.names=F)
  write.table(datosAjustados,txtDatosOUT, row.names=F, col.names=F)
  
  ###############3
  #datosAjustados<-read.table("C:\\Users\\Usuario\\Desktop\\TFM\\datosImgDM_OUT_prueba1.txt")
  #estimAjustados<-read.table("C:\\Users\\Usuario\\Desktop\\TFM\\estimImgDM_OUT_prueba1.txt")
  #####################
  
  #esribimos datos y estimadores en una columna, habiendolos tomado de la matriz por filas
  txtDatosOUTColumna <- "C:\\Users\\Usuario\\Desktop\\txtsDatos\\ColumnaDatosImgDM_IN.txt"
  txtEstimadoresOUTColumna <- "C:\\Users\\Usuario\\Desktop\\txtsDatos\\ColumnaEstimImgDM_IN.txt"
  vectorDatos <- numeric(0)
  vectorEstim <- numeric(0)
  
  for(fil in 1:nrow(datosAjustados)){
    for(col in 1:ncol(datosAjustados)){
      vectorDatos <- c(vectorDatos,datosAjustados[fil,col])
    }
  }
  write.table(as.matrix(vectorDatos),txtDatosOUTColumna, row.names=F, col.names=F)
  
  for(fil in 1:nrow(estimAjustados)){
    for(col in 1:ncol(estimAjustados)){
      vectorEstim <- c(vectorEstim,estimAjustados[fil,col])
    }
  }
  write.table(as.matrix(vectorEstim),txtEstimadoresOUTColumna, row.names=F, col.names=F)
}




##################################################################
####  MAIN  ######################################################
##################################################################


####### PREPROCESADO DE DATOS DE ENTRADA ########################

#RECIBO DATOS DE ENTRADA: estimadores iniciales, matriz de datos y tamanio de la imagen
datosEntrada()
#View(DATOS_IN)
#View(ESTIMADORES_INICIALES)

#NORMALIZAMOS LOS DATOS DE ENTRADA PARA EL PROCESADO
datosInNormalizados <- normalizaDatos(DATOS_IN)

#PONEMOS LA MATRIZ DE ENTRADA COMO TABLA
tablaDatosIn <- convierteMatrizATabla(datosInNormalizados)
#View(tablaDatosIn)



############### AJUSTE ######################################

#CALCULAMOS GRADIENTE
grad <- calculaGradiente()

#EJECUTAMOS EL ALGORITMO pasando la tabla de datos 
estimadoresAjustados <- algoritmoLM(tablaDatosIn,grad)
#...podemos representar el RSS en cada iteración del algoritmo
#plot(2:length(RSSvector),RSSvector[2:length(RSSvector)])

#CALCULAMOS LOS PUNTOS AJUSTADOS
tablaDatosOut <- calculaPuntosAjustados(tablaDatosIn,estimadoresAjustados)
#View(tablaDatosOut)



###################### PREPARACION DE DATOS DE SALIDA #################

# convertimos ``tablaDatosOut'' a matriz...
matrizImagenAjustada <- convierteTablaAMatriz(tablaDatosOut)
#View(matrizImagenAjustada)

# desnormalizamos datos...
DATOS_OUT <- desnormalizaDatos(matrizImagenAjustada)
#View(DATOS_OUT)

#.....habrá que escribir los datos ajustados y estimadores a ficheros....
datosSalida(estimadoresAjustados,DATOS_OUT)





#########NOTAS##############
#- habra que ver como recibo los datos desde DM y adaptar ``leerTXT()''
#- debería de recibir:
#         numero de normales-parametros iniciales
#         dimensiones de la imagen
#         nombre del fichero
#- habrá que ver como tratar los efectos de bordes
#- quizá haya que normalizar la imagen
