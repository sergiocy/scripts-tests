#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>
#include <time.h>

#define tam_vector 10
//...en secuencial da 120 como resultado...
//...tam=10 -- t=0.000248 s
//...tam=1000 -- t=0.010931 s
//...tam=10000 -- t=0.076452 s
//...tam=100000 -- t=0.817263 s




int main(int argc, char *argv[]){
    clock_t t_ini, t_fin;
    double secs;	
    int vec_1[tam_vector];
    int vec_2[tam_vector];
    int iter=0;
    int rank, size;
    int producto=0;


    t_ini=clock();

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
	
	int VectorALocal[tam_vector/size];
    	int VectorBLocal[tam_vector/size];
	
        if(rank==0){
        //...inicializamos vectores...
            for(iter=0; iter<tam_vector; iter++){
                vec_1[iter]=iter;
                vec_2[iter]=tam_vector-iter-1;
                printf("\n vec_1[%d] = %d -- vec_2[%d] = %d", iter, *(vec_1+iter), iter, *(vec_2+iter));
            }
            printf("\n");
		
	    int j=0;
	    for(j=0; j<(tam_vector/size); j++){
		VectorALocal[j]=0;
		VectorBLocal[j]=0;
	    }	
	}

    int MPI_Barrier(MPI_Comm comm);	

    
    MPI_Scatter(&vec_1[0], tam_vector/size, MPI_LONG, &VectorALocal[0], tam_vector/size, MPI_LONG, 0, MPI_COMM_WORLD); 
    MPI_Scatter(&vec_2[0], tam_vector/size, MPI_LONG, &VectorBLocal[0], tam_vector/size, MPI_LONG, 0, MPI_COMM_WORLD);

/////////////////////////7
int j=0;
for(j=0; j<(tam_vector/size); j++){
	printf("\n hilo %d -- vectorA: %d", rank, VectorALocal[j]);
}
////////////////////

        //...hacemos el producto...
        int prod=0;
        for(iter=0; iter<(tam_vector/size); iter++){
            prod+=(VectorALocal[iter])*(VectorBLocal[iter]);
	    printf("\n hilo %d -- producto=%d", rank, prod);	
        }

    MPI_Reduce(&prod, &producto, 1, MPI_LONG, MPI_SUM, 0, MPI_COMM_WORLD);


	t_fin=clock();
	if(rank==0){
	    secs=(double)(t_fin-t_ini)/CLOCKS_PER_SEC; 
   	    printf("\n tiempo de ejecucion: %f \n", secs);
    	    printf("\n \n el resultado es: %d \n \n", producto);	

    	    //printf("\n \n %d \n", tam_vector/size);	
	}

    MPI_Finalize();

    return 0;
}
