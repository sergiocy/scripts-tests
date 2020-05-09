
/* ********************* */
//...cargamos texto (alojado en la ruta dada)...
//val tex1 = sc.textFile("/home/sergio/Escritorio/datosPrueba/texto1.txt")

//...y lo spliteamos en otra variable, quedando un array de strings...
//var tex1Array = tex1.first().split(" ")
/* ********************** */


//...FUNCION PARA CARGAR VARIOS FICHEROS EN EL MISMO RDD...
def loadFiles(): Array[String] = {
	
	var texts = Array[String]()	
	
	for(i <- 1 to 3){
		texts = texts :+ sc.textFile(
			"/home/sergio/Escritorio/datosPrueba/texto"+i.toString+".txt"
									).first()
	}

	return texts
}
