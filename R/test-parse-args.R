

parse_args <- function(args, 
                       args_names, 
                       key_value_separation_symbol = " ",
                       key_start_symbol = "--"){
    args <- strsplit(args, key_value_separation_symbol)
    args_parsed <- c()
    
    if(length(args)%%2 == 0){
        for(arg in args_names){
            arg_name_index <- grep( arg, sapply(args, function(element_parsed) sub(paste0("^", key_start_symbol), "", element_parsed)) )
            args_parsed <- c(args_parsed, args[arg_name_index + 1])
        }
    }
    else{
        print('error en argumentos de entrada')
    }
    
    return(args_parsed)
}


args <- commandArgs(TRUE)
args_names <- c('arg1', 'arg2', 'arg3')
args_values <- parse_args(args, args_names)


print(args_names)
print( unlist(args_values) )

