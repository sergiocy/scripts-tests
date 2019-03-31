
//...funcion para eliminar palabras no relevantes de la cadena
//..."str" que recibe y definidas en "noRelWords"...
def deleteNoRelWords(str: String): String = {
    
    val noRelWords = List("el", "ya", "su", "de", "los")
    var str2 = str
    
    noRelWords.map(x => {if(x.equals(str)==true){str2 = " "} })

    return str2.trim
}

