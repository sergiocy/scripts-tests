#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main(int argc, char *argv[]){

  int n_proc, id_proc;
  int contador=0;
  MPI_Status estado;
  
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &n_proc);
  MPI_Comm_rank(MPI_COMM_WORLD, &id_proc);
  
  if(id_proc==0){
    MPI_Send(&id_proc, 1, MPI_INT, id_proc+1, 0, MPI_COMM_WORLD);
  }
  else{
    MPI_Recv(&contador, 1, MPI_INT, id_proc-1, 0, MPI_COMM_WORLD, &estado);

    printf("\n soy el proceso %d y recibo del %d \n", id_proc, id_proc-1);
    contador++;
 
    if(id_proc<n_proc-1){
      MPI_Send(&contador, 1, MPI_INT, id_proc+1, 0, MPI_COMM_WORLD);
    }  
  }

  MPI_Finalize();

  return 0;
}
