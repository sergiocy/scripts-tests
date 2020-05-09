
####
#### SCRIPT WITH GENERIC FUNCTIONS
source("./scr-generic-functions.R")
source("./scr1.R")
source("./launcher-script/scr2.R")

library("data.table")

####
#### WE DEFINE ARGUMENTS FOR SCRIPTS
#args <- commandArgs(TRUE)
commandArgs <- function(...){
    
    S3_folder_trainCluster <- "Cluster_07"
    S3_folder_classCluster <- "Cluster_07"
    S3_dir_train_cluster <- paste0("path_train_cluster", S3_folder_trainCluster)
    S3_dir_class_cluster <- paste0("path_class_cluster", S3_folder_classCluster)
    
    S3_paths <- list(S3_dir_train_cluster = S3_dir_train_cluster,
                     S3_dir_class_cluster = S3_dir_class_cluster)
    
    
    
    #df1 <- data.frame(x=c(1,2), y=c(1,2)) 
    
    #return(df1)
    return(S3_paths)
} 


print(scr1_launcher())


print_some("imprimo algo")



##############
#### OTRA FORMA
#arg1 <- 1
#arg2 <- 2
#system( paste("Rscript C:/projects-sc/proj-revenue-anomaly-detection/scripts/tests-R/launcher-script/scr2.R", arg1, arg2, df1) )

