#include <iostream>
#include <omp.h>

using namespace std;

int
main ()  {

int nthreads, tid;

/* FORK A TEAM OF THREADS WITH EACH THREAD HAVING A PRIVATE TID VARIABLE */
#pragma omp parallel private(tid)
{

/* OBTAIN AND PRINT THREAD ID */
tid = omp_get_thread_num();
cout << "Hello World from thread " << tid << "\n caca" << endl;

/* ONLY MASTER THREAD DOES THIS */
if (tid == 0)
{
nthreads = omp_get_num_threads();
cout << "Number of threads = " << nthreads << endl;
}

}  /* ALL THREADS JOIN MASTER THREAD AND TERMINATE */
return 0;

}
