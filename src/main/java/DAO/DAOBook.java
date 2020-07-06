package DAO;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JOptionPane;

import common.ConnecToProperties;

import entity.Book;


public class DAOBook {
	public void insertBook(Book book) {
		try(
				var con = DriverManager.getConnection(
						ConnecToProperties.getConnectionUrl());
					PreparedStatement ps = con.prepareCall("{call insertBook(?,?,?,?,?,?,?,?)}");
					)
				
		{	
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getPublisher());
			ps.setString(3, book.getAuthor());
			ps.setString(4, book.getIsbn());
			ps.setInt(5, book.getPages());
			ps.setInt(6, book.getShelfNo());
			ps.setDate(7, new java.sql.Date(book.getYpublished().getTime()));
			ps.setBytes(8, book.getPicture());
			ps.executeUpdate();
			JOptionPane.showMessageDialog(null, "insert success","success",JOptionPane.OK_OPTION);
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(),"info",JOptionPane.INFORMATION_MESSAGE);
		}
		
	}
	public void updateBook(Book book) {
		try(
				var con = DriverManager.getConnection(
						ConnecToProperties.getConnectionUrl());
					PreparedStatement ps = con.prepareCall("{call updateBook(?,?,?,?,?,?,?,?,?)}");
					
					)
				
		{
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getPublisher());
			ps.setString(3, book.getAuthor());
			ps.setString(4, book.getIsbn());
			ps.setInt(5, book.getPages());
			ps.setInt(6, book.getShelfNo());
			ps.setDate(7, new java.sql.Date(book.getYpublished().getTime()));
			ps.setBytes(8, book.getPicture());
			ps.setInt(9, book.getBookNo());
			ps.executeUpdate();
			JOptionPane.showMessageDialog(null, "update success","success",JOptionPane.OK_OPTION);
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(),"info",JOptionPane.INFORMATION_MESSAGE);
		}
		
	}
	public static PreparedStatement createPSShowBook(Connection con) throws SQLException {
		var ps = con.prepareCall("{call getFullBook(?)}");
		ps.setBoolean(1, true);
		return ps;
	}
	public List<Book> getAllBook(){
		List<Book> listBook = new ArrayList<Book>();
		try(
				var con = DriverManager.getConnection(
						ConnecToProperties.getConnectionUrl());
					PreparedStatement ps = createPSShowBook(con);
					ResultSet rs = ps.executeQuery();
					)
			 {
			while(rs.next()) {
				var book = new Book();
				book.setBookNo(rs.getInt("BookNo"));
				book.setTitle(rs.getString("Title"));
				book.setPublisher(rs.getString("Publisher"));
				book.setAuthor(rs.getString("Author"));
				book.setIsbn(rs.getString("ISBN"));
				book.setPages(rs.getInt("Pages"));
				book.setShelfNo(rs.getInt("ShelfNo"));
				book.setYpublished(rs.getDate("Ypublished"));
				book.setPicture(rs.getBytes("Image_book"));
				listBook.add(book);
			
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return listBook;
	
	}
	public void deleteBook(Book book) {
		try(
				var con = DriverManager.getConnection(
						ConnecToProperties.getConnectionUrl());
					PreparedStatement ps = con.prepareCall("{call deleteBook(?,?)}");
					
					)
				
		{
			ps.setBoolean(1, book.isStatus());
			ps.setInt(2, book.getBookNo());
			ps.executeUpdate();
			JOptionPane.showMessageDialog(null, "delete success","success",JOptionPane.OK_OPTION);
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, e.getMessage(),"info",JOptionPane.INFORMATION_MESSAGE);
		}
		
	}
	public static PreparedStatement createPSgetMaxId(Connection con) throws SQLException {
		var ps = con.prepareCall("{call getMaxId}");
		return ps;
	}
	

	

}
