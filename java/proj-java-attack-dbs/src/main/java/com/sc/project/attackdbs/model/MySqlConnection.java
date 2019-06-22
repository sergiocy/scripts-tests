package com.sc.project.attackdbs.model;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;





public class MySqlConnection implements IConnection {
	
	String mysqlDataBase = null;
	String mysqlIp = null;
	String mysqlUser = null;
	String mysqlPassword = null;
	Connection mysqlConnection = null;
	//List<Map<String,List<String>>> mysqlData = null;
	//List<String> mysqlSchema = null;
	
	//...atributos para las queries...
	List<String> fieldsInResultSet = null;
	
	
	
	public MySqlConnection(String ipHost, String dbName, String us, String pw){
		this.mysqlDataBase = dbName;
		this.mysqlIp = ipHost;
		this.mysqlUser = us;
		this.mysqlPassword = pw;
		
		this.fieldsInResultSet = new ArrayList<String>();
	}
	
	public void setMysqlConnection(){
		String ip = this.mysqlIp;
		String db = this.mysqlDataBase;
		String us = this.mysqlUser;
		String pw = this.mysqlPassword;
		Connection con = null;
		
		
		String sURL = "jdbc:mysql://"+ip+"/"+db;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(sURL,us,pw);  //("jdbc:mysql://localhost/prueba","root", "la_clave")
		} 
		catch (SQLException e) {
			e.printStackTrace();
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		this.mysqlConnection = con; 
	}
	
	public List<String> getFieldsInResultSet(){
		return this.fieldsInResultSet;
	}
	
	
	
	/*
	 * FUNCION QUE GENERA EL RESULTSET EN UNA ESTRUCTURA List<Map<String, List<String>>> 
	 * OJO PORQUE ESTA HECHO PARA QUE LOS CAMPOS SEAN STRING
	 */
	public List<Map<String, List<String>>> queryData(String queryStr){
		Connection con = this.mysqlConnection;
		List<String> colNamesInQuery = new ArrayList<String>();
		
		//...generaremos un Map por cada columna que almacenamos en una lista de Maps. Esta estructura simula una tabla donde cada map es una columna...
		List<Map<String, List<String>>> queryResult = new ArrayList<Map<String, List<String>>>();
		
		
		try { 
			//...ejecutamos la consulta...
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(queryStr);
			
			
			//...obtenemos los nombres de las columnas, los seteamos en "colNamesInQuery"
			//...y en la lista de mapas...
			ResultSetMetaData colNames = rs.getMetaData();
			for(int nCol = 1; nCol <= colNames.getColumnCount(); nCol++){
				String oneColumnLabel = colNames.getColumnLabel(nCol).trim();
				colNamesInQuery.add(oneColumnLabel);
				
				Map<String, List<String>> oneColumn = new HashMap<String, List<String>>();
				oneColumn.put(oneColumnLabel, new ArrayList<String>());
				queryResult.add(oneColumn);
			}
			
			
			
			while (rs.next()){	
				for(int nCol = 1; nCol <= colNames.getColumnCount(); nCol++){
					String field = rs.getString(colNamesInQuery.get(nCol-1));
					
					queryResult.get(nCol-1).get(colNamesInQuery.get(nCol-1)).add(field);
				}
			}
						 
		} 
		catch (SQLException sqle) { 
			  System.out.println("Error en la ejecución:" 
			    + sqle.getErrorCode() + " " + sqle.getMessage());    
		}
		finally{
			try {
				con.close();
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		
		this.fieldsInResultSet = colNamesInQuery;
		return queryResult;
	}
	
	

	
	
	public void insertData() {
		// TODO Auto-generated method stub
		
	}

}
