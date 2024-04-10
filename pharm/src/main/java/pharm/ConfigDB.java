package pharm;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConfigDB {
	private static ConfigDB instance;
	
	private ConfigDB() {
		
	}
	
	public static ConfigDB getInstance() {
		if(instance == null) {
			instance = new ConfigDB();
		}
		return instance;
	}
	
	public Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_pharmacie?useSSL=FALSE&allowPublicKeyRetrieval=true", "brice", "123456");

		} catch (Exception e) {
			e.printStackTrace();
		} 
		return connection;
				
		
	}
	
	
}
