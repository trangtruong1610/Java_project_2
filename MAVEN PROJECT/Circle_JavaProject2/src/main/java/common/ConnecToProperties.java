package common;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

public class ConnecToProperties {
	
	public static String getConnectionUrl() {
		String url = null;

		try (FileInputStream stream = new FileInputStream("db.properties");) {
			Properties pro = new Properties();
			pro.load(stream);
			url = pro.getProperty("url") + pro.getProperty("serverName") + ":" + pro.getProperty("portNumber")
					+ "; databaseName=" + pro.getProperty("databaseName") + "; user=" + pro.getProperty("username")
					+ "; password=" + pro.getProperty("password");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			url = null;
		}

		return url;
	}
	
	public static String getConnectionUrlFromClassPath() {
		String url = null;

		try (InputStream stream = ConnecToProperties.class.getClassLoader()
							.getResourceAsStream("db.properties");) {
			Properties pro = new Properties();
			pro.load(stream);
			url = pro.getProperty("url") + pro.getProperty("serverName") + ":" + pro.getProperty("portNumber")
					+ "; databaseName=" + pro.getProperty("databaseName") + "; user=" + pro.getProperty("username")
					+ "; password=" + pro.getProperty("password");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			url = null;
		}

		return url;
	}

}