
############
#### BASICS
####

####
#### ...define some variables/objects...
#### ...we can see an environment as a objects collection...
a <- 5
b <- 'algo'

#### ...we can see the envoronment of objects defined...
ls()
environment()
.GlobalEnv

#### ...the variable x in the function is not in global environment...
#### ...each function generate a local environment with its associated objects (variables in that cases)
f <- function(x){
                    x <- 0
                    print(x)
                    print(environment())
                    ls()
                    
                    f2 <- function(y=2){
                        print(y)
                        print(environment())
                        ls()
                    }
                    f2()
                }
f(3)




############
#### A FEW MORE
####

#### create env and variables scope...
a <- 'a-in-env-global'
g <- 'some'
ls()
environment()
.GlobalEnv

e <- new.env()
e$a <- 'a-in-env-e' 
e$b <- 'b-in-env-e'
e$c <- 1:3
e$d <- g
ls()


#### list environments and its content...
search()
parent.env(e)
ls(e)
ls()
ls.str()
ls.str(e)

#### ...we can access to objects in environment...
e$a
e[['a']]
get( 'a', envir = e)
#### ...and another operations in variables...
rm( 'b', envir = e)
ls(e)

exists("c", envir = e)

#### ...compare environments...
identical(.GlobalEnv, environment())


#### ...get variable environment...
library(pryr)
where('d')




attach(e)
environment()
ls()

























