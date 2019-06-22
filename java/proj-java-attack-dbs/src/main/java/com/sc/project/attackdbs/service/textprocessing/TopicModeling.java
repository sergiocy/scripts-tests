package com.sc.project.attackdbs.service.textprocessing;

import java.util.List;

import cc.mallet.topics.ParallelTopicModel;

public class TopicModeling {
	
	//..atributo para cuando entre un texto...
	String text = null;
	//...o atributo por si entra una colección de textos...
	//...sobreescribo el constructor para uno u otro caso...
	List<String> textCollection = null; 
	
	public TopicModeling(String textIn){
		this.text = textIn;
	}
	public TopicModeling(List<String> textsIn){
		this.textCollection = textsIn;
	}
	
	
	
	// TODO
	// ...implementar modelado de topicos con mallet
	public void first(){
		ParallelTopicModel lda = new ParallelTopicModel(1);
		
	}
	

}
