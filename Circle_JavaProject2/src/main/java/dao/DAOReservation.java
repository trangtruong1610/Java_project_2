package dao;

import java.sql.*;
import java.util.*;

import javax.swing.JOptionPane;

import common.ConnecToProperties;
import entity.LendingHistory;
import entity.Reservation;

public class DAOReservation {
	public static List<Reservation> Load() {
		List<Reservation> list = new ArrayList<Reservation>();
		
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call getAllReservation}");
				ResultSet rs 	= ps.executeQuery();
				) {
			
			while (rs.next()) {
				Reservation acc = new Reservation();
				acc.setReserveNo(rs.getInt("ReserveNo"));
				acc.setAccountNO(rs.getInt("AccountNo"));
				acc.setBookID(rs.getInt("ItemNo"));
				acc.setDReserve(rs.getDate("dReserve"));
				acc.setStatus(rs.getBoolean("status"));
				
				list.add(acc);
			}
			
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
		return list;
	}
	
	public static String getLibraryID(int AccNo) {
		String libraryID = null;
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call getLibraryID(?)}");
			) {
			
			ps.setInt(1, AccNo);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				libraryID = rs.getString("LibraryID");
			}	
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
		return libraryID;
	}
	
	public static String getBookID(int bookIdNo) {
		String bookID = null;
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call getBookID(?)}");
			) {
			
			ps.setInt(1, bookIdNo);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				bookID = rs.getString("bookID");
			}	
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
		return bookID;
	}
	
	public static void DeleteRequest(int ID) {
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call DeleteRequest(?)}");
				) {
			ps.setInt(1, ID);
			
			ps.executeUpdate();
			
			JOptionPane.showMessageDialog(null, "Request denined", "Success", JOptionPane.OK_OPTION);
			
			} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
	}
	
	public static List<Reservation> getReservationInfo(int ID) {
		List<Reservation> list = new ArrayList<Reservation>();
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call getReservationInfo(?)}");
				) {
			ps.setInt(1, ID);
			
			ResultSet rs =  ps.executeQuery();
			
			while (rs.next()) {
				Reservation res = new Reservation();
				res.setReserveNo(ID);
				res.setAccountNO(rs.getInt("AccountNo"));
				res.setBookID(rs.getInt("ItemNo"));
				res.setDReserve(rs.getDate("DReserve"));
				res.setStatus(rs.getBoolean("Status"));
				list.add(res);
				}	
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		return list;
	}
	
	public static void InsertLending(int ReverseNo, int accNo, int ItemNo) {
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call InsertLending(?,?,?)}");
				) {
			ps.setInt(1, ReverseNo);
			ps.setInt(2, accNo);
			ps.setInt(3, ItemNo);
			
			ps.executeUpdate();
			
			JOptionPane.showMessageDialog(null, "Insert Lending History Successfuly.", "Success", JOptionPane.OK_OPTION);
			
			} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
	}


}