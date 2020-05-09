
#include <stdlib.h>
#include <malloc.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>


/* ...VARIABLE GLOBAL con el nombre del fichero... */
const char name_file[] = "1_dataOriginal_copia2.txt";


/* ...funcion para obtener las dimensiones de la matriz 
   recorriendo el vector de elementos... */
void getMatrixDimension(int *d, int *v, int tam){
	//std::cout << *d << "---" << *(d+1) << std::endl;
	//std::cout << *v << "---" << *(v+1) << std::endl;
	//std::cout << tam << std::endl;
	
	for(int iter = 0; iter < tam; iter++){
		//std::cout << *(v + iter) << std::endl;
		
		if(*(v + iter) == -1){
			(*d)++;
		}	
			
	}	
	
	*(d+1) = (tam - (*d))/(*d);
	
	//std::cout << *d << "---" << *(d+1) << std::endl;
}	




int main(){
    
    /* ...VARIABLES... */
    std::fstream file_data_in;
    std::string one_line;
    
    /* ...variables para almacenar y dimensionar la matriz... */
    std::vector<int> vector_elements;
    int n_rows = 0;
    int n_cols = 0;
    
    int dims_matrix[2] = {0, 0};
    
    
    
	/* ...iteradores para recorrer strings... */
	unsigned int iter = 0, iter_debug = 0;
	
	/* ...variables para almacenar los elementos... */
	int one_number = 0;
	std::string one_str = "";
	std::string one_str_debug = "";
	 
 
    file_data_in.open(name_file, std::ios::in);
    if(file_data_in.is_open()){
		
        while(!file_data_in.eof()){ 
		      
            getline(file_data_in, one_line);
            
            if(one_line != "" && one_line != "\n"){
                //std::cout << "Frase leida: " << "%" << one_line << "%" << std::endl; 
                
                for(iter=0; iter<one_line.size(); iter++){
					if(one_line[iter] != '0' && one_line[iter] != '1' && one_line[iter] != '2' && one_line[iter] != '3' &&
					   one_line[iter] != '4' && one_line[iter] != '5' && one_line[iter] != '6' && one_line[iter] != '7' && 
					   one_line[iter] != '8' && one_line[iter] != '9'){
						
						/* ...EXCEPCION para capturar salvedades con caracteres no-numéricos... */
						try{   
							one_number = stoi(one_str);
						}
						catch(...){
							//std::cout << "...ERROR con la cadena...--" << one_str << "--" << std::endl;
							
							for(iter_debug = 0; iter_debug < one_str.size(); iter_debug++){
								if(one_line[iter] != '0' && one_line[iter] != '1' && one_line[iter] != '2' && 
								   one_line[iter] != '3' && one_line[iter] != '4' && one_line[iter] != '5' && 
								   one_line[iter] != '6' && one_line[iter] != '7' && 
								   one_line[iter] != '8' && one_line[iter] != '9'){
									
									one_str = one_str.substr(iter_debug+1, one_str.size());
								}	
								   
							}
							
							if(one_str != ""){
								one_number = stoi(one_str);
							}
							/*else{
								
								std::cout << "...CADENA VACIA..." << std::endl;
							}*/			
						}	
						
						if(one_str[0] == '0' || one_str[0] == '1' || one_str[0] == '2' || one_str[0] == '3' ||
						   one_str[0] == '4' || one_str[0] == '5' || one_str[0] == '6' || one_str[0] == '7' ||
						   one_str[0] == '8' || one_str[0] == '9'){
							   
								vector_elements.push_back(one_number);
								//std::cout << "...NUMERO INTRODUCIDO EN EL VECTOR-" << one_number << "-" << std::endl;
								one_str = ""; 
						        n_cols++;
						}	   		
						
					}
					else{
						
						one_str += one_line[iter];
		    	
					}	
    
				}
				
            } 
            
            if(n_cols > 0){
				vector_elements.push_back(-1);
				n_rows++;
            }
            
			n_cols = 0;
			  
        } 
        
        file_data_in.close();
        
        
        getMatrixDimension(&dims_matrix[0], &vector_elements[0], vector_elements.size());
         
         
    }
    else{
		 std::cout << "Fichero inexistente o faltan permisos para abrirlo" << std::endl;  
    }
 
    
    return 0;
}





	
	
	
	
	
