#include <stdio.h>
#include <stdlib.h>

#define NormRANu (2.3283063671E-10F)

unsigned int irr[256];
unsigned int ir1;
unsigned char ind_ran, ig1, ig2, ig3;

void ini_ran(int SEMILLA){
    printf("\n funcion 2 \n");

    int INI, FACTOR, SUM, i;
    srand(SEMILLA);

    INI=SEMILLA;
    FACTOR=67397;
    SUM=7364893;

    for(i=0; i<256; i++){
        INI=(INI*FACTOR+SUM);
        irr[i]=INI;
        //printf("\n %d", INI);
    }
    ind_ran=ig1=ig2=ig3=0;
}


void ini_ran_3D(int SEMILLA){
    printf("\n funcion 2 \n");

    int INI, FACTOR, SUM, i;
    srand(SEMILLA);

    INI=SEMILLA;
    FACTOR=67397;
    SUM=7364893;

    for(i=0; i<256; i++){
        INI=(INI*FACTOR+SUM);
        irr[i]=INI;
        //printf("\n %d", INI);
    }
    ind_ran=ig1=ig2=ig3=0;
}

float Random(int N, double *ptos){
    double r;

    for(int fil=0; fil<N; fil++){
        for(int coord=0; coord<3; coord++){
            ig1=ind_ran-24;
            ig2=ind_ran-55;
            ig3=ind_ran-61;

            irr[ind_ran]=irr[ig1]+irr[ig2];
            ir1=(irr[ind_ran]^irr[ig3]);
            ind_ran++;

            r=ir1*NormRANu;
            *(ptos+(fil*N)+coord)=r;
            //ptos[fil][coord]=r;
            printf("\n %lf", r);
        }
        printf("\n pto %d random es: %lf %lf %lf\n", fil, *(ptos+(fil*N)+0), *(ptos+(fil*N)+1), *(ptos+(fil*N)+2));
    }
}

void generadorAleatorios(int N){
    printf("hola funcion");

    double ptos[N][3];

    //ini_ran(123456789);
    ini_ran_3D(123456789);
    Random(N, &ptos[0][0]);

    printf("\n FIN");
}

//main(){
//    generadorAleatorios(5);
//}
