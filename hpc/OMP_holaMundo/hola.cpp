#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

main(){
    int nthreads, tid;

    #pragma omp parallel private(tid) /*num_threads(20)*/
    {
        tid=omp_get_thread_num();
        nthreads=omp_get_num_threads();
        printf("\n hola desde el thread %d de un total de %d threads \n", tid, nthreads);
    }
}
