package entity;

public class BookDetail {
	private int BookNo;
	private String Title;
	private String Publisher;
	private String Author;
	private String ISBN;
	private int Pages;
	private Boolean Status;
	
	
	public BookDetail() {}
	
	public BookDetail(int bookNo, String title, String publisher, String author, String iSBN, int pages,
			Boolean status) {
		BookNo = bookNo;
		Title = title;
		Publisher = publisher;
		Author = author;
		ISBN = iSBN;
		Pages = pages;
		Status = status;
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
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public int getPages() {
		return Pages;
	}
	public void setPages(int pages) {
		Pages = pages;
	}
	public Boolean getStatus() {
		return Status;
	}
	public void setStatus(Boolean status) {
		Status = status;
	}

	@Override
	public String toString() {
		return "BookDetail [BookNo=" + BookNo + ", Title=" + Title + ", Publisher=" + Publisher + ", Author=" + Author
				+ ", ISBN=" + ISBN + ", Pages=" + Pages + ", Status=" + Status + "]";
	}
	
	
}
