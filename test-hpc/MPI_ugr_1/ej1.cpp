#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
//#include <iostream>
//using namespace std;
 
int main(int argc, char *argv[])
{
    int id_proc, n_proc;
 
    MPI_Init(&argc, &argv); 
    MPI_Comm_size(MPI_COMM_WORLD, &n_proc);
    MPI_Comm_rank(MPI_COMM_WORLD, &id_proc); 
    
    printf("\n Hola mundo desde el proceso %d de %d \n", id_proc, n_proc);
    // cout<<"¡Hola Mundo desde el proceso "<<id_proc<<" de "<<n_proc<<" que somos!"<<endl;
 
    MPI_Finalize();
    return 0;
}
