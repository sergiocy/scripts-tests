//#include <iostream>
//#include <vector>

class Sistema{

    private:
        int n_lado, n_nodos;
        signed int *spin_nodos;

        int energia=0;
        float magnetizacion=0;

        FILE *spines_sistema;
        FILE *lado_red;

    public:
        Sistema(int n_l){

            n_lado=n_l;
            n_nodos=n_l*n_l;
            spin_nodos=(int*)malloc(sizeof(int)*n_nodos);

            printf("numero de nodos: %d ; sizeof: %d", n_nodos, sizeof(spin_nodos));

        }


        //...inicializa con números rand()...
        void inicializa(){
            int iterador=0;
            int valor=0;
            for(iterador=0; iterador<n_nodos; iterador++){
                valor=rand();
                if(valor>(((double)RAND_MAX)/(double)2)){
                    *(spin_nodos+iterador)=1;
                }
                else{
                    *(spin_nodos+iterador)=-1;
                }

                //printf("\n %d -- %d", spin_nodos[iterador], valor);
            }
        }


        //...escribimos spines en archivo...
        //...con columnas (contador, posicion x del nodo, posicion y del nodo, spin del nodo)
        void escribeVectorSistema(){
            int iterador=0;
            int fila=0, columna=0;
            float x=0,y=0;
            spines_sistema=fopen("spines_sistema.txt", "w+");
            for(iterador=0; iterador<n_nodos; iterador++)
            {
                //printf("\n contador: %d ; %d", iterador, *(spin_nodos+iterador));
                x=columna+0.5;
                y=fila+0.5;
                fprintf(spines_sistema, "%d %f %f %d \n", iterador, x, y, *(spin_nodos+iterador));

                if((iterador+1)%n_lado==0){
                    fila++;
                    columna=0;
                }
                else{
                    columna++;
                }

            }
            fclose(spines_sistema);

            //...y escribimos tambien el tamanio de la red...
            lado_red=fopen("lado_red.txt", "w+");
            fprintf(lado_red, "%d", n_lado);
            fclose(lado_red);
        }


        //...muestra el vector que contienes los espines...
        void muestraVectorSistema(){
            int iterador=0;
            for(iterador=0; iterador<n_nodos; iterador++){
                printf("\n %d", spin_nodos[iterador]);
            }
        }


        //...grafico el sistema con GNUplot...
        void graficaSistema(){
            system("gnuplot C:/Users/Usuario/Desktop/HPC/FISICA_COMPUTACIONAL/Ch10-Ising1/scriptGnuplot.txt -persist");
        }


        //...calculamos energía...
        void calcula(){
            int iterador=0;
            int suma_spines=0;
            int e_nodo=0;

            for(iterador=0; iterador<n_nodos; iterador++){

                suma_spines=suma_spines+(*(spin_nodos+iterador));

                e_nodo=0;
                if(iterador%(n_lado)==0){
                    printf("\n posicion: %d %d \n", iterador, *(spin_nodos+iterador));

                }

                energia=energia+e_nodo;
            }

            energia=(-1)*energia;
            magnetizacion=(float)suma_spines/(float)n_nodos;
            printf("\n magnetizacion: %f \n", magnetizacion);
            printf("energia: %d \n", energia);
        }

};
