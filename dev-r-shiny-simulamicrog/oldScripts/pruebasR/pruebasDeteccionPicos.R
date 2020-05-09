##pruebas de deteccion de picos
library(raster)
library(pracma)

####################################
#cargamos la matriz en la variable m
m<-read.table("C:\\Users\\Usuario\\Desktop\\TFM\\MiTrabajoV1\\ImagenReal\\datosImgDM_OUT.txt")
#le restamos el mínimo de m a todos los elementos
m<-m-min(m)#(max(m)-min(m))/min(m)
#y la ponemos como variable tipo matriz (por defecto es data.frame)
m<-as.matrix(m)

#tomamos una fila de m
mFila <- m[7,]
#y la ploteamos
x <- seq(1:length(mFila))
#ploteamos la gráfica del perfil de superficie
plot(x,mFila, xlab="pixeles x", ylab="brillo")

#cogemos la zona que comprende cada pico
mFilaPico1 <- mFila[1:16]
mFilaPico2 <- mFila[17:length(mFila)]
#y sumamos sus elementos (total de eventos detectados)
sumaFilaPico1 <- sum(mFilaPico1)
sumaFilaPico2 <- sum(mFilaPico2)
#calculamos un vector con elementos proporcionales, pero de suma aproximadamente 50
#puesto que el test de S-W se aplica a muestras pequeñas (incluso menores)
mFila50Pico1 <- round((50/sumaFilaPico1)*mFilaPico1)#sum(mFila50Pico1)
mFila50Pico2 <- round((50/sumaFilaPico2)*mFilaPico2)#sum(mFila50Pico2)

#ahora generaremos un vector (para cada pico) que tenga cada valor que puede tomar
#la variable aleatoria (pixeles x) tantas veces como indique la frecuencia asociada a dicho valor
#Este vector contendrá lo que serían los resultados de cada observación.
valoresPico1 <- integer(0)
for(i in 1:length(mFila50Pico1)){
  n <- mFila50Pico1[i]
  valoresPico1 <- c(valoresPico1, rep(i,times=n))
}#length(valoresPico1)
valoresPico2 <- integer(0)
for(i in 1:length(mFila50Pico2)){
  n <- mFila50Pico2[i]
  valoresPico2 <- c(valoresPico2, rep(i,times=n))
}#length(valoresPico2)

#aplicamos el test de S-W a estos vectores
#...en nuestro caso, al primer pico...
shapiro.test(valoresPico1)
#...y al segundo
shapiro.test(valoresPico2)
#############################


findpeaks(mFila)
diff(diff(mFila))
#peaks <- argmax(x, mFila, w=5, span=0.2)
prueba <- c(0,2,5,7,4,1)
plot(c(1,2,3,4,5,6),prueba)
which(diff(diff(prueba))<0)
#########

matriz <- raster(m)
f <- function(x) max(x, na.rm=TRUE)
w <- matrix(1/9,nrow=3,ncol=3)
localmax <- focal(matriz, w, fun = f, pad=TRUE, padValue=NA)

r2 <- matriz==localmax

## Get x-y coordinates of those cells that are local maxima
maxXY <- xyFromCell(r2, Which(r2==max(localmax), cells=TRUE))
head(maxXY)
