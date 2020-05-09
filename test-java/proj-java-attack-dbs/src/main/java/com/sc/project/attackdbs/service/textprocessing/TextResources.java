package com.sc.project.attackdbs.service.textprocessing;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TextResources {
	
	List<String> stopwords = null; 
	
	
	public TextResources(){
		this.setStopwordsFromFileLineByLine("src/main/resources/stopwords_es.txt");
	}
	public List<String> getStopwords(){
		return this.stopwords;
	}
	
	
	
	
	public void setStopwordsFromFileLineByLine(String path){
		List<String> stpwrds = new ArrayList<String>();
		
		try {
			FileReader fr = new FileReader(path);
			BufferedReader br= new BufferedReader(fr);
	        
	        String sCurrentLine = "";
	        while ((sCurrentLine = br.readLine()) != null){
	            if(!sCurrentLine.equals("")){
	            	stpwrds.add(sCurrentLine);
	            }	
	        }   
		} 
		catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
        
		/*
		for(String s : stpwrds){
			System.out.println(" - " + s);
		}
		*/
		
		this.stopwords = stpwrds;
	}
	
}
