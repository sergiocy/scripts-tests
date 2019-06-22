package com.sc.project.trends.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.SolrQuery.ORDER;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;

/*
 * CRITERIO DE DETECCIÓN DE TRENDING TOPICS SEGÚN VOLUMEN DEL TAG RESPECTO DE LA CANTIDAD TOTAL DE TAGS DETECTADOS
 * 
 * ...necesitamos en la entrada (pensar que podrá ser un WI)
 * 	- ventana temporal
 * 	- ¿parámetro asociado a volumen?
 * 	- el endPoint de Solr para la consulta
 * 	- un listado de tags: con repeticiones!!! no unicos!!!... lo necesito para contar apariciones
 * 
 * 
 * ...en la salida debe de haber:
 * 	- un listado de tags que resulten ser trending topic
 * 	- sus parámetros volumétricos asociados
 * 		- el valor absoluto de tags detectados
 * 		- valor absoluto de las apariciones del tag que resulte ser trending topic
 * 		- proporcion
 */
public class TrendingTopicByVolume {

	String endPointSolr = null;
	String nameFieldTagsInSolr = null;
	String nameFieldDatesInSolr = null;
	String thirdFieldInQuery = null;
	//List<String> tagsIn = null;
	//List<String> tagsRecoveredFromSolr = null;
	//List<String> trendingTopics = null;
	Map<String, Integer> trendingTopics = null;
	Map<String, Double> trendingTopicsMetric = null;
	Date startDate = null;
	Date endDate = null;
	int nTagsRecovered = 0;
	int nDocsRecovered = 0;
	
	
	
	
	public TrendingTopicByVolume(String endPoint, String dateIni, String dateEnd, double factor, String nameFieldTags, String nameFieldDates, String thirdFieldInQuery){
		//System.out.println("OBJETO TRENDING TOPIC CREADO");
		
		// 0.- seteamos argumentos de entrada de entrada...
		this.endPointSolr = endPoint;
		this.nameFieldTagsInSolr = nameFieldTags;
		this.nameFieldDatesInSolr = nameFieldDates;
		if(thirdFieldInQuery.equals("") || thirdFieldInQuery.equals(null)){
			this.thirdFieldInQuery = "";
		}
		else{
			this.thirdFieldInQuery = "("+thirdFieldInQuery+") AND ";
		}
		//this.tagsIn = tags; 
		
		// 1.- definimos fechas...
		this.startDate = this.toDefineDates(dateIni, "dd/MM/yyyy");
		this.endDate = this.toDefineDates(dateEnd, "dd/MM/yyyy");
		//System.out.println(this.startDate);
		
		// 2.- (OPCIONAL)formateamos (convertimos a minusculas) las tags que recibimos...
		//this.toConvertTagsToLowerCase();
		
		// 3.- lanzamos consulta contra Solr con las tags que tenemos y las fechas que hemos construido/seteado...
		//     ...en este caso, para ver la proporción entre el tag que estudiamos y todo el conjunto de los que se reciben, 
		//     queremos recuperar todos los documentos recibidos en la ventana de tiempo definida...
		List<String> results = this.toGetDataSet();
		this.nTagsRecovered = results.size();
		//for(String s : results){
		//	System.out.println(s);
		//}
		//System.out.println(String.valueOf(this.nTagsRecovered));
		
		// 4.- contamos las frecuencias de aparición de cada tag y las cargamos en un map...
		Map<String, Integer> resultsFrequencies = this.toComputeTagsFrequencies(results);
		
		// 5.- ordenamos el Map según frecuencias de aparición...
		Map<String, Integer> resultsFreqsTagsSelected = this.toSelectTagsFrequencies(resultsFrequencies, factor);
		this.trendingTopics = new TreeMap(resultsFreqsTagsSelected);
		//resultsFreqsTagsSelected = new TreeMap(resultsFreqsTagsSelected);
		
		//for(Map.Entry<String, Integer> entry : resultsFreqsTagsSelected.entrySet()){
		//	System.out.println(entry.getKey() + " - " + (Integer)entry.getValue());
		//}
	
	}
	
	public Map<String, Integer> getTrendingTopics(){ return this.trendingTopics; }
	public Map<String, Double> getTrendingTopicsMetric(){ return this.trendingTopicsMetric; }
	public int getNTagsRecovered() { return this.nTagsRecovered; }
	public int getNDocsRecovered() { return this.nDocsRecovered; }
	
	
	
	
	// ...método para definir la ventana temporal... la usaremos en el siguiente método en la consulta...
	public Date toDefineDates(String dateIn, String formatIn){
		SimpleDateFormat dateFormatIn = new SimpleDateFormat(formatIn);
		//SimpleDateFormat dateFormatOut = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date dateFinal = null;
		try {
			dateFinal = dateFormatIn.parse(dateIn);
			//dateFormatOut.format(dateFinal);
		} 
		catch (ParseException e) {	
			e.printStackTrace();
		}
		return dateFinal;
	}
	
	
	
	
	//...un metodo para traer los datos
	public List<String> toGetDataSet(){
		String endPoint = this.endPointSolr;
		String nameFieldDate = this.nameFieldDatesInSolr;
		String nameFieldTags = this.nameFieldTagsInSolr;
		String thirdField = this.thirdFieldInQuery;
		
		List<String> tagsRecovered = new ArrayList<String>();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String newStartDate = dateFormat.format(this.startDate).replace(" ", "T").concat("Z");
		String newEndDate = dateFormat.format(this.endDate).replace(" ", "T").concat("Z");		
		
		System.out.println(newStartDate+" - "+newEndDate);
		
		
		SolrClient client = new HttpSolrClient.Builder(endPoint).build();
		SolrQuery query = new SolrQuery();
		
		query.setQuery(thirdField + "(" + nameFieldDate+":["+newStartDate+" TO "+newEndDate+"])");
		query.setFields(nameFieldDate, nameFieldTags);
		query.setStart(0);
		query.setRows(100000000);
		query.setSort(nameFieldDate, ORDER.asc);
		
		//int count = 0;
		try {
			QueryResponse response = client.query(query);
			SolrDocumentList results = response.getResults();
			this.nDocsRecovered = results.size();
			//System.out.println(String.valueOf(this.nDocsRecovered));
			
			for(int i=0; i<results.size(); i++){
								
				//System.out.println(results.get(i).get("id") + " - "  + dateFormat.format((Date)results.get(i).get("date")) + " - " + results.get(i).get("tags"));
					
				try{
					
					//List<String> oneTags = ((ArrayList<String>)results.get(i).get("tags"));
					List<String> oneTags = ((ArrayList<String>)results.get(i).get(nameFieldTags));
					for(int j = 0; j < oneTags.size(); j++){
						//System.out.println(results.get(i).get("id") + " - "  + dateFormat.format((Date)results.get(i).get("date")) + " - " + oneTags.get(j).trim());
						
						//List<String> oneRes = Arrays.asList(results.get(i).get("id").toString().trim(), dateFormat.format((Date)results.get(i).get("date")), oneTags.get(j).trim());
						//res.add(oneRes);
						tagsRecovered.add(oneTags.get(j).toLowerCase().trim());
						//count++;
					}
					
				}
				catch(NullPointerException e){
					//System.out.println(results.get(i).get("id") + " - "  + dateFormat.format((Date)results.get(i).get("date")) + " - " + "NULLLLL");
					System.out.println(e.getMessage());
				}
				
			}
			
			//System.out.println(String.valueOf((results.size())) );
		} 
		catch (SolrServerException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		} 
		//System.out.println(String.valueOf(count));
		//return res;
		return tagsRecovered;
	}
	
	
	
	// ...un método que estime los tags más relevantes
	// - calculo de volumen porcentual
	public Map<String, Integer> toComputeTagsFrequencies(List<String> tagsRecovered){
		Map<String, Integer> tagFreq = new HashMap<String, Integer>();
		
		for(String t : tagsRecovered){
			if(tagFreq.containsKey(t)){
				tagFreq.put(t, tagFreq.get(t)+1);
			}
			else{
				Integer val = 1;
				tagFreq.put(t, val);
			}
		}
		
		return tagFreq;
	}
	
	 
	
	// ...método para ordenar los tags en función de sus frecuencias...
	public Map<String, Integer> toSelectTagsFrequencies(Map<String, Integer> freqsMap, double fac){
		int freqMean = 0;
		Map<String, Integer> freqsMapsSelected = new HashMap<String, Integer>();
		Map<String, Double> freqsMapsSelectedNormalized = new HashMap<String, Double>();
		int nDocs = this.nDocsRecovered;
		
		Iterator it = freqsMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry mapElement = (Map.Entry)it.next();
			//System.out.println(mapElement.getKey() + " = " + mapElement.getValue());
			
			freqMean = freqMean + ((Integer)mapElement.getValue());
		}
		
		//...if para controlar el caso en el que no se recupere ninguna tag...
		if(freqsMap.size() == 0){
			freqMean = freqMean;
		}
		else{
			freqMean = freqMean/(freqsMap.size());
		}
			
		it = freqsMap.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry mapElement = (Map.Entry)it.next();
			if(((Integer)mapElement.getValue()).intValue() > (fac*freqMean)){
				//System.out.println(mapElement.getKey() + " = " + mapElement.getValue());
				freqsMapsSelected.put((String)mapElement.getKey(), (Integer)mapElement.getValue());
				
				//Double un = new Double( ((Integer)mapElement.getValue()).doubleValue()/nDocs );
				//System.out.println(" - un double impreso - " + Double.toString(un));
				freqsMapsSelectedNormalized.put((String)mapElement.getKey(), new Double( ((Integer)mapElement.getValue()).doubleValue()/nDocs ));
			}
		}
		//System.out.println("mediaaa: " + String.valueOf(freqMean));
		
		
		// ...we normalize the weights got for freqs, in loop-while before...
		// ...firstly, we get the sum of the weights...
		/*
		double sumWeights = 0.;
		for(Map.Entry<String, Double> entry : freqsMapsSelectedNormalized.entrySet()){
			sumWeights = sumWeights + entry.getValue();
		}
		// ...and we update the values in map...
		for(Map.Entry<String, Double> entry : freqsMapsSelectedNormalized.entrySet()){
			freqsMapsSelectedNormalized.put(entry.getKey(), entry.getValue()/sumWeights);
		}
		*/
		
		this.trendingTopicsMetric = new TreeMap(freqsMapsSelectedNormalized);
		return freqsMapsSelected;
	}
	
	
}
