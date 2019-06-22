package com.sc.project.attackdbs.service.getcontent;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


//import org.apache.solr.client.solrj.impl.HttpSolrServer;


/*
 * CLASE DONDE INCLUIMOS LECTURA DE FICHEROS Y DIRECTORIOS
 */
public class Directory {
	
	File dirToRead = null;
	File[] files = null;
	String categoryFiles = null;
	
	
	public Directory(){
			
	}
	public File[] getFiles(){ return this.files; }
	public String getCategoryFiles(){ return this.categoryFiles; } 
	public void setCategoryFiles(String cat){ this.categoryFiles = cat; } 
	

	
	/*
	 * FUNCION QUE LEE FICHERO DEL DIRECTORIO QUE RECIBE (VARIABLE DE ENTRADA) Y SETEA LA LISTA DE FILES QUE TENEMOS COMO ATRIBUTO
	 */
	public void readDirectory(String pathDir){
		this.dirToRead = new File(pathDir);
		this.files = this.dirToRead.listFiles(); 

		if(this.files == null){
			System.out.println("No hay ficheros");
		}
		else{
			for (int x=0;x<this.files.length;x++){
			    System.out.println(this.files[x].getName());
			}	
		}	
	}
	
	
	/*
	 * FUNCION QUE RECIBE UNA LISTA DE FILES Y DEVUELVE SUS CONTENIDOS EN UNA LISTA DE STRINGS; CADA ELEMENTO DE LA LISTA CORRESPONDE A UN FILE
	 */
	public List<String> readFiles(File[] files){
		List<String> corpusFiles = new ArrayList<String>();
		
		for(File f : files){

			try{
				//FileReader fr = new FileReader(f);
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(f), "UTF-8"));
				
				String contentFile = "";
				String oneLine = "";
				
				while((oneLine = br.readLine()) != null){
					contentFile = contentFile.concat(oneLine);	
				}
				
				corpusFiles.add(contentFile);
				br.close(); 
			}
			catch(Exception e){
				System.out.println(e.getMessage());
			}
		}
				
		return corpusFiles;
	}
	
	
	/*
	 * FUNCION QUE RECIBE UN FILE Y DEVUELVE SU CONTENIDO CARGADO EN UNA LISTA DE STRINGS; CADA ELEMENTO DE LA LISTA ES UNA LINEA DEL FILE
	 */
	public List<String> readOneFileLineByLine(File f){
		List<String> corpusFiles = new ArrayList<String>();

		try{
			//FileReader fr = new FileReader(f);
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(f), "UTF-8"));
			String oneLine = "";
			
			while((oneLine = br.readLine()) != null){
				if( !oneLine.equals("") ){
					corpusFiles.add(oneLine);
				}	
			}
			br.close(); 
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
					
		return corpusFiles;
	}

	
	/*
	 * FUNCION QUE RECIBE UNA LISTA DE LISTAS DE STRING E IMPRIME UNA LISTA POR LINEA
	 */
	public void writeOneFileLineByLine(List<List<String>> linesToWrite, String pathFile){
		try{
			PrintWriter writer = new PrintWriter(pathFile, "UTF-8");
			for(List<String> line : linesToWrite){
				writer.println(line.get(0)+";"+line.get(1)+";"+line.get(2));
			}
			writer.close();
		}
		catch(IOException e){
			System.out.println(e.getMessage());
		}
	}
	
}

