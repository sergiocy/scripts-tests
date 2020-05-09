
#########
# S3-CLASS TO  GENERATE SINTETHIC IMAGES BASED ON GAUSSIAN MIXTURE
# comenzado: 29/05/2016
#########
library(MASS)#para funcion mvrnorm

#############################################
##### CREATE AN OBJECT OF CLASS "sintetImg" #####
###...we must introduce params in this order: c(mx,my,sx,sy,rho,weight)...
sintetImg <- function(nPoints, params){
  
  if(is.matrix(params)==TRUE || is.data.frame(params)==TRUE){
    ###...we normalize weights...
    params[,6] <- params[,6]/(sum(params[,6]))
    
    myAttr <- list( nPts = nPoints, 
                    nComps = nrow(params), 
                    p = as.data.frame(params), 
                    pts = c(),
                    NPIXX = 0,
                    NPIXY = 0)
    
    
    class(myAttr) <- "sintetImg"
    #attr(myAttr, "class") <- "sintetImg"
    
    invisible(myAttr)
    #return(myAttr)
  }
    
  else{
    warning("problems with parameters type: it must be MATRIX or DATA.FRAME")
  }  
   
  
  ###...podemos englobar atributos en un ENVIRONMENT para una mejor manipulacion como objeto...
}


###############################
##### SHOW OBJECT ATRIBUTES #####
showAttr.sintetImg <- function(object){
  
  if( length(object$pts)==0 ){
    cat("\n ptos = ",object$pts, "(...it is empty yet...)")
  }
  else{
    cat("\n ptos = \n")
    print(object$pts)
  }
  
  cat("\n nPts = ",object$nPts,"\n nComps = ",object$nComps,"\n p = \n")
  print(object$p)
  cat("\n NPIXX = ",object$NPIXX," NPIXY = ",object$NPIXY,"\n")
  
}


#############################################
##### IT IS GENERATED THE SAMPLE OF POINTS #####
generateSample.sintetImg <- function(object){
 
  G <- object$nComps
  n <- object$nPts
  params <- object$p
  
  ###...we generate an amount of random numbers (between 0 and 1) equal to object$nPts with
  # ponderate probability in according to weights...
  
  #randNumByComponent <- cut(runif(object$nPts), object&nComps)
  randNumByComponent <- sample(1:G, n, replace=T, prob=params[,6])
  
  
  
  ###...we define variables...
  mu <- matrix(nrow=G,ncol=2)
  sigmaArray <- array(dim=c(2,2,G))
  for(i in 1:G){
    mu[i,] <- c(params[i,1], params[i,2])
    sigmaArray[,,i] <- matrix( c(params[i,3]^2,
                                params[i,5]*params[i,4]*params[i,3],
                                params[i,5]*params[i,4]*params[i,3],
                                params[i,4]^2), 2, byrow=T ) 
  }
  
  
  coord <- c()
  cont <- 1
  while(cont<=length(randNumByComponent)){
    coord <- rbind( coord, mvrnorm(n = 1, mu[randNumByComponent[cont],], sigmaArray[,,randNumByComponent[cont]]) )
    cont <- cont+1
  }
  
  object$pts <- coord
  return(object)
}


############################################
### WE SCALE SAMPLE IN rangex AND rangey ###
scaleSample.sintetImg <- function(object, newRangeX, newRangeY){
  object$NPIXX <- newRangeX
  object$NPIXY <- newRangeY
  
  pointsSample <- object$pts
  
  #...old ranges... we define a few larger ranges to get all points inside the range...
  oldRangeX <- c(min(pointsSample[,1])-0.1, max(pointsSample[,1])+0.1)
  oldRangeY <- c(min(pointsSample[,2])-0.1, max(pointsSample[,2])+0.1)
  
  #...we must scale coordinates of sample points
  pointsSample[,1] <- (pointsSample[,1]-oldRangeX[1])*(newRangeX/(oldRangeX[2]-oldRangeX[1]))
  pointsSample[,2] <- (pointsSample[,2]-oldRangeY[1])*(newRangeY/(oldRangeY[2]-oldRangeY[1]))
  
  #...we must scale params (means and variances)
  #...means X...
  object$p[1] <- (object$p[1]-oldRangeX[1])*(newRangeX/(oldRangeX[2]-oldRangeX[1]))
  #...means Y...
  object$p[2] <- (object$p[2]-oldRangeY[1])*(newRangeY/(oldRangeY[2]-oldRangeY[1]))
  #...deviation X...
  object$p[3] <- object$p[3]*(newRangeX/(oldRangeX[2]-oldRangeX[1]))
  #...deviation Y...
  object$p[4] <- object$p[4]*(newRangeY/(oldRangeY[2]-oldRangeY[1]))
  
  
  #...we asign the scaled sample
  object$pts <- pointsSample 
  return(object) 
  #attr(object,"pts") <- c()
}


#############################################
### PLOT THE POINTS SAMPLE ################
### ...rangex and rangey must be integer numbers to represent number of rows and columns of pixels
plotSample2D.sintetImg <- function(object){
  #we scale the sample coordinates in rangex and rangey
  NPIXX <- object$NPIXX
  NPIXY <- object$NPIXY
  
  par(tck=1
      #, lab=c(NPIXX,NPIXY,1), yaxp=c(0,NPIXY,1), xaxp=c(0,NPIXX,1)
     )
  plot(object$pts, pch='.', xlab="pixeles x", ylab="pixeles y"
       , xlim=c(0,NPIXX), ylim=c(0,NPIXY)
       
       )
  
  
}


##### discretizar muestra



