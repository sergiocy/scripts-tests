


source("C:/../launcher-script/scr1-2.R")

user <- "usuario"

args <- "one"




f_launcher <- function(){
    f1()
}




if(args == "one"){
    
    print("option one")
    
    df1 <- data.frame(x=c(1,2), y=c(1,2))
    
    f_launcher()

}else if(args == "two"){
    
    print("option two")
    
    
}else{
    print("another option")
}