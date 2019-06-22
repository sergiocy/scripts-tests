package com.sc.project.attackdbs.service.textprocessing;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;


/*
 * CLASE DONDE INCLUIMOS PROCESAMIENTOS ESTANDAR DE TEXTOS
 */
public class TextGeneral {
	
	String text = null;
	
	
	public TextGeneral(String text){
		this.text = text;	
	}
	public void setText(String textIn){this.text = textIn;}
	public String getText(){return this.text;}
	
	
	/*
	 * FUNCION QUE RECIBE UN LISTADO DE STOPWORDS Y LAS ELIMINA DE LA VARIABLE DE CLASE "TEXT"
	 * DEVUELVE EL TEXTO LIMPIO DE STOPWORDS
	 */
	public String cleanStopwordsEs(List<String> stopwords){
		String textOut = this.text;
		
		textOut = textOut.replace(".", "");
		textOut = textOut.replace(",", "");
		textOut = textOut.replace("¿", "");
		textOut = textOut.replace("?", "");
		textOut = textOut.replace("¡", "");
		textOut = textOut.replace("!", "");
		textOut = textOut.replace("\"", "");
		textOut = textOut.replace("(", "");
		textOut = textOut.replace(")", "");
		textOut = textOut.replace("-", " ");
		textOut = textOut.replace("_", " ");
		
		String[] wordsInText = textOut.split(" ");  
		List<String> newText = new ArrayList<String>();
		
		for(String wInText : wordsInText){
			if(!stopwords.contains(wInText)){
				newText.add(wInText);
			}
		}
		
		textOut = "";
		for(String s : newText){
			//System.out.println(s);
			textOut = textOut.concat(s + " ");
		}
		
		System.out.println(textOut);
		return textOut.trim();
	}
	
	

	public String convertToLowerCase(){
		String textOut = this.text;
		textOut = textOut.toLowerCase();

		return textOut;
	}
	
	
	
	public String cleanHtmlTags(){
		String textOut = this.text;
		textOut = Jsoup.parse(textOut).text();
		
		return textOut;
	}
	
}
