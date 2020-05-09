#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define N 100
#define N_THREADS 4
int tid, nthr;
int i, A[N], B[N];


main(){
    for (i=0; i<N; i++){
        A[i]=i;
        B[i]=i;
    }

    omp_set_num_threads(N_THREADS);

    int j=0;
    //#pragma omp parallel private(tid) shared(j)
    #pragma omp parallel for private(tid) shared(j) schedule(static, N/N_THREADS)
    //for(int k=0; k<N_THREADS; k++)
    //{
        //tid=omp_get_thread_num();
        for(j=0; j<N; j++){
            tid=omp_get_thread_num();
            printf("\n hilo %d ejecuta iteracion %d", tid, j);
        }
    //}
}

