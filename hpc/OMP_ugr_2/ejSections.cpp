#include <omp.h>
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>
 
//#define SECUENCIAL //...tiempo de ejecucion ~6.000892 segs.
#define PARALELO_OMP

//using namespace std;
 
 
void tarea_uno(){
    sleep(2);
}
 
void tarea_dos(){
    sleep(4);
}

void tarea_tres(){
    sleep(2);
}
 
main (){
 
    double timeIni, timeFin;
 
    timeIni = omp_get_wtime();
    

    #ifdef SECUENCIAL
    printf("\n ejecutando tarea 1");
    tarea_uno();
    printf("\n ejecutando tarea 2");
    tarea_dos();
    #endif


    #ifdef PARALELO_OMP
     int nth;
     omp_set_num_threads(3);

    #pragma omp parallel private(nth)
    {
      
      nth=omp_get_thread_num();
      
      #pragma omp sections nowait
      {

	#pragma omp section
	{
	  printf("\n ejecutando tarea 1... hilo %d", nth);
	  tarea_uno(); 
	}

	#pragma omp section
	{
	  printf("\n ejecutando tarea 2... hilo %d", nth);
	  tarea_dos();
	}

	//	#pragma omp section
	//{
	//  printf("\n ejecutando tarea 3... hilo %d", nth);
	//  tarea_tres();
	//}
      }//...fin secciones...
    
      printf("\n el hilo %d sale del bloque sections en el instante %f", nth, omp_get_wtime()-timeIni);
    }//...fin zona paralela

    #endif
 

    timeFin = omp_get_wtime();
    
    printf("\n tiempo tardado %f segundos \n \n", timeFin-timeIni);
 
}
