package com.sc.project.attackdbs.model;

import java.util.List;
import java.util.Map;

public interface IConnection {

	public void insertData();
	
	public List<Map<String, List<String>>> queryData(String queryStr);
	
}
