#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <unistd.h>

//#define SECUENCIAL
#define PARALELO


void imprimeVector(int tam, int *v){
  int i=0;
  for(i=0; i<tam; i++){
    printf("\n %d", *(v+i));
  }
  printf("\n");
}


main(){

  int tam=0;
  double t_start=0, t_end=0;
  
  printf("\n introduce el tamanio del vector: ");
  scanf("%d", &tam);


  int vec[tam];
  int iterador=0;

  t_start=omp_get_wtime();


  #ifdef SECUENCIAL
  for(iterador=0; iterador<tam; iterador++){
      vec[iterador]=iterador+1;
      printf("\n %d", vec[iterador]);
  }
  printf("\n");
  //imprimeVector(tam, &vec[0]);
  //printf("\n vector tamanio %d", vec[tam]+1);
  #endif


  #ifdef PARALELO
  #pragma omp parallel 
  {
    #pragma omp single
    printf("%d", omp_get_num_threads());

      #pragma omp for 
      for(iterador=0; iterador<tam; iterador++){
          vec[iterador]=iterador+1;
          printf("\n %d", vec[iterador]);
      }
  }
  //imprimeVector(tam, &vec[0]);
  #endif


  t_end=omp_get_wtime();
  printf("\n ...el tiempo de ejecucion ha sido %f \n", t_end-t_start);
}
