#include <stdio.h>
#include <stdlib.h>
#include <math.h>
//#include "generadorAleatorios.cpp"

#define CUBO_X 1
#define CUBO_Y 1
#define CUBO_Z 1


#define N_PTOS 5000

//extern void generadorAleatorios(int);
void generaPto(double *p);

main(){

    int n=0, j=0;
    double ptos[N_PTOS][3];
    double *punt_ptos=&ptos[0][0];

    double pto[3];
    //double *punt_p=&pto[0];
    //double coord_x=0., coord_y=0., coord_z=0.;
    //int cuenta_cubo=0;
    int cuenta_esfera=0;
    double R=0.5;

    for(n=0; n<N_PTOS; n++){
        generaPto(&pto[0]);

        if(sqrt(pow((*(&pto[0]))-0.5,2)+pow((*(&pto[0]+1))-0.5,2)+pow((*(&pto[0]+2))-0.5,2))<=R){
            cuenta_esfera++;
        }

        for(j=0; j<3; j++){
            *(punt_ptos+n*3+j)=*(&pto[0]+j);
            printf("coord %d: %lf ; ", j, *(punt_ptos+n*3+j));
        }
        printf("\n");
    }
    //generadorAleatorios(n);
    printf("\n ptos dentro: %d", cuenta_esfera);
    //printf("\n a veeerrrr: %lf", pow(R,(double)(-3)));
    printf("\n ESTIMACION DEL VOLUMEN: %lf \n", ((double)cuenta_esfera)/((double)N_PTOS));
    printf("\n ESTIMACION DE PI: %lf \n", (((double)cuenta_esfera)/((double)N_PTOS))*(3./4.)*(pow(R,(double)(-3))) );
}

void generaPto(double *p){
    *(p)=rand()/((double)RAND_MAX);
    *(p+1)=rand()/((double)RAND_MAX);
    *(p+2)=rand()/((double)RAND_MAX);

    printf("x: %lf ; y: %lf ; z: %lf \n", *p, *(p+1), *(p+2));
}
