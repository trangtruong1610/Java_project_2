package entity;

public class BookCategory {
	private int BookNo;
	private int CategoryNo;
	
	public BookCategory() {}
	
	public BookCategory(int bookNo, int categoryNo) {
		BookNo = bookNo;
		CategoryNo = categoryNo;
	}
	
	public int getBookNo() {
		return BookNo;
	}
	public void setBookNo(int bookNo) {
		BookNo = bookNo;
	}
	public int getCategoryNo() {
		return CategoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		CategoryNo = categoryNo;
	}

	@Override
	public String toString() {
		return "Category [BookNo=" + BookNo + ", CategoryNo=" + CategoryNo + "]";
	}	
}
