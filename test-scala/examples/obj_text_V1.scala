
/* ************************ */
//OBJECT TO FIRST-PROCESSING TEXT
/* *********************** */

object TextV1{

    //...INITIALITATION BLOCK...
    //...we define data (in RDD)... 
    //{
        println("...esto es un nuevo objeto...")
		//...cargamos el archivo en el "sparkContext"...
        val tex1 = sc.textFile("/home/sergio/Escritorio/datosPrueba/texto1.txt")
		//...y la cadena de texto asociada...
		val str = tex1.first()
    //}



    //...FUNCTION TO CLEAN PUNCTUATION MARKS...

    def cleanMarks(s: String): String = {
        val puntMarks = List(',', ';', '.')
        var str2 = s

        puntMarks.foreach(x => {str2 = str2.replace(x, ' ')})
        return str2.trim
    }

    //...FUNCTION TO CLEAN NO-RELEVANT WORDS...
    def deleteNoRelWords(s: String): String = {
        val noRelWords = List("el", "ya", "su", "de", "los")
        var str2 = s
    
        noRelWords.map(x => {if(x.equals(s)==true){str2 = " "} })
        return str2.trim
    }


}//...object end...




