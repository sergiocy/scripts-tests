package com.sc.project.trends.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
//import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.common.SolrInputDocument;

public class UpToDateSetDataOrigin {
	
	List<UpToDateDataOrigin> setData = null;
	List<String> setUniqueTags = null;
	List<String> setUniqueCategories = null;
	
	
	public UpToDateSetDataOrigin(List<UpToDateDataOrigin> setData){
		//List<UpToDateSetDataOrigin> lista = new ArrayList<UpToDateSetDataOrigin>();
		this.setData = setData;
		this.setUniqueTagsAndCategories();
	}
	
	
	public List<UpToDateDataOrigin> getSetData(){
		return this.setData;
	}
	public List<String> getSetUniqueTags(){
		return this.setUniqueTags;
	}
	public List<String> getSetUniqueCategories(){
		return this.setUniqueCategories;
	}
	
	
	
	public void setUniqueTagsAndCategories(/*int nObjs*/){
		List<UpToDateDataOrigin> data = this.setData;
		
		
    	String[] tags = {};
    	String[] categories = {};
    	
    	for(int i = 0; i < data.size()/*nObjs*/; i++){
    		tags = (String[])ArrayUtils.addAll(tags, data.get(i).getTags());
    		categories = (String[])ArrayUtils.addAll(categories, data.get(i).getCategories());
    	}
    	
    	this.setUniqueTags = new ArrayList<String>(new HashSet<String>(Arrays.asList(tags)));
    	this.setUniqueCategories = new ArrayList<String>(new HashSet<String>(Arrays.asList(categories)));
    	
    	/*
    	 * ...lineas que imprimen las categorias o tags...
    	int count = 0;
    	for(String t : this.setUniqueCategories){
    		System.out.println(t);
    		count ++;
    	}
    	System.out.println(count);
    	*/
	}
	
	
	public void printData(List<String> variablesToPrint, int nRegistersToPrint){
		List<UpToDateDataOrigin> registers = this.setData;
		
		for(int n=0; n<nRegistersToPrint; n++){
			List<String> variablesToShow = registers.get(n).toGetVariables(variablesToPrint);
			for(int v=0; v<variablesToShow.size(); v++){
				System.out.print(" - "+ variablesToShow.get(v) +" - ");
			}	
			System.out.print("\n");
		}
	}
	
	
	public void insertData(String endPoint/*, int nRegisters*/) {
		//..definimos las variables que usamos en el método... 
		List<UpToDateDataOrigin> data = this.setData;
		
		
		//HttpSolrServer server = new HttpSolrServer(endPoint);
		SolrClient client = new HttpSolrClient.Builder(endPoint).build();
		try{
			//...recorremos los registros que queremos cargar	
			for(int i = 0; i < data.size()/*nRegisters*/; i++){
				SolrInputDocument doc = new SolrInputDocument();

				doc.addField("id", data.get(i).getId());
				doc.addField("date", data.get(i).getDate());
				doc.addField("content", data.get(i).getContent());
				doc.addField("title", data.get(i).getTitle());
				doc.addField("feed", data.get(i).getFeed());
				doc.addField("tags", data.get(i).getTags());
				doc.addField("categories", data.get(i).getCategories());
				doc.addField("site", data.get(i).getSite());
				
				//server.add(doc);
		    	//server.commit();
				client.add(doc);
				client.commit();
			}
			
		    //server.commit();
		 }
		 catch(Exception e){
			 System.out.println(e.getMessage());
		 }
	}
	
	
	public void insertDistinctTagsOrCategoriesInSolr(String endPoint, String tagOrCategory, String nameSite/*, int nRegisters*/) {
		//..definimos las variables que usamos en el método... 
		List<String> setTags = this.setUniqueTags;
		List<String> setCats = this.setUniqueCategories;
		
		
		SolrClient client = new HttpSolrClient.Builder(endPoint).build();
		//HttpSolrServer server = new HttpSolrServer(endPoint);
		try{
			//...recorremos los registros que queremos cargar
			if(tagOrCategory.equals("tags")){
				for(int i = 0; i < /*nRegisters*/setTags.size(); i++){
					SolrInputDocument doc = new SolrInputDocument();
					
					doc.addField("id", String.valueOf(i));
					doc.addField("tag", setTags.get(i));
					doc.addField("site", nameSite);
					
					//server.add(doc);
			    	//server.commit();
			    	client.add(doc);
			    	client.commit();
				}	
			}
			if(tagOrCategory.equals("categories")){	
				for(int i = 0; i < /*nRegisters*/setCats.size(); i++){
					SolrInputDocument doc = new SolrInputDocument();
					
					doc.addField("id", String.valueOf(i));
					doc.addField("category", setCats.get(i));
					doc.addField("site", nameSite);
					
					//server.add(doc);
			    	//server.commit();
			    	client.add(doc);
			    	client.commit();
				}
			}	
			
		 }
		 catch(Exception e){
			 System.out.println(e.getMessage());
		 }
	}

	
}
