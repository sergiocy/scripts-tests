package com.sc.project.trends.service;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.SolrQuery.ORDER;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;

public class TrendingTopicByPeak {
	
	
	String endPointSolr = null;
	String nameFieldTagsInSolr = null;
	String nameFieldDatesInSolr = null;
	String thirdFieldInQuery = null;
	List<String> tagsIn = null;
	List<String> tagsInUnique = null;
	Map<String, Double> historicMeans = null;
	Map<String, Double> historicDeviations = null;
	Map<String, Integer> trendingTopics = null;
	Map<String, Double> trendingTopicsMetric = null;
	Date startDate = null;
	Date endDate = null;
	
	
	
	public TrendingTopicByPeak (String endPoint, List<String> tags, String dateIni, String dateEnd, double factor, int nWindow, String nameFieldTags, String nameFieldDates, String thirdFieldInQuery){
		
		//System.out.println("OBJETO TRENDING TOPIC-PEAK CREADO");
		
		// 0.- seteamos argumentos de entrada...
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
		System.out.println(this.startDate);
		
		// 2.- ponemos las tags en minúsculas...
		this.tagsIn = toConvertTagsToLowerCase(tags);
		// ...y seteamos una lista de tags sin repeticiones...
		this.tagsInUnique = new ArrayList<String>();
		this.tagsInUnique.addAll(new HashSet<String>(tags));

		// ...recorremos las tags que se reciben...
		// "technology", "scrum", "oculus"
		//this.trendingTopics = new ArrayList<String>();
		this.trendingTopics = new TreeMap();
		this.trendingTopicsMetric = new TreeMap();
		this.historicDeviations = new TreeMap();
		this.historicMeans = new TreeMap();
		
		for(String t : this.tagsInUnique){
			System.out.println();
			System.out.println("TAG:"+ t);
			
			// 3.- consultamos el histórico de una tag...
			//		- obtenemos el historico de los datos
			Map<String, Integer> historic = this.toGetHistoricDataSet(t);
			//		- ordenamos por fechas el historico
			Map<Date, Integer> historicSort = this.toOrderHistoric(historic);
			//		- discretizamos el historico (anterior a la ventana de tiempo solicitada) en franjas de tiempo iguales a la solicitada
			Map<Date, Integer> historicDiscretized = this.toDiscreteOrderHistoric(historicSort, nWindow);
			//		- calculamos la media y desviacion del historico obtenido
			List<Double> historicMeasures = this.toGetHistoricMean(historicDiscretized);
			double historicMean = historicMeasures.get(0).doubleValue();
			double historicDeviation = historicMeasures.get(1).doubleValue();
			System.out.println("media y desv std: " + historicMean + " - " + historicDeviation);
			historicMeans.put(t, historicMeasures.get(0));
			historicDeviations.put(t, historicMeasures.get(1));
			
			
			// 4.- consultamos los datos en el periodo solicitado...
			Map<Date, Integer> period = this.toGetPeriodDataSet(t);
			
			
			// 5.- determinamos si es trending-topic o no...
			Boolean pOrNotP= this.toPeakOrNotToPeak(t, historicMean, period, historicDiscretized, factor);
			if(pOrNotP){
				//this.trendingTopics.add(t);
				int f = period.get(this.endDate);
				this.trendingTopics.put(t, f);
				this.trendingTopicsMetric.put(t, (f-historicMean)/f);
			}
			
		}
		
		
	}
	public Map<String, Integer> getTrendingTopics(){ return this.trendingTopics; }
	public Map<String, Double> getTrendingTopicsMetric(){ return this.trendingTopicsMetric; }
	public Map<String, Double> getHistoricMeans(){ return this.historicMeans; }
	public Map<String, Double> getHistoricDeviations(){ return this.historicDeviations; }
	
	
	
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
	
	
	
	// ...método para convertir tags a lowerCase si fuera necesario...
	public List<String> toConvertTagsToLowerCase(List<String> tags){
		List<String> tagsToLowerCase = new ArrayList<String>();
		
		for(String t : tags){
			tagsToLowerCase.add(t.toLowerCase());
		}
		
		return tagsToLowerCase;
	}
	
	
	
	//...un metodo para traer el histórico de frecuencias detectadas para un tag en concreto...
	public Map<String, Integer> toGetHistoricDataSet(String tagName){
		String endPoint = this.endPointSolr;
		String nameFieldDate = this.nameFieldDatesInSolr;
		String nameFieldTags = this.nameFieldTagsInSolr;
		String thirdField = this.thirdFieldInQuery;
		
		SimpleDateFormat newDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Map<String, Integer> tagHistoricFreq = new HashMap<String, Integer>();
		
		SolrClient client = new HttpSolrClient.Builder(endPoint).build();
		SolrQuery query = new SolrQuery();
		
		query.setQuery(thirdField + "(("+nameFieldTags+":"+tagName+ ") OR (" + nameFieldTags + ":"+StringUtils.capitalize(tagName)+"))");
		//query.setFields("id", "date", "tags");
		query.setFields(nameFieldDate, nameFieldTags);
		query.setStart(0);
		query.setRows(10000000);
		query.setSort(nameFieldDate, ORDER.asc);
		
		//int count = 0;
		try {
			QueryResponse response = client.query(query);
			SolrDocumentList results = response.getResults();
			
			for(int i=0; i<results.size(); i++){
								
				//System.out.println(results.get(i).get("id") + " - " + results.get(i).get("date") + " - " + results.get(i).get("tags"));
				
				String dateStr = newDateFormat.format((Date)results.get(i).get(nameFieldDate));
				if(tagHistoricFreq.containsKey(dateStr)){
					tagHistoricFreq.put(dateStr, tagHistoricFreq.get(dateStr)+1);
				}
				else{
					Integer val = 1;
					tagHistoricFreq.put(dateStr, val);
				}
				
			}
			
		} 
		catch (SolrServerException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		} 
		
		/*
		Iterator it = tagHistoricFreq.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry mapElement = (Map.Entry)it.next();
			System.out.println(mapElement.getKey() + " = " + mapElement.getValue());
		}
		*/
		
		return tagHistoricFreq;
	}
	
	
	
	//...un metodo para formar histórico discretizado según la ventana de tiempo requerida
	public Map<Date, Integer> toOrderHistoric(Map<String, Integer> map){
		
		Map<Date, Integer> newMap = new HashMap<Date, Integer>();
		//Map<Date, Integer> newMap = new TreeMap<Date, Integer>();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		Iterator it = map.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry mapElement = (Map.Entry)it.next();
			//System.out.println(mapElement.getKey() + " = " + mapElement.getValue());
			String thisDate = (String)mapElement.getKey();
			Integer thisInteger = (Integer)mapElement.getValue();
			
			try {
				newMap.put(dateFormat.parse(thisDate), thisInteger);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		Map<Date, Integer> newSortMap = new TreeMap(newMap);
		/*
		for(Map.Entry<Date, Integer> entry : newSortMap.entrySet()){
			System.out.println(dateFormat.format((Date)entry.getKey()) + " - " + (Integer)entry.getValue());
		}
		*/
		
		
		/*
		SortedMap<String, Integer> mapSort = new TreeMap<String, Integer>();
		Iterator it = map.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry mapElement = (Map.Entry)it.next();
			//System.out.println(mapElement.getKey() + " = " + mapElement.getValue());
			mapSort.put((String)mapElement.getKey(),  (Integer)mapElement.getValue());
		}
		
		Iterator iterator = map.keySet().iterator();
		while (iterator.hasNext()) {
			Object key = iterator.next();
			System.out.println("Clave : " + key + " Valor :" + map.get(key));
		}
		*/
		return newSortMap;
	}
	
	
	
	//...un metodo para formar histórico discretizado según la ventana de tiempo requerida
	public Map<Date, Integer> toDiscreteOrderHistoric(Map<Date, Integer> map, int n){
		Map<Date, Integer> mapDiscrete = new TreeMap();
		//List<Map<Date, Integer>> mapsDiscretization = new ArrayList<Map<Date, Integer>>();
		
		//...definimos el tamaños, en días de la ventana temporal...
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar dateIniTemporalWindow = Calendar.getInstance();
		dateIniTemporalWindow.setTime(this.startDate);
		Calendar dateEndTemporalWindow = Calendar.getInstance();
		dateEndTemporalWindow.setTime(this.endDate);
		int sizeDaysTemporalWindows = dateEndTemporalWindow.get(Calendar.DAY_OF_YEAR) - dateIniTemporalWindow.get(Calendar.DAY_OF_YEAR);
		//System.out.println(String.valueOf(sizeDaysTemporalWindows));
		
		//...recorreremos el map de entrada contando las frecuencias en cada franja de tiempo...
		//Set<Date> dateList = map.keySet(); 
		List<Date> dateList = new ArrayList<Date>(map.keySet());
		Calendar calHistoricIni = Calendar.getInstance();
		calHistoricIni.setTime(dateList.get(0));
		
		//Calendar calAuxIni = Calendar.getInstance();
		Calendar calAuxEnd = dateIniTemporalWindow;
		
		//...recorreremos el calendario hacia atrás hasta llegar a la fecha inicial del histórico...
		//...definimos una variable para controlar el número de ventanas temporales que queremos considerar...
		int nTempWindow = 0;
		while((calAuxEnd.after(calHistoricIni)) && (nTempWindow < n)){
			Map<Date, Integer> mapDiscretization = new TreeMap();
			// NOTAR QUE DE ESTA MANERA EL INTERVALO DE TIEMPO RESULTA EXCLUSIVO EN EL EXTREMO SUPERIOR DEL INTERVALO TEMPORAL
			//Calendar calIniWindow = calAuxEnd;
			//Date aux1 = calIniWindow.getTime();
			
			for(int day = 1; day <= sizeDaysTemporalWindows; day++){
				calAuxEnd.add(Calendar.DATE, -1);
				Date dateAux = calAuxEnd.getTime();
				if(map.containsKey(dateAux)){
					mapDiscretization.put(dateAux, map.get(dateAux));
				}
				
				//System.out.println(dateAux);
			}
			//Date aux2 = calIniWindow.getTime();
			
			int sumFreqsDiscretization = 0;
			for(Map.Entry<Date, Integer> entry : mapDiscretization.entrySet()){
				System.out.println(dateFormat.format((Date)entry.getKey()) + " - " + (Integer)entry.getValue());
				
				sumFreqsDiscretization = sumFreqsDiscretization + entry.getValue().intValue();
			}
			
			calAuxEnd.add(Calendar.DATE, sizeDaysTemporalWindows);
			//Date aux3 = calAuxEnd.getTime();
			mapDiscrete.put(calAuxEnd.getTime(), (Integer)sumFreqsDiscretization);
			
			// SI QUEREMOS QUE LAS VENTANAS DE TIEMPO NO SE SOLAPEN DESCOMENTAMOS
			// // calAuxEnd.add(Calendar.DATE, -sizeDaysTemporalWindows);
			calAuxEnd.add(Calendar.DATE, -1);
			
			//Date aux4 = calAuxEnd.getTime();
			System.out.println("-------------" + calAuxEnd.getTime() + "-------------");
			
			nTempWindow++;
		}

		
		return mapDiscrete;
	}
	
	
		
	//...método para obtener los datos en el periodo solicitado y poder compararlo con el histórico...
	public Map<Date, Integer> toGetPeriodDataSet(String tagName){
		String endPoint = this.endPointSolr;
		String nameFieldDate = this.nameFieldDatesInSolr;
		String nameFieldTags = this.nameFieldTagsInSolr;
		String thirdField = this.thirdFieldInQuery;
		
		//SimpleDateFormat newDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String newStartDate = dateFormat.format(this.startDate).replace(" ", "T").concat("Z");
		String newEndDate = dateFormat.format(this.endDate).replace(" ", "T").concat("Z");		
		
		Map<Date, Integer> mapPeriodTag = new HashMap<Date, Integer>();
		
		SolrClient client = new HttpSolrClient.Builder(endPoint).build();
		SolrQuery query = new SolrQuery();
		
		query.setQuery(thirdField + "(("+nameFieldTags+":"+tagName+ ") OR (" + nameFieldTags+":"+StringUtils.capitalize(tagName)+")) AND ("+nameFieldDate+":["+newStartDate+" TO "+newEndDate+"])");
		//query.setFields("id", "date", "tags");
		query.setFields(nameFieldDate, nameFieldTags);
		query.setStart(0);
		query.setRows(10000000);
		query.setSort(nameFieldDate, ORDER.asc);
		
		//int count = 0;
		try {
			QueryResponse response = client.query(query);
			SolrDocumentList results = response.getResults();
			
			System.out.println("frecuencia en el periodo seleccionado: " + results.size());

			//for(int i=0; i<results.size(); i++){
								
				//System.out.println(/*results.get(i).get("id") + " - " +*/ results.get(i).get(nameFieldDate) + " - " + results.get(i).get(nameFieldTags));
				/*
				String dateStr = newDateFormat.format((Date)results.get(i).get("date"));
				if(tagHistoricFreq.containsKey(dateStr)){
					tagHistoricFreq.put(dateStr, tagHistoricFreq.get(dateStr)+1);
				}
				else{
					Integer val = 1;
					tagHistoricFreq.put(dateStr, val);
				}
				*/
			//}
			
			mapPeriodTag.put(this.endDate, results.size());
			
		} 
		catch (SolrServerException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		} 
		
		/*
		Iterator it = tagHistoricFreq.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry mapElement = (Map.Entry)it.next();
			System.out.println(mapElement.getKey() + " = " + mapElement.getValue());
		}
		*/
		
		return mapPeriodTag;
	}

	
	
	//...metodo para calcular la media del historico...
	public List<Double> toGetHistoricMean(Map<Date, Integer> mapHistoric){
		double mean = 0.;
		double stdDeviation = 0.;
		List<Double> measures = new ArrayList<Double>();
		
		//...calculamos la media...
		for(Map.Entry<Date, Integer> entry : mapHistoric.entrySet()){
			//System.out.println(dateFormat.format((Date)entry.getKey()) + " - " + (Integer)entry.getValue());
			mean = mean + entry.getValue().intValue();
			//System.out.println(String.valueOf(mean));
		}
		mean = mean/mapHistoric.size();
		
		//...y la desviacion tipica...
		for(Map.Entry<Date, Integer> entry : mapHistoric.entrySet()){
			//System.out.println(dateFormat.format((Date)entry.getKey()) + " - " + (Integer)entry.getValue());
			double term = Math.pow((Integer)entry.getValue() - mean, 2);
			
			stdDeviation = stdDeviation + term;
		}
		stdDeviation = stdDeviation/mapHistoric.size();
		stdDeviation = Math.sqrt(stdDeviation);
		
		
		measures.add(mean);
		measures.add(stdDeviation);
		//System.out.println("media calculada: " + String.valueOf(mean));
		return measures;
	}
	
	
	
	//...metodo para determinar  si hay pico en frecuencias o no...
	//...se aplica criterio de que tenga una frecuencia superior a la media de su histórico y con un crecimiento del doble de la ventana de tiempo anterior...
	//...el factor para el crecimiento puede ser parametrizable...
	public boolean toPeakOrNotToPeak(String tagName, double mean, Map<Date, Integer> mapPeriod, Map<Date, Integer> mapHistoric, double fac){
		Boolean yn = false;
		
		//...verificacmos que exista la clave, por si acaso. (debe de existir siempre)
		if(mapPeriod.containsKey(this.endDate)){
			if(mapPeriod.get(this.endDate) > (mean*fac)){
				
				//if(mapHistoric.containsKey(this.startDate)){
				//	if((fac*mapHistoric.get(this.startDate)) < (mapPeriod.get(this.endDate))){
						yn = true;
						//System.out.println(tagName);
				//	}
				//}
				
			}
		}
		
		return yn;
	}
	
	
}
