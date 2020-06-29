package test;

import java.sql.Connection;
import java.sql.DriverManager;

import common.ConnecToProperties;

public class TestConnection {
	public static void main(String[] args) {
		Connection connec = null;
		try {
			connec = DriverManager.getConnection(
						ConnecToProperties.getConnectionUrl()
					);
			System.out.println("success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}