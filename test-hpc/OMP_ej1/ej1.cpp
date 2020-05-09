#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

//#define SECUENCIAL
#define PARALELO

#define CHUNKSIZE 2
//#define N_THREADS 2
#define N 10

main(){
    int i, chunk, dim_vector;
    int nthreads, tid;

    int a[N], b[N], c[N];
    for(i=0; i<N; i++){
        a[i]=b[i]=i;
    }

    #ifdef SECUENCIAL
    for(i=0; i<N; i++){
        c[i]=a[i]+b[i];
        printf("\n thread unico (secuencial) - iteracion %d - c[%d]=%d", i, i, *(c+i));
    }
    #endif // SECUENCIAL


    #ifdef PARALELO
    dim_vector=N;
    chunk=5;
    //printf("\n numero de threads maximo: %d)", omp_get_max_threads());

    //printf("\n numero de threads en ejecucion: %d", nthreads);


        #pragma omp parallel shared(a, b, c, chunk) private(i, tid)
        {
            omp_set_num_threads(2);
            nthreads=omp_get_num_threads();

            #pragma omp for schedule(static, chunk)
            for(i=0; i<N; i++){
                tid=omp_get_thread_num();
                c[i]=a[i]+b[i];
                printf("\n thread %d de %d nthreads - iteracion %d - c[%d]=%d", tid, nthreads, i, i, c[i]);
            }
        }
    #endif // PARALELO
}
