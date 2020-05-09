


args <- commandArgs(TRUE)



scr1_f1 <- function(){
    print(args)
    print(dim(args))
    #print(class(args))
    
    dt <- data.table(dt=c(1,1,1))
    print(dt)
    
    #print(un_dir)
    return(22)
}


scr1_launcher <- function(){
    print("hello from 1")
    #print(commandArgs())
    
    num <- scr1_f1()
    return(num)
}

#scr1_launcher()

