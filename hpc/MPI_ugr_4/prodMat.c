#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]){
  
  int size, rank, dim=0;
  MPI_Status estado;

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  //printf("\n hilo %d ------ \n", rank);
  //printf("\n estado antes de la barrera: %d \n", estado);
  //int MPI_Barrier(MPI_Comm comm);
  //printf("\n estado despues de la barrera: %d \n", estado);

  if(rank==0){
    int aux;
    printf("\n dame la dimension: ");
    fflush(stdout);
    //fflush(stdin);
    scanf("%d", &dim);
    //fflush(stdin);
   
    printf("\n hilo %d -- dimension %d \n", rank, dim);
    //fflush(stdout);
    MPI_Bcast(&dim, 1, MPI_INT, 0, MPI_COMM_WORLD);
   
  }
  else{
    MPI_Bcast(&dim, 1, MPI_INT, 0, MPI_COMM_WORLD);
    //int MPI_Barrier(MPI_Comm comm);	
    if(dim>0){
      printf("\n proceso %d \n", rank);
    }
  }


  MPI_Finalize();
  return 0;
}
