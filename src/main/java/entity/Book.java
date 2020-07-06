package entity;

import java.util.Date;

public class Book {
	private int BookNo;
	private String Title;
	private String Publisher;
	private String Author;
	private String Isbn;
	private int pages;
	private boolean status;
	private byte[] picture;
	private Date Ypublished;
	private int shelfNo;
	
	public int getShelfNo() {
		return shelfNo;
	}
	public void setShelfNo(int shelfNo) {
		this.shelfNo = shelfNo;
	}
	public Date getYpublished() {
		return Ypublished;
	}
	public void setYpublished(Date ypublished) {
		Ypublished = ypublished;
	}
	public byte[] getPicture() {
		return picture;
	}
	public void setPicture(byte[] picture) {
		this.picture = picture;
	}
	public int getBookNo() {
		return BookNo;
	}
	public void setBookNo(int bookNo) {
		BookNo = bookNo;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getPublisher() {
		return Publisher;
	}
	public void setPublisher(String publisher) {
		Publisher = publisher;
	}
	public String getAuthor() {
		return Author;
	}
	public void setAuthor(String author) {
		Author = author;
	}
	public String getIsbn() {
		return Isbn;
	}
	public void setIsbn(String isbn) {
		Isbn = isbn;
	}
	public int getPages() {
		return pages;
	}
	public void setPages(int pages) {
		this.pages = pages;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	
	
	
	public Book(int bookNo, String title, String publisher, String author, String isbn, int pages, boolean status,
			byte[] picture, Date ypublished, int shelfNo) {
		
		BookNo = bookNo;
		Title = title;
		Publisher = publisher;
		Author = author;
		Isbn = isbn;
		this.pages = pages;
		this.status = status;
		this.picture = picture;
		Ypublished = ypublished;
		this.shelfNo = shelfNo;
	}
	public Book() {
		}
	@Override
	public String toString() {
		return "Book [BookNo=" + BookNo + ", Title=" + Title + ", Publisher=" + Publisher + ", Author=" + Author
				+ ", Isbn=" + Isbn + ", pages=" + pages + ", status=" + status + "]";
	}
	
	
	
	
	

}
