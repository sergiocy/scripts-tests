

//...funcion para limpiar los signos de puntuacion de la cadena
//..."str" que recibe y definidos en "puntMarks"...
def cleanMarks(str: String): String = {

    val puntMarks = List(',', ';', '.')
    var str2 = str

    puntMarks.foreach(x => {str2 = str2.replace(x, ' ')})    

    return str2.trim
}


