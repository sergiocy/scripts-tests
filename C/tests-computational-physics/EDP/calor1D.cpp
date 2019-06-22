// ECUACIÓN DE CALOR 1-D //
// Comenzado 22/10/2015 //

#include<stdio.h>
#include<stdlib.h>

//...definimos ctes y condiciones de contorno
#define K 0.1 //cte de difusion
#define T_0 5
#define T_L 30

//...parametros de la discretizacion espacial
#define L 2. //longitud de la varilla
#define N_L 10 //número de elementos discretos

//...parametros de la discretizacion temporal
#define T 10.  //tiempo de evolucion
#define N_T 100 //numero de elementos discretos

const float paso_t=T/N_T;
const float paso_l=L/N_L;

void evoluciona(float *sis_in, float *sis_out);
void escribe(float *sis_out);

FILE *f;

main(){
    //...inicializamos el sistema...
    float ptos_L[N_L+1]={0};
    ptos_L[0]=T_0;
    ptos_L[N_L]=T_L;
    
    //...definimos otro vector para el sistema que evoluciona...
    float ptos_L_evol[N_L+1]={0};
    ptos_L_evol[0]=T_0;
    ptos_L_evol[N_L]=T_L;
    
    
    //printf(" tiempo: %d \n paso temporal: %f \n paso espacial: %f \n", T, paso_t, paso_l);
    //printf(" array0: %f \n array10: %f \n tamanio: %d \n \n", ptos_L[0], ptos_L[10], sizeof(ptos_L));
    
    f=fopen("evolucion.txt", "w+");
    
    //...escribimos el estado inicial...
    escribe(&ptos_L[0]);
    
    //...y evolucionamos el sistema...
    float t=paso_t;
    do{
        evoluciona(&ptos_L[0], &ptos_L_evol[0]);
        escribe(&ptos_L[0]);
        t=t+paso_t;
    } while(t<=T);
 
    fclose(f);
    system("PAUSE");   
}


///////////////////////////////////
//...FUNCION de evolucion temporal
void evoluciona(float *sis_in, float *sis_out){
    //int contador;
    
    for(int i=1; i<N_L; i++){
        (*(sis_out+i))=(*(sis_in+i))+((paso_t*K/(paso_l*paso_l))*(*(sis_in+(i+1))+*(sis_in+(i-1))-(2*(*(sis_in+i)))));   
    }  
    
    //copiamos el nuevo vector (en t+1) en el antiguo (en t)
    for(int i=0; i<=N_L; i++){
        *(sis_in+i)=*(sis_out+i);   
    }   
}


///////////////////////////////////
//...FUNCION para escribir el vector
void escribe(float *sis_out){
    for(int i=0; i<=N_L; i++){
        printf("%.2f ", *(sis_out+i)); 
        fprintf(f, "%.2f ", *(sis_out+i));  
    } 
    printf("\n"); 
    fprintf(f, "\n");   
}
