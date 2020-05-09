#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

const int lim_sup=1;
const int lim_inf=0;
const float tam_interv=0.005;
const int n_interv=1/tam_interv;

double func(double x);


main(){
    printf("\n n intervalo: %d \n tam intervalo: %f \n", n_interv, tam_interv);
    int cont=0;
    double resultado=0, pto_x=0;

    #pragma omp parallel for reduction(+:resultado) private(cont)
    for(cont=0; cont<n_interv; cont++){
        resultado=resultado+(tam_interv*(func(cont*tam_interv+(tam_interv/2))));
    }

    printf("\n Esta aproximacion de PI da como resultado: %lf \n", resultado);
}


double func(double x){
    double y=0;
    y=4/(1+(x*x));
    return (y);
}
