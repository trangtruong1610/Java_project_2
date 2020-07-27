package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import common.ConnecToProperties;

public class TestConnection {

	public static void main(String[] args) {
		
		try (
				Connection connection = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
		) {
			System.out.println("Successfully Connected!");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}

}