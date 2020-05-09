package com.sc.project;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sc.project.trends.controller.UpToDateProcess;
import com.sc.project.attackdbs.service.getcontent.Directory;
import com.sc.project.attackdbs.service.textprocessing.TextGeneral;
import com.sc.project.attackdbs.service.textprocessing.TextResources;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws UnsupportedEncodingException
    {
    	
        //System.setProperty("http.proxyHost", "10.121.8.100");
		//System.setProperty("http.proxyPort", "8080");
        
        
        // C:/Users/scordoba/Desktop/textosPruebaClustering
     
        
        /*
         * ...CODIGO QUE USABA PARA LEER FICHERO CON TEXTO EN CADA LINEA...         
        Directory dir = new Directory();
        File fileToRead = new File("C:/Users/scordoba/Desktop/txtsPrueba/textos_originales_es.txt");
        List<String> corpus = dir.readOneFileLineByLine(fileToRead);
        dir.insertSolr(corpus);
        System.out.println(corpus.size());
        */
        
    	
 
    	
    	//TextResources resources = new TextResources();
        //TextGeneral t = new TextGeneral("esto es un texto de prueba para ver como se comporta la función cuando quito stopwords");
        //t.cleanStopwords(resources.getStopwords());
    	
    	
    	
    	
    	// /////////////////////////// PARA CARGAR EN SOLR LOS DATOS DE "SETDATATEST1()"
    	//SolrConnection solrTest = new SolrConnection("http://172.31.13.121:8983/solr/upToDateTestClusters", readTextToTestClusters(), Arrays.asList("id","content","category"));
    	//solrTest.insertData();
    	
    	
    	
    	UpToDateProcess utd = new UpToDateProcess();
    	//...pasamos como argumento el nombre del site del origen de datos...
    	//utd.upToDateTransferDataFromMysqlToSolr("technology");
    	//...objeto para llevar los datos a fichero...
    	//utd.upToDateGettingData();
    	utd.upTodateGettingTrendingTopicsV1();
    	
    	
    	
    	// /////////////////////////////...pruebas de modelado de topicos con mallet...
    	//TopicModeling m = new TopicModeling("esto es una prueba");
    }
    
    
   
   
     
    
    
    
    public static List<Map<String,List<String>>> setDataTest1(){
    	
    	List<Map<String,List<String>>> dataTest = new ArrayList<Map<String,List<String>>>();
    	
    	
    	Map<String,List<String>> m1 = new HashMap<String,List<String>>();
    	m1.put("id", Arrays.asList("0", "1", "2", "3"));
    	Map<String,List<String>> m2 = new HashMap<String,List<String>>();
    	m2.put("content", Arrays.asList("esto es el texto con id 0", "esto es el texto con id 1", "esto es el texto con id 2", "esto es el texto con id 3"));
    	Map<String,List<String>> m3 = new HashMap<String,List<String>>();
    	m3.put("ncluster", Arrays.asList("clus0", "clus1", "clus2", "clus3"));
    	Map<String,List<String>> m4 = new HashMap<String,List<String>>();
    	m4.put("otro", Arrays.asList("clus0nuevo", "clus1nuevo", "clus2nuevo", "clus3nuevo"));
    	
    	dataTest.add(m1);
    	dataTest.add(m2);
    	dataTest.add(m3);
    	dataTest.add(m4);
    	
    	return dataTest;
    }	
    
    
    public static List<Map<String,List<String>>> readTextToTestClusters(){
    	//...creamos objeto TextResources para hacer la limpieza de stopwords...
    	TextResources resources = new TextResources();
    	
    	
    	//capturamos y damos formato a los datos correspondientes a los ficheros del directorio de "astrofísica"...
    	Directory dirAstro = new Directory();
        dirAstro.readDirectory("C:/Users/scordoba/Desktop/textosPruebaClustering/Astrofisica");
        File[] filesAstro = dirAstro.getFiles();
        List<String> filesStrAstroOld = dirAstro.readFiles(filesAstro);
        dirAstro.setCategoryFiles("astro");
        
        List<String> filesStrAstro = new ArrayList<String>(); 
        List<String> catAstro = new ArrayList<String>(); 
        for(String s : filesStrAstroOld){
        	catAstro.add("astro");
        	
        	TextGeneral t = new TextGeneral(s);
        	filesStrAstro.add(t.cleanStopwordsEs(resources.getStopwords()));
        }
        
        
        //capturamos y damos formato a los datos correspondientes a los ficheros del directorio de "ia"...
        Directory dirIa = new Directory();
        dirIa.readDirectory("C:/Users/scordoba/Desktop/textosPruebaClustering/IA");
        File[] filesIa = dirIa.getFiles();
        List<String> filesStrIaOld = dirIa.readFiles(filesIa);
        dirIa.setCategoryFiles("ia");
        
        List<String> filesStrIa = new ArrayList<String>();
        List<String> catIa = new ArrayList<String>(); 
        for(String s : filesStrIaOld){
        	catIa.add("ia");
        	
        	TextGeneral t = new TextGeneral(s);
        	filesStrIa.add(t.cleanStopwordsEs(resources.getStopwords()));
        }
        
        
        //capturamos y damos formato a los datos correspondientes a los ficheros del directorio de "otros"...
        Directory dirOtros = new Directory();
        dirOtros.readDirectory("C:/Users/scordoba/Desktop/textosPruebaClustering/Otros");
        File[] filesOtros = dirOtros.getFiles();
        List<String> filesStrOtrosOld = dirOtros.readFiles(filesOtros);
        dirOtros.setCategoryFiles("otro");
        
        List<String> filesStrOtros = new ArrayList<String>();
        List<String> catOtros = new ArrayList<String>(); 
        for(String s : filesStrOtrosOld){
        	catOtros.add("otro");
        	
        	TextGeneral t = new TextGeneral(s);
        	filesStrOtros.add(t.cleanStopwordsEs(resources.getStopwords()));
        }
        
        
        
        //formamos las estructuras de datos para insertar...
        List<String> category = new ArrayList<String>();
        category.addAll(catAstro);
        category.addAll(catIa);
        category.addAll(catOtros);
        List<String> texts = new ArrayList<String>();
        texts.addAll(filesStrAstro);
        texts.addAll(filesStrIa);
        texts.addAll(filesStrOtros);
        List<String> ids = new ArrayList<String>();
        for(int i = 0; i < texts.size(); i++){
        	ids.add(String.valueOf(i));
        }
        
        for(int i = 0; i < texts.size(); i++){
        	System.out.println("id: " + ids.get(i) + " - categoria: " + category.get(i) + " - texto: " + texts.get(i));
        }
        
        
        Map<String, List<String>> mapIds = new HashMap<String, List<String>>();
        mapIds.put("id", ids);
        Map<String, List<String>> mapTexts = new HashMap<String, List<String>>();
        mapTexts.put("content", texts);
        Map<String, List<String>> mapCat = new HashMap<String, List<String>>();
        mapCat.put("category", category);
        
        List<Map<String,List<String>>> data = new ArrayList<Map<String,List<String>>>();
        data.add(mapIds);
        data.add(mapTexts);
        data.add(mapCat);
        
        
        return data;
    }
    
     
    
}
