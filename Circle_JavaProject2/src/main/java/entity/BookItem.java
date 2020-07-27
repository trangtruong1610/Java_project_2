package entity;

public class BookItem {
	private int BookItemNo;
	private int BookNo;
	private int ShelfNo;
	private String BookID;
	private Boolean Status;
	
	public BookItem() {}
	
	public BookItem(int bookItemNo, int bookNo, int shelfNo, String bookID, Boolean status) {
		BookItemNo = bookItemNo;
		BookNo = bookNo;
		ShelfNo = shelfNo;
		BookID = bookID;
		Status = status;
	}

	public int getBookItemNo() {
		return BookItemNo;
	}

	public void setBookItemNo(int bookItemNo) {
		BookItemNo = bookItemNo;
	}

	public int getBookNo() {
		return BookNo;
	}

	public void setBookNo(int bookNo) {
		BookNo = bookNo;
	}

	public int getShelfNo() {
		return ShelfNo;
	}

	public void setShelfNo(int shelfNo) {
		ShelfNo = shelfNo;
	}

	public String getBookID() {
		return BookID;
	}

	public void setBookID(String bookID) {
		BookID = bookID;
	}

	public Boolean getStatus() {
		return Status;
	}

	public void setStatus(Boolean status) {
		Status = status;
	}

	@Override
	public String toString() {
		return "BookItem [BookItemNo=" + BookItemNo + ", BookNo=" + BookNo + ", ShelfNo=" + ShelfNo + ", BookID="
				+ BookID + ", Status=" + Status + "]";
	}
	
}
