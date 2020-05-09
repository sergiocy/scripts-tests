#include <stdio.h>
#include <stdlib.h>

#include "sistema.h"

//primera version del modelo de Ising

main(){

    Sistema sis1(20);
    sis1.inicializa();

    //sis1.muestraVectorSistema();
    sis1.escribeVectorSistema();
    sis1.graficaSistema();
}
