package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JOptionPane;

import common.ConnecToProperties;
import entity.LendingHistory;

public class DAOLendingHistory {
	public static List<LendingHistory> Load() {
		List<LendingHistory> list = new ArrayList<LendingHistory>();
		
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call getAllLendingHistory}");
				ResultSet rs 	= ps.executeQuery();
				) {
			
			while (rs.next()) {
				LendingHistory le = new LendingHistory();
				le.setLendNo(rs.getInt("LendNo"));
				le.setReserveNo(rs.getInt("ReserveNo"));
				le.setAccountNo(rs.getInt("AccountNo"));
				le.setItemNo(rs.getInt("ItemNo"));
				le.setDIssued(rs.getDate("DIssued"));
				le.setDReturned(rs.getDate("DReturned"));
				le.setStatus(rs.getBoolean("Status"));
				
				list.add(le);
			}
			
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
		return list;
	}
	

	public static void ReturnLending(int ID, Date d) {
		try (
				Connection conn = DriverManager.getConnection(ConnecToProperties.getConnectionUrl());
				CallableStatement ps	= conn.prepareCall("{Call ReturnLending(?,?)}");
				) {
			ps.setInt(1, ID);
			ps.setDate(2, d);
			
			ps.executeUpdate();
			
			JOptionPane.showMessageDialog(null, "Return Success", "Success", JOptionPane.OK_OPTION);
			
			} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "Info", JOptionPane.INFORMATION_MESSAGE);
		}
		
	}
	

}
