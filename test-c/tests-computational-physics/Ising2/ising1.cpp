#include <stdio.h>
#include <stdlib.h>

#include "sistema.h"

//primera version del modelo de Ising

main(){

    Sistema sis1(5);
    //...inicializamos una configuracion...
    sis1.inicializa();

    //...mostramos el vector de spines generado...
    //sis1.muestraVectorSistema();

    //...escribimos vector de spines en un txt...
    sis1.escribeVectorSistema();

    //calculamos magnetizacion y energia...
    sis1.calcula();

    //...graficamos el sistema con gnuplot...
    sis1.graficaSistema();

}
