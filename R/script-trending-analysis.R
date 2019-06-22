
# cadena_fecha1 <- "2016-12-06T05:36:34Z"
# fecha1 <- as.Date(cadena_fecha1, "%Y-%m-%d")
# Sys.Date()



# ...funcion para cargar datos del fichero...
loadData <- function(){
  datos <- read.csv("C:/Users/../dataTagsTechnology.txt", sep=";", header=FALSE)
  #...formateamos fecha...
  datos$V2 <- as.Date(datos$V2)
  #datos$V3 <- tolower(datos$V3)
  #datos <- sort(datos$V2)
  datos <<- datos[,2:3] 
  
  head(datos)
}


#funcion para extraer tags diferentes
getDistinctTags <- function(){
  tags <- datos$V3
  unique(tags)
}


# ...funcion para obtener el número total de tags cada día...
numberOfTagsPerDay <- function(){
  freqTagsPerDay <- data.frame(table(datos$V2)) 
  head(freqTagsPerDay)
  
  return(freqTagsPerDay)
}


#...filtramos tag...
filterTag <- function(tag="cloud", nTagsPerDay){
  datosTag <- datos[which(datos$V3==tag),]
  head(datosTag)
  
  freqTag <- data.frame(table(datosTag$V2))
  head(freqTag)
  
  #freqTag$relFreq <- nTagsPerDay[match(freqTag$Var1, nTagsPerDay$Var1),]
  freqTagNew <- merge(nTagsPerDay, freqTag, by.x="Var1", by.y="Var1")
  head(freqTagNew)
  
  freqTagNew <- cbind(freqTagNew, relativeFreq=freqTagNew$Freq.y/freqTagNew$Freq.x)
  head(freqTagNew)
  
  return (freqTagNew)
}


# ...seleccionamos la ventana temporal...
dataTemporalWindowSelected <- function(datTemp = fTagsDayComplete, daysInterval = 7){
  # datTemp <- fTagsDayComplete
  datTemp$Var1 <- as.Date(datTemp$Var1)
  
  library(data.table)
  datTemp <- as.data.table(datTemp)
  
  dateMin <- min(datTemp$Var1)
  dateMax <- max(datTemp$Var1)
  
  
  maxRelFreq <- c()
  minRelFreq <- c()
  meanRelFreq <- c()
  sumRelFreq <- c()
  dateIniInterval <- c()
  dateEndInterval <- c()
  
  n <- 0
  while( (dateMin+((n)*daysInterval)) <= dateMax){
  
    # newSubSet <- datTemp[Var1 %between% c(dateMin+(n*daysInterval), dateMax)] 
    newSubSet <- datTemp[(Var1>=dateMin+(n*daysInterval)) & (Var1<dateMin+((n+1)*daysInterval))] 
    maxRelFreq <- c( maxRelFreq, max(newSubSet$relativeFreq) )
    minRelFreq <- c( minRelFreq, min(newSubSet$relativeFreq) )
    meanRelFreq <- c( meanRelFreq, mean(newSubSet$relativeFreq) )
    #sumRelFreq <- c( sumRelFreq, sum(newSubSet$relativeFreq) )
    
    dateIniInterval <- c( dateIniInterval, as.character(dateMin+(n*daysInterval)) )
    dateEndInterval <- c( dateEndInterval, as.character(dateMin+((n+1)*daysInterval)) )
     
    n <- n+1
  }
  
  newTempData <- data.frame(dateIni = dateIniInterval,
                            dateEnd = dateEndInterval,
                            maxRelFreq = maxRelFreq,
                            minRelFreq = minRelFreq,
                            meanRelFreq = meanRelFreq
                            #sumRelFreq = sumRelFreq
                            )
}





# ...filtrado de los datos por dia...
filterDay <- function(day){
  return(datos[which(datos$V2==day),])  
}








################################## MAIN #####################
loadData()
distinctTags <- getDistinctTags()
fTagsDay <- numberOfTagsPerDay()
# library(data.table)
# fTagsDay <- as.data.table(fTagsDay)   2017-05-16, 2017-06-28
# fTagsDay$Var1 <- as.Date(fTagsDay$Var1)
# fTagsDay[between(Var1,2017-05-15, 2017-06-28 ),]

############ FILTER PER TAG #######
fTagsDayComplete <- filterTag(tag = "strategy", nTagsPerDay = fTagsDay)
# head(fTagsDayComplete)
# plot(fTagsDayComplete$Freq.y, xlab = "indice (indicando secuencia dias ordenados)", ylab = "frecuencia", main = "tag 'Oculus'")
# axis(side = 1, labels = fTagsDayComplete$Var1)
# barplot(fTagsDayComplete$Freq.y, main = "tag 'Oculus'", names.arg = fTagsDayComplete$Var1, ylab = "frecuencia")
fTagsTemporalWindow <- dataTemporalWindowSelected(datTemp = fTagsDayComplete, daysInterval = 7)
#...plot del tag...
plot(fTagsTemporalWindow$meanRelFreq)
hist(fTagsTemporalWindow$meanRelFreq)

############ FILTER PER DAY ########
head(fTagsDay[order(-fTagsDay$Freq),])#...para saber los dias con más tags recibidos...

tagsPerDay <- filterDay("2017-05-10")
freqTagsPerDay <- as.data.frame(sort(table(tagsPerDay$V3)))# typeof(freqTagsPerDay)
freqMedia <- mean(freqTagsPerDay$Freq[freqTagsPerDay$Freq>0], na.rm=TRUE)
plot(table(tagsPerDay$V3), ylab="frecuencia", main="tags detectados el 10/05/2017")
hist(table(tagsPerDay$V3)[table(tagsPerDay$V3)>0], xlab="indice entero asociado a cada tag detectado", main="histograma de tags detectados el 10/05/2017")

dim(freqTagsPerDay[freqTagsPerDay$Freq>freqMedia,])
#hist(as.data.frame(table(tagsPerDay$V3))$Freq)




##########################
tsData <- ts( data.frame(fTagsDayComplete$Var1, fTagsDayComplete$relativeFreq) )
head(tsData)
temporalSerie <- descompose()


