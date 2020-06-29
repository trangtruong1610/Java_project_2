package entity;

public class Category {
	private int CategoryNo;
	private String CategoryName;
	
	public Category() {}
	
	public Category(int categoryNo, String categoryName) {
		CategoryNo = categoryNo;
		CategoryName = categoryName;
	}

	public int getCategoryNo() {
		return CategoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		CategoryNo = categoryNo;
	}

	public String getCategoryName() {
		return CategoryName;
	}

	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}

	@Override
	public String toString() {
		return "Category [CategoryNo=" + CategoryNo + ", CategoryName=" + CategoryName + "]";
	}
}
