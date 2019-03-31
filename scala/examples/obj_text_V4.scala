
/* ************************ */
//OBJECT TO FIRST-PROCESSING TEXT
/* *********************** */
//...cargamos el archivo en el "sparkContext"...
//val tex1 = sc.textFile("C:/Users/scordoba/Desktop/datosPrueba/texto1.txt")
//...y la cadena de texto asociada...
//val str = tex1.first()



object TextV4{

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


	//...FUNCION PARA CARGAR VARIOS FICHEROS EN EL MISMO RDD...
	def loadFiles(): Array[String] = {
		var texts = Array[String]()	
		for(i <- 1 to 4){
			texts = texts :+ sc.textFile(
				"C:/Users/scordoba/Desktop/datosPrueba/texto"+i.toString+".txt"
										).first()
		}
		return texts
	}


}//...object end...




