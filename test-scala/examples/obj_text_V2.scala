
/* ************************ */
//OBJECT TO FIRST-PROCESSING TEXT
/* *********************** */
//...cargamos el archivo en el "sparkContext"...
val tex1 = sc.textFile("/home/sergio/Escritorio/datosPrueba/texto1.txt")
//...y la cadena de texto asociada...
val str = tex1.first()


object TextV2{

    //...INITIALITATION BLOCK...
    //...we define data (in RDD)... 
    //{
      	println("...esto es un nuevo objeto...")
		//...cargamos el archivo en el "sparkContext"...
        //val tex1 = sc.textFile("/home/sergio/Escritorio/datosPrueba/texto1.txt")
		//...y la cadena de texto asociada...
		//val str = tex1.first()
    //}



    //...FUNCTION TO CLEAN PUNCTUATION MARKS...

    def cleanMarks(s: String): String = {
        val puntMarks = List(',', ';', '.')
        var str2 = s

        puntMarks.foreach(x => {str2 = str2.replace(x, ' ')})
        return str2.trim
    }

    //...FUNCTION TO CLEAN NO-RELEVANT WORDS...
    def deleteNoRelWords(s: String): Array[String] = {
		//...we define no-relevant words in that array...
        val noRelWords = Array("el", "ya", "su", "de", "los")
		var sArray = s.split(" ")
		var sArray2 = sArray.map(textWord => 
									if(noRelWords.contains(textWord)==true){
										""
									}
									else{
										textWord
									}
								).filter(_!="")
		
        return sArray2
    }


}//...object end...




