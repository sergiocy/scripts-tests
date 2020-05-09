
library(data.table)

#### load mtcars dataset
dt <- data.table(mtcars)[, .(cyl, gear)]

#### unique pairs
dt[ , unique(gear), by=cyl] # unique( dt[ , , ])

#### add column of lists
dt[,gearsL:=.(list(unique(gear))), by=cyl]
dt[ , gears1 := lapply(gearsL, function(x) x[2]) , ]


#### using {} in second position
dt <- data.table(mtcars)

dt[ , {tmp1 = mean(mpg); 
       tmp2 = mean(abs(mpg-tmp1)); 
       tmp3 = round(tmp2, 2);
       list(tmp2 = tmp2, tmp3 = tmp3)} 
    , by = .(cyl)]


#### ...de esta otra 
dt <- data.table(mtcars)[,.(cyl, mpg)]
dt[,tmp1:=mean(mpg), by=cyl][,tmp2:=mean(abs(mpg-tmp1)), by=cyl][,tmp1:=NULL]
head(dt)


#### ...to access and modify columns with c(1L, 2L, 4L)...
dt <- data.table(mtcars)[,1:5, with=F]
for (j in c(1L,2L,4L)) set(dt, j=j, value=-dt[[j]]) # integers using 'L' passed for efficiency
for (j in c(3L,5L)) set(dt, j=j, value=paste0(dt[[j]],'!!'))
head(dt)


#### desfasar/desplazar vectores con shift
dt <- data.table(mtcars)[1:5,.(mpg, cyl)]
dt[,mpg_lag1:=shift(mpg, 2)]
dt[,mpg_forward1:=shift(mpg, 1, type='lead')]
head(dt)

#### shift and by
#### ...we create some data...
n <- 30
dt <- data.table(
    date=rep(seq(as.Date('2010-01-01'), as.Date('2015-01-01'), by='year'), n/6), 
    ind=rpois(n, 5),
    entity=sort(rep(letters[1:5], n/5))
)
# ...we ordering...
setkey(dt, entity, date) # important for ordering
dt[,indpct_fast:=(ind/shift(ind, 1))-1, by=entity]

lagpad <- function(x, k) c(rep(NA, k), x)[1:length(x)] 
dt[,indpct_slow:=(ind/lagpad(ind, 1))-1, by=entity]

head(dt, 10)


#### ...using := to create several columns...
dt <- data.table(mtcars)[,.(mpg, cyl)]
dt[,`:=`(avg=mean(mpg), med=median(mpg), min=min(mpg)), by=cyl]
head(dt)


#### assign name to columns...
dt <- data.table(mtcars)[, .(cyl, mpg)]
thing2 <- 'mpgx2'
dt[,(thing2):=mpg*2]
head(dt)



#############################
####
#### 2. USING BY
library(data.table)

#### load mtcars dataset
dt1 <- data.table(mtcars)[, .(cyl, gear, mpg)]
dt1[ , mpg_biased_mean := mean(mpg), by = cyl]

#setorder(dt, -cyl)
head(dt1)


####
####
# dt[!gear %in% unique(dt$gear)[.GRP], mean(mpg), by=cyl]
# dt[!gear %in% unique(dt$gear)[.GRP], , ]

# dt[ , mean(mpg), by=cyl]
dt <- dt1[ , .(gear, mpg, mpg_biased_mean, mean(mpg), grp = .GRP), by=cyl]
dt <- dt1[ gear == grp , dt1[ , .(gear, mpg, mpg_biased_mean, mean(mpg), grp := .GRP), by=cyl], ]

#dt[ !gear %in% unique(dt$gear)[.GRP], mean(mpg), by=cyl]
#setorder(dt, -cyl, -gear)
#head(dt)

dt[!gear %in% unique(dt$gear)[.GRP], mean(mpg), by=cyl]
dt[ , dt[ !gear %in% unique(dt$gear)[.GRP], mean(mpg), by=cyl], by=gear]
dt[gear!=4 & cyl==6, mean(mpg)]


#### ...using .GRP...
dt <- dt1
head(dt)

dt[ , .(gear, .GRP), by=cyl]
# dt[ , .(gear, unique(dt$gear)[.GRP], .GRP), by=cyl]
dt[ , .(.GRP, unique(dt$gear)[.GRP]), by=cyl]




####
#### ...setting key...
dt <- dt1

setkey(dt, gear)


####
#### ...using {} and .SD
dt <- dt1
dt[ , .SD[ , mean(mpg), by=cyl], by = gear]
# same as than dt[, mean(mpg), by=.(cyl, gear)]


####
#### ...nested datatables...
dt <- dt1
# head(dt)
dt[ ,{ vbar = sum(mpg);
       n = .N;
       .(vbar=vbar, n=n)} , by = cyl]
dt[ ,{ vbar = sum(mpg);
       n = .N;
       .SD[, .(vbar=vbar, n=n, count_gear = .N), by=gear] } , by = cyl]
# dt[, .(count_gear = .N), by=.(cyl, gear)]



#######################################################
##########################################################
#### JOINING WITH DATATABLE
##############################################
library(data.table)

#### toy sets...
emp <- data.table( employee = c(1,2,3,4,5,6),
                   employeename = c('Alice', 'Bob', 'Carla', 'Daniel', 'Evelyn', 'Ferdinand'),
                   departament = c(11, 11, 12, 12, 13, 21),
                   salary = c(800, 600, 900, 1000, 800, 700))
dep <- data.table( departament = c(11,12,13,14),
                   departamentname = c('production', 'sales', 'marketing', 'research'),
                   manager = c(1,4,5,'NA') )

####
#### ...setkeys...
setkey(emp, departament)
setkey(dep, departament)

#### ...perform an inner-join by keys...
result <- emp[dep, nomatch=0]

#### ...left-join...
dep[emp]
#### ...right-join...
emp[dep]

####
#### ...selecting columns...
emp_cols <- colnames(emp)
dep_cols <- colnames(dep)
setdiff(emp_cols, dep_cols)
new_cols <- c( setdiff(emp_cols, dep_cols), dep_cols )

setcolorder(result, new_cols)

#### ...defining order directly in the join...
result2 <- emp[dep][ , new_cols, with=FALSE]


















