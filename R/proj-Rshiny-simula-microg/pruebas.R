

paramEjemplo1 <- function(){
  #NPIXX <<- 25
  #NPIXY <<- 20
  #dataframe para los estimadores, donde el número de filas
  #es el número de componentes de la mixtura
  estimadoresIni <- data.frame(media_x=numeric(0),
                                media_y=numeric(0),
                                sigma_x=numeric(0),
                                sigma_y=numeric(0),
                                coefCorr=numeric(0),
                                peso=numeric(0))
  
  #### EJEMPLO 1######
  #definimos aqui los parámetros de cinco componentes
  estimadoresIni[1,1] <- -5
  estimadoresIni[1,2] <- 5
  estimadoresIni[1,3] <- 2
  estimadoresIni[1,4] <- 2.5
  estimadoresIni[1,5] <- 0.1
  estimadoresIni[1,6] <- 0.4
  
  estimadoresIni[2,1] <- 5
  estimadoresIni[2,2] <- 5
  estimadoresIni[2,3] <- 2
  estimadoresIni[2,4] <- 2.5
  estimadoresIni[2,5] <- 0.1
  estimadoresIni[2,6] <- 0.2
  
  return(estimadoresIni)
}
paramEjemplo2 <- function(){
  #NPIXX <<- 45
  #NPIXY <<- 45
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
  
  return(estimadoresIni)
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


#############
source("C:\\Users\\Usuario\\Desktop\\PROJECT-simulaMicrog\\classSintethicImage.R")
#initParams <- paramEjemplo1()
initParams <- paramEjemplo2()

o <- sintetImg(1000, initParams)
o <- generateSample.sintetImg(o)

o <- scaleSample.sintetImg(o,20,20)
plotSample2D.sintetImg(o)


#showAttr.sintetImg(o)
#plotSample2D.sintetImg(o)


#class(o)
#attributes(o)
#o$nC
#o$pts
#plot(o$pts[,1],o$pts[,2])


############pruebas shinyyyyyyyyyyy
library(shiny)
runApp("C:\\Users\\Usuario\\Desktop\\PROJECT-simulaMicrog")

