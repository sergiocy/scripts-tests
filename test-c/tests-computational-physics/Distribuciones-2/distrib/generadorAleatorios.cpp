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
    }
    ind_ran=ig1=ig2=ig3=0;
}

float Random(void){
    float r;
    ig1=ind_ran-24;
    ig2=ind_ran-55;
    ig3=ind_ran-61;

    irr[ind_ran]=irr[ig1]+irr[ig2];
    ir1=(irr[ind_ran]^irr[ig3]);
    ind_ran++;

    r=ir1*NormRANu;

    printf("\n numero random es: %f \n", r);
}

void generadorAleatorios(void){
    printf("hola funcion");
    ini_ran(123456789);
    Random();
}

