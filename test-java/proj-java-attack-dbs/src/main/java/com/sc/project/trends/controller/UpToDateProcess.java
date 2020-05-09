package com.sc.project.trends.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sc.project.attackdbs.model.MySqlConnection;
import com.sc.project.attackdbs.service.getcontent.Directory;
import com.sc.project.trends.service.TrendingTopicByVolume;
import com.sc.project.trends.service.UpToDateDataOrigin;

import com.sc.project.attackdbs.model.SolrConnection;
import com.sc.project.trends.service.TrendingTopicByPeak;
import com.sc.project.trends.service.UpToDateSetDataOrigin;

public class UpToDateProcess {

	
	public UpToDateProcess(){
		
	}
	
	
	
	/*
	 * ...usaremos criterio volumétrico y de compración con su histórico...
	 */
	public void upTodateGettingTrendingTopicsV1(){                                                                                                                //  "16/05/2017", "28/06/2017",
		
		TrendingTopicByVolume ttByVolume = new TrendingTopicByVolume("http://172.31.13.121:8983/solr/upToDateTextsV1"/*, Arrays.asList("technology", "scrum", "oculus")*/, "09/10/2016", "10/10/2016", 3, "tags", "date", "site:technology");
		int nDocsTotal = ttByVolume.getNDocsRecovered();
		Map<String, Integer> mapTTByVolume = ttByVolume.getTrendingTopics();
		Map<String, Double> mapTTByVolumeMetric = ttByVolume.getTrendingTopicsMetric();
		System.out.println("TRENDING TOPIC POR VOLUMEN");
		System.out.println("total de tags recuperados:" + ttByVolume.getNTagsRecovered());
		System.out.println("total de docs recuperados:" + String.valueOf(nDocsTotal));
		System.out.println("los mas relevantes segun el factor dado son: ");
		
		List<String> tagsToDetermineIfPeak = new ArrayList<String>();
		for(Map.Entry<String, Integer> entry : mapTTByVolume.entrySet()){
			//System.out.println(entry.getKey() + " - " + (Integer)entry.getValue());
			tagsToDetermineIfPeak.add(entry.getKey());
			
			if(mapTTByVolumeMetric.containsKey(entry.getKey())){
				System.out.println(entry.getKey() + " - " + (Integer)entry.getValue() + " - " + (Double)mapTTByVolumeMetric.get(entry.getKey()));
			}
			else{
				System.out.println(entry.getKey() + " - " + (Integer)entry.getValue() + " - " + null);
			}
		}
		
		/*
		for(String s : tagsToDetermineIfPeak){
			System.out.println(s);
		}
		*/
		System.out.println();
		
		

		System.out.println("TRENDING TOPIC POR PICO");          // "http://172.31.13.121:8983/solr/upToDateTextsV1"
		TrendingTopicByPeak ttByPeak = new TrendingTopicByPeak("http://172.31.13.121:8983/solr/upToDateTextsV1", tagsToDetermineIfPeak/*Arrays.asList("technology", "technology", "scrum", "oracle")*/, "08/10/2016", "10/10/2016", 1, 4, "tags", "date", "site:technology");
		Map<String, Integer> mapTTByPeak = ttByPeak.getTrendingTopics();
		Map<String, Double> mapTTByPeakMetric = ttByPeak.getTrendingTopicsMetric();
		Map<String, Double> mapTTByPeakHistoricMeans = ttByPeak.getHistoricMeans();
		Map<String, Double> mapTTByPeakHistoricDeviations = ttByPeak.getHistoricDeviations();
		for(Map.Entry<String, Integer> entry : ttByPeak.getTrendingTopics().entrySet()){
			if(ttByPeak.getTrendingTopicsMetric().containsKey(entry.getKey())){
				System.out.println(entry.getKey() + " - " + (Integer)entry.getValue() + " - " + (Double)ttByPeak.getTrendingTopicsMetric().get(entry.getKey()));
			}
			else{
				System.out.println(entry.getKey() + " - " + (Integer)entry.getValue() + " - " + null);
			}
		}
		
	}
	
	
	
	
	
	public void upToDateGettingData(){
		SolrConnection con = new SolrConnection("http://localhost:8983/solr/upToDateTextsV1", null, null);
		
		//...construimos la query
		//String queryStr = "";
		//con.queryData(queryStr);
		
		List<List<String>> res = con.querySolr();
		Directory d = new Directory();
		d.writeOneFileLineByLine(res, "C:/Users/scordoba/Desktop/upToDate_TrendingTopics/dataTagsTechnology.csv");
		
		
	}
	
	
	
	/*
	 * FUNCION PARA TRANSFERIR DATOS DE MYSQL A SOLR (SE PIDE COMO ARGUMENTO DE ENTRADA UNA STRING CON EL NOMBRE DEL SITE)
	 */
	public void upToDateTransferDataFromMysqlToSolr(String nameSite){
    	// ////////////////////////////  PARA CONECTAR CON MYSQL...
    	MySqlConnection msql = new MySqlConnection("localhost", "uptodateini", "root", "admin_SC");
    	msql.setMysqlConnection();
    	List<Map<String, List<String>>> rs = msql.queryData(this.queryUpToDateFirstTechnology());
    	//System.out.println(rs.size());
     	int endIterator = rs.get(0).get(msql.getFieldsInResultSet().get(0)).size();
     	
     	
	    // ////////////////////  PARA GENERAR LOS OBJETOS QUE INDEXAREMOS OBTENIDOS DE MYSQL
     	List<UpToDateDataOrigin> dataTexts = new ArrayList<UpToDateDataOrigin>();
     	for(int register = 0; register < endIterator; register++){
     		String id = String.valueOf(register);
     		String date = rs.get(0).get("date").get(register);
     		String title = rs.get(1).get("title").get(register);
     		String content = rs.get(2).get("content").get(register);
     		String feed = rs.get(3).get("feed").get(register);
     		String categories = rs.get(4).get("categories").get(register);
     		String tags = rs.get(5).get("tags").get(register);
     		
     		String site = nameSite;
     		
     		UpToDateDataOrigin reg = new UpToDateDataOrigin(id, date, title, content, feed, categories, tags, nameSite);
     		dataTexts.add(reg);
     	}
     	
     	
     	// ////////////////////// CREAMOS UN OBJETO QUE CONTIENE LA LISTA DE TEXTOS/OBJETOS RECOGIDOS EN EL PASO ANTERIOR...
     	UpToDateSetDataOrigin setDataTexts = new UpToDateSetDataOrigin(dataTexts);
     	//setDataTexts.printData(Arrays.asList("id", "date", "tags", "categories"), 5);
     	setDataTexts.insertData("http://localhost:8983/solr/upToDateTextsV1"/*, 30*/);
     	setDataTexts.insertDistinctTagsOrCategoriesInSolr("http://localhost:8983/solr/technologyTagsV1", "tags", "technology"/*30*/);
     	setDataTexts.insertDistinctTagsOrCategoriesInSolr("http://localhost:8983/solr/technologyCategoriesV1", "categories", "technology"/*, 30*/);
     	//setDataTexts.insertData("http://172.31.13.121:8983/solr/upToDateTextsV1"/*, 30*/);
     	//setDataTexts.insertDistinctTagsOrCategoriesInSolr("http://172.31.13.121:8983/solr/upToDateTagsV1", "tags", "technology"/*30*/);
     	//setDataTexts.insertDistinctTagsOrCategoriesInSolr("http://172.31.13.121:8983/solr/upToDateCategoriesV1", "categories", "technology"/*, 30*/);
     	
     	/*
     	int nCol = 2;
     	String s = msql.getFieldsInResultSet().get(nCol);
     	
    	for(int i=0; i < 5; i++){
    		//for(int nCol = 0; nCol < rs.size(); nCol++){
    			System.out.print(" - "+ rs.get(nCol).get( s ).get(i) +" - ");
    		//}
    		System.out.println("\n");
    	}
    	*/
    	
    }
    

	/*
	 * AQUÍ GUARDAMOS LA PRIMERA QUERY DEL SITE TECHNOLOGY PARA OBTENER LOS PRIMEROS TEXTOS Y SUS DATOS ASOCIADOS 
	 */
	public String queryUpToDateFirstTechnology(){
		String qry = " SELECT p.post_date `date`, p.post_title title, p.post_content content, ("
						+" SELECT pm.meta_value"
						+" FROM wp_11_postmeta pm"
						+" WHERE pm.post_id = p.ID"
						+" AND pm.meta_key = 'wpe_feed'"
					+" ) feed, ("
							+" SELECT GROUP_CONCAT(REPLACE(t.name, '&amp;', '&') SEPARATOR ', ')"
							+" FROM wp_11_terms t"
							+" JOIN wp_11_term_taxonomy tt ON tt.term_id = t.term_id" 
							+" JOIN wp_11_term_relationships tr ON tr.term_taxonomy_id = tt.term_taxonomy_id"
							+" WHERE tr.object_id = p.id"
							+" AND tt.taxonomy = 'category'"
					+" ) categories, ("
							+" SELECT GROUP_CONCAT(REPLACE(t.name, '&amp;', '&') SEPARATOR ', ')"
							+" FROM wp_11_terms t"
							+" JOIN wp_11_term_taxonomy tt ON tt.term_id = t.term_id" 
							+" JOIN wp_11_term_relationships tr ON tr.term_taxonomy_id = tt.term_taxonomy_id"
							+" WHERE p.id = tr.object_id"
							+" AND tt.taxonomy = 'post_tag'"
					+" ) tags"
							+" FROM wp_11_posts p"
							+" WHERE p.post_type = 'post'"
							+" AND p.post_status = 'publish'"
							+" GROUP BY p.ID"
							+" ORDER BY `date` DESC;";
		
		return qry;
	}
	
}
