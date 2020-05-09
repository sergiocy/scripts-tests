package com.sc.project.trends.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sc.project.attackdbs.service.textprocessing.TextGeneral;

public class UpToDateDataOrigin {
	
	String id = null;
	String title = null;
	String content = null;
	String feed = null;
	String site = null;
	
	Date date = null;
	
	String[] categories = null;
	String[] tags = null;
	
	
	
	public UpToDateDataOrigin(String id, String date, String title, String content, String feed, String categories, String tags, String site){
	
		this.id = id;
		this.date = this.setDate(date);
		this.title = title;
		this.content = this.setContent(content);
		this.feed = feed;
		this.site = site;
		
		this.categories = this.setCategories(categories);
		this.tags = this.setTags(tags);
	}
	
	
	/*
	 *  FUNCION QUE RECIBE, COMO STRING, LOS NOMBRES DE LAS VARIABLES QUE QUEREMOS DEVOLVER.
	 *  TAMBIEN LAS DEVUELVE COMO STRING 
	 */
	public List<String> toGetVariables(List<String> nameVars){
		List<String> varsToPrint = new ArrayList<String>();
		
		for(String name : nameVars){
			if(name.equals("id")){
				varsToPrint.add(this.getId());
			}
			if(name.equals("title")){
				varsToPrint.add(this.getTitle());
			}
			if(name.equals("content")){
				varsToPrint.add(this.getContent());
			}
			if(name.equals("feed")){
				varsToPrint.add(this.getFeed());
			}
			if(name.equals("date")){
				varsToPrint.add(this.getDate().toString());
			}
			if(name.equals("categories")){
				String cats = "";
				int cont = 0;
				for(String cat : this.getCategories()){
					cats = cats.concat(cat);
					if(cont!=(this.getCategories().length-1)){
						cats = cats.concat(", ");
					}
					cont++;
				}
				varsToPrint.add(cats);
			}
			if(name.equals("tags")){
				String tgs = "";
				int cont = 0;
				for(String tg : this.getTags()){
					tgs = tgs.concat(tg);
					if(cont!=(this.getTags().length-1)){
						tgs = tgs.concat(", ");
					}
					cont++;
				}
				varsToPrint.add(tgs);
			}
		}
		
		return varsToPrint;
	}
	
	
	public String getId() {
		return id;
	}

	public String getSite() {
		return site;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

	public String getFeed() {
		return feed;
	}


	public Date getDate() {
		return date;
	}


	public String[] getCategories() {
		return categories;
	}


	public String[] getTags() {
		return tags;
	}


	public Date setDate(String date){
		Date dateObj = null;
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			//dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
			dateObj = dateFormat.parse(date);
			//dateObj = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(date);
			//dateFormat.format(dateObj);
			
			//System.out.println(dateFormat.format(dateObj));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dateObj;
	}
	
	public String setContent(String txt){
		TextGeneral txtHtml = new TextGeneral(txt);
 		String txtHtmlCleaned = txtHtml.cleanHtmlTags();
 		return txtHtmlCleaned;
	}
	
	public String[] setTags(String tags){
		try{
			if ((!tags.equals(null)) || (!tags.equals(""))){
				String[] tagsObj = tags.split(",");
				for(int i=0; i < tagsObj.length; i++){
					tagsObj[i] = tagsObj[i].trim();
				}
				return tagsObj;
			}
			else{
				return null;
			}
		}
		catch(Exception e){
			return null;
		}
	}
	
	public String[] setCategories(String cats){
		try{
			if(!cats.equals(null)){	
				String[] catsObj = cats.split(",");
				for(int i=0; i < catsObj.length; i++){
					catsObj[i] = catsObj[i].trim();
				}
				
				return catsObj;
			}
			else{
				return null;
			}
		}
		catch(Exception e){
			return null;
		}
	}
	
}
