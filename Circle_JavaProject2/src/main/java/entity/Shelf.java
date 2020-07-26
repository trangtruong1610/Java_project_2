package entity;

public class Shelf {
	private int ShelfNo;
	private String Location;
	
	public Shelf() {}
	
	public Shelf(int shelfNo, String location) {
		ShelfNo = shelfNo;
		Location = location;
	}
	
	public int getShelfNo() {
		return ShelfNo;
	}
	public void setShelfNo(int shelfNo) {
		ShelfNo = shelfNo;
	}
	public String getLocation() {
		return Location;
	}
	public void setLocation(String location) {
		Location = location;
	}

	@Override
	public String toString() {
		return "Shelf [ShelfNo=" + ShelfNo + ", Location=" + Location + "]";
	}
}
