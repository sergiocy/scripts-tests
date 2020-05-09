package com.sc.project.attackdbs.model;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

//import org.apache.solr.client.solrj.impl.HttpSolrServer; 
import org.apache.solr.common.SolrInputDocument;

import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrQuery.ORDER;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;


/*
 * CLASE DONDE INCLUIMOS LA CONEXION Y PROCESOS (INSERCION DE DATOS) CON SOLR
 */
public class SolrConnection implements IConnection{

	String solrEndPoint = null;
	List<Map<String,List<String>>> solrData = null;
	List<String> solrSchema = null;
	
	
	/*
	 * ...constructor que recibe un endpoint y una lista de mapas...
	 * ...los mapas almacenan los datos: las claves de cada mapa representan el schema y las List los datos 
	 * ...notar que estos datos son todos de tipo string
	 */
	public SolrConnection(String endPoint, List<Map<String,List<String>>> data, List<String> schema){
		this.solrEndPoint = endPoint;
		
		// TODO
		// SE PODRÍA/DEBERIA VERIFICAR QUE "SCHEMA" TIENE LA MISMA LONGITUD QUE "DATA"
		this.solrSchema = schema;
		
		// TODO
		// SE PODRÍA/DEBERIA VERIFICAR QUE TODAS LAS LISTAS TIENEN LA MISMA LONGITUD
		this.solrData = data;
	}
	
	
	
	
	public void insertData() {
		//..definimos las variables que usamos en el método...
		String endPoint = this.solrEndPoint;
		List<Map<String,List<String>>> data = this.solrData;
		List<String> schema = this.solrSchema; 
      

		//HttpSolrServer server = new HttpSolrServer(endPoint);
		SolrClient client = new HttpSolrClient.Builder(endPoint).build();
		try{
			//...recorremos las listas contenidas en los Maps de "data" (su valor)	
			for(int i = 0; i<data.get(0).get(schema.get(0)).size(); i++){
				SolrInputDocument doc = new SolrInputDocument();
				for(int maps = 0; maps < data.size(); maps++){
					
					String thisKey = schema.get(maps);
					String thisElementValue = data.get(maps).get(schema.get(maps)).get(i);
					doc.addField(thisKey, thisElementValue);
					
			    	System.out.print(thisElementValue + " - ");
				}
				System.out.print("\n");
				
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


	
	
	public List<List<String>> querySolr(){
		String endPoint = this.solrEndPoint;
		
		List<List<String>> res = new ArrayList<List<String>>(); 
		
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		
		SolrClient client = new HttpSolrClient.Builder(endPoint).build();
		
		SolrQuery query = new SolrQuery();
		query.setQuery("*:*");
		query.setFields("id", "date", "tags");
		query.setStart(0);
		query.setRows(10000000);
		query.setSort("date", ORDER.asc);
		
		try {
			QueryResponse response = client.query(query);
			SolrDocumentList results = response.getResults();
			
			for(int i=0; i<results.size(); i++){
								
				//System.out.println(results.get(i).get("id") + " - "  + dateFormat.format((Date)results.get(i).get("date")) + " - " + results.get(i).get("tags"));
					
				try{
					List<String> oneTags = ((ArrayList<String>)results.get(i).get("tags"));
					for(int j = 0; j < oneTags.size(); j++){
						System.out.println(results.get(i).get("id") + " - "  + dateFormat.format((Date)results.get(i).get("date")) + " - " + oneTags.get(j).trim());
						
						List<String> oneRes = Arrays.asList(results.get(i).get("id").toString().trim(), dateFormat.format((Date)results.get(i).get("date")), oneTags.get(j).trim());
						res.add(oneRes);
					}
				}
				catch(NullPointerException e){
					//System.out.println(results.get(i).get("id") + " - "  + dateFormat.format((Date)results.get(i).get("date")) + " - " + "NULLLLL");
					System.out.println(e.getMessage());
				}
				
			}
			
		} 
		catch (SolrServerException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		} 
		
		
		return res;
	}
	
	


	public List<Map<String, List<String>>> queryData(String queryStr) {
		// TODO Auto-generated method stub
		return null;
	}
	

	
}
