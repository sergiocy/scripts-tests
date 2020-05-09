
/* ************************ */
//OBJECT TO FIRST-PROCESSING TEXT
/* *********************** */
//...cargamos el archivo en el "sparkContext"...
val tex1 = sc.textFile("C:\Users\scordoba\Desktop\datosPrueba\texto1.txt")
//...y la cadena de texto asociada...
val str = tex1.first()



object TextV3{

    //...INITIALITATION BLOCK...
    //...we define data (in RDD)... 
    //{
      	println("...esto es un nuevo objeto...")
		//...cargamos el archivo en el "sparkContext"...
        //val tex1 = sc.textFile("/home/sergio/Escritorio/datosPrueba/texto1.txt")
		//...y la cadena de texto asociada...
		//val str = tex1.first()
    //}
	//...we define no-relevant words and punctuation marks...
	val noRelWords = Array("el", "ya", "su", "de", "los")
	val puntMarks = List(',', ';', '.')
        

    //...FUNCTION TO CLEAN PUNCTUATION MARKS...
    def cleanMarks(s: String): String = {
        //val puntMarks = List(',', ';', '.')
        var str2 = s

        puntMarks.foreach(x => {str2 = str2.replace(x, ' ')})
        return str2.trim
    }


    //...FUNCTION TO CLEAN NO-RELEVANT WORDS...
    def deleteNoRelWords(s: String): Array[String] = {
		//...we define no-relevant words in that array...
        //val noRelWords = Array("el", "ya", "su", "de", "los")
		var sArray = s.split(" ")
		var sArray2 = sArray.map(textWord => 
									if(noRelWords.contains(textWord)==true){
										""
									}
									else{
										textWord.trim.toLowerCase
									}
								).filter(_!="")
		
        return sArray2
    }


	//...FUNCTION TO BUILD TABLE WITH DISTINCT WORDS AND ITS FREQUENCIES...
	def buildTableWords(s: Array[String]): Array[(String, Int)] = {
		val table = sc.parallelize( s.map(word => (word.toString, 1)) ).reduceByKey(_+_).collect()
		return table
	}


}//...object end...




