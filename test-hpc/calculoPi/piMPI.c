#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>



int main(int argc, char *argv[]){
        int n=10;
	int rank, size;
	double PI25DT = 3.141592653589793238462643;
	double mypi;
	double h;
	double sum;
	double pi;
	int i=0;
	
	//printf("\n hilo padre ... pto. de control 0 ...aqui si llego...\n");
	//printf("introduce la precision del calculo (n > 0): ");
	//scanf("%d", &n);
	//printf(" numero de divisiones: %d", n);

	

	MPI_Init(&argc, &argv); // Inicializamos los procesos
	MPI_Comm_size(MPI_COMM_WORLD, &size); // Obtenemos el numero total de procesos
	MPI_Comm_rank(MPI_COMM_WORLD, &rank); // Obtenemos el valor de nuestro identificador
	
	printf("\n hilo %d ... pto. de control 1 ...n vale %d...\n", rank, n);

	if(rank==0)
	{
	  //do{
	  // printf("\n hilo %d ... pto. de control 1.1 ...aqui si llego...\n", rank);
	  printf("\n introduce la precision del calculo (n > 0): ");
	  scanf("%d", &n);
	    //printf("\n numero de divisiones: %d \n", n);
	    // }while(n<=0); 
	}
	
	//printf("\n hilo %d ...llega a  pto. de control 2... n vale %d \n", rank, n);

	
	
	//MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD); 
	
	//printf("\n hilo %d ...llega a  pto. de control 3... n vale %d \n", rank, n);
	/*
	if(n<=0){
	  MPI_Finalize();
	  exit(0);
	}
	else{
	   
	    h = 1.0 / (double) n;
	    sum = 0.0;

	    for (i = 1; i <= n; i++) {
	        double x = h * ((double)i - 0.5);
	        sum += (4.0 / (1.0 + x*x));
	    }

	    pi = sum * h;
	    
	    printf("\n hilo: %d -- divisiones: %d -- suma: %f -- pi: %f -- \n", rank, n, sum, pi);
	}
	
	*/
	MPI_Finalize();
	
	

	printf("\n El valor aproximado de PI es: %f +- %f \n", pi, pi-PI25DT);
	return 0;

}//...fin del main()...
