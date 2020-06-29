package dao;

import java.sql.*;
import java.util.*;

import javax.swing.JOptionPane;

import common.*;
import entity.*;

public class DAOReservation {
	public static List<Reservation> Load() {
		List<Reservation> list = new ArrayList<Reservation>();
		
		try (
				var conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				var ps	= conn.prepareCall("{Call Load}");
				var rs 	= ps.executeQuery();
				) {
			
			while (rs.next()) {
				var acc = new Reservation();
				acc.setReserveNo(rs.getInt("ReserveNo"));
				acc.setLibraryID(rs.getString("libraryID"));
				acc.setBookID(rs.getString("bookID"));
				acc.setDReserve(rs.getDate("dReserve"));
				acc.setStatus(rs.getBoolean("status"));
				
				list.add(acc);
			}
			
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
		return list;
	}
}