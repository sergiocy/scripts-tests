#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>
#include <math.h>

//#include <generadorAleatorios.cpp>
extern void generadorAleatorios();

//DEFINES para el tipo de distribucion a representar
//#define UNIFORME

//...ojo al definir media porque debe de quedar próxima a [EXTREMO_INF,EXTREMO_SUP]
#define NORMAL
#define MEDIA 1
#define SIGMA 0.2

#define GRAFICA

//...definimos el numero pi...
#define PI 3.1416
//...definimos parametros del histograma
#define N_SECUENCIA 100
#define TAMANIO_INTERVALO 0.1
#define EXTREMO_SUP 2
#define EXTREMO_INF 0

//...y los extremos de la uniforme
const float lim_inf=EXTREMO_INF;
//const float random_max=RAND_MAX;
const float lim_sup=EXTREMO_SUP*(RAND_MAX/RAND_MAX);

FILE *archivo_secuencia;


////////////////////////////////////////////////////
//CLASE para generar frecuencias de aparición/histograma
class Histograma
{
    //atributos de la clase
    private:
        float tam_intervalo=0.;
        int n_intervalos=1;
        int *frecuencias=NULL;
        float *secuencia_numeros=NULL;
        int tam_secuencia=0.;
        FILE *archivo_frecuencias;

    public:
        //CONSTRUCTOR
        Histograma(float inter, float lim_s, float lim_i, float *sec, int tam_sec){
            tam_intervalo=inter;
            float n_intervalo_aux=((lim_s-lim_i)/inter);
            n_intervalos=(int)(n_intervalo_aux);

            //dimensionamos e inicializamos a 0 el vector de frecuencias
            frecuencias=(int*)malloc(sizeof(int)*n_intervalos);
            for(int i=0; i<n_intervalos; i++){
                frecuencias[i]=0;
            }

            //dimensionamos e inicializamos el vector que contiene la secuencia
            tam_secuencia=tam_sec;
            secuencia_numeros=(float*)malloc(sizeof(float)*tam_secuencia);
            for(int j=0; j<tam_secuencia; j++){
                secuencia_numeros[j]=*(sec+j);
            }

            //calculamos vector de frecuencias...
            calculaFrecuencias(lim_s, lim_i);
        }

        //METODOS getters y setters
        float getIntervalo(){return tam_intervalo;}
        void setIntervalo(float inter){tam_intervalo=inter;}

        //METODOS
        void calculaFrecuencias(float lim_s, float lim_i){
            printf("\n ...calcularemos las frecuencias de aparición... %d , %f \n", n_intervalos, secuencia_numeros[1]);
            int i=0, n=0;
            while(i<n_intervalos){
                for(n=0; n<tam_secuencia; n++){
                    if((*(secuencia_numeros+n)>=(lim_i+(i*tam_intervalo))) && (*(secuencia_numeros+n)<(lim_i+((i+1)*tam_intervalo)))){
                        frecuencias[i]=frecuencias[i]+1;
                    }
                }
                printf("\n frecuencias intervalo %d: %d", i, frecuencias[i]);
                i++;
            }
        }

        void escribeFrecuencias(float lim_i, float lim_s){
            int contador=0;

            archivo_frecuencias=fopen("frecuencias.dat", "w+");
            for(contador=0; contador<n_intervalos; contador++)
            {
                printf("\n contador: %d ; %d", contador, *(frecuencias+contador));
                fprintf(archivo_secuencia, "%f %d \n", (lim_i+(contador*tam_intervalo)+(tam_intervalo/2)), *(frecuencias+contador));
            }
            fclose(archivo_frecuencias);
        }

        void graficaHistograma(){
            printf("\n ...aquí habrá que graficar el histograma... \n");
            //system("gnuplot load'C:/Users/Usuario/Desktop/HPC/FISICA_COMPUTACIONAL/Ch4-Distribuciones/distrib/plotearGNU.txt'");
            system("C:/Users/Usuario/Desktop/HPC/FISICA_COMPUTACIONAL/Ch5-Distribuciones/distrib/archivo.cmd");
        }
};



//FUNCION para generar secuencia de números siguiendo una uniforme
void generaSecUniforme(float *punt_sec)
{
    int contador=0;
    for(contador=0; contador<N_SECUENCIA; contador++)
    {
        *(punt_sec+contador)=lim_inf+((lim_sup-lim_inf)*(rand()/((float)RAND_MAX)));
        printf("\n contador: %d ; %f ; %p", contador, *(punt_sec+contador), &punt_sec[contador]);
    }
}

//FUNCION para generar secuencia de numeros siguiendo una normal
void generaSecNormal(float *punt_sec)
{
    int contador=0;
    float distr_normal=0;
    float distr_normal_max=(1/(SIGMA*(sqrt(2*PI))));
    float y=0, x=0;

    while(contador<N_SECUENCIA){
        x=lim_inf+((lim_sup-lim_inf)*(rand()/((float)RAND_MAX)));
        y=((distr_normal_max)*(rand()/((float)RAND_MAX)));
        distr_normal=(distr_normal_max)*(exp(-pow((x-MEDIA),2)/(2*SIGMA*SIGMA)));

        if(y<distr_normal){
           *(punt_sec+contador)=x;
           contador++;
        }
    }
}

//FUNCION para escribir la secuencia generada
void escribeSecuencia(float *punt_sec)
{
    int contador=0;

    archivo_secuencia=fopen("secuencia.txt", "w+");
    for(contador=0; contador<N_SECUENCIA; contador++)
    {
        printf("\n contador: %d ; %f", contador, punt_sec[contador]);
        fprintf(archivo_secuencia, "%d %f \n", contador, punt_sec[contador]);
    }
    fclose(archivo_secuencia);
}

//////////////////////////////////////
main()
{
    float secuencia[N_SECUENCIA];

    #ifdef UNIFORME
    generaSecUniforme(&secuencia[0]);
    #endif

    #ifdef NORMAL
    //...generamos secuencia normal (metodo de las alturas)
    generaSecNormal(&secuencia[0]);
    #endif


    escribeSecuencia(&secuencia[0]);


    #ifdef GRAFICA
    //generamos objeto de clase ``Histograma''
    Histograma hist1(TAMANIO_INTERVALO, lim_sup, lim_inf, &secuencia[0], N_SECUENCIA);
    hist1.escribeFrecuencias(lim_inf, lim_sup);
    hist1.graficaHistograma();
    #endif


    //generadorAleatorios();
}
