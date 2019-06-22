// // // TIRO PARABOLICO (CINEMÁTICA) // // //
//NOTA: el sentido positivo de la velocidad es ``hacia abajo''
//se genera la representación del tiro parabólico en un pdf

#include <stdio.h>
#include <stdlib.h>

//...definimos valores iniciales y constantes
#define paso_t 0.1
#define ay 10
const float pos_ini[2]={0,50};
const float vel_ini[2]={3,-10};


//...función para calcular posicion y velocidad en cada instante... 
void calcula(float *p, float *v){
    (*v)=(*v);
    (*(v+1))=(*(v+1))+(ay*paso_t);
    (*p)=(*p)+((*v)*paso_t);
    (*(p+1))=(*(p+1))-((*(v+1))*paso_t)-((ay*paso_t*paso_t)/2);
}


main()
{
    float pos_t[2]={pos_ini[0],pos_ini[1]}, vel_t[2]={vel_ini[0],vel_ini[1]};
    FILE *f;
    
    //...creamos y abrimos fichero de texto...
    f=fopen("posiciones.txt", "w+");
    
    while(pos_t[1]>=0)
    {
        fprintf(f, "%f %f \n", pos_t[0], pos_t[1]);
        printf("posicion = (%f, %f) ; velocidad = (%f, %f) \n", pos_t[0], pos_t[1], vel_t[0], vel_t[1]);
        
        calcula(&pos_t[0], &vel_t[0]);
    
    }
    fclose(f);
    
    //...lanzamos script en R para representar gráficamente posiciones en el plano x,y
    system("Rscript C:/Users/Usuario/Desktop/HPC/FISICA_COMPUTACIONAL/Ch2-EDO/prueba.R");
    system("PAUSE");
}


    
    
