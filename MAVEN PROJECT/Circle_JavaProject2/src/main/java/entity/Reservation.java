package entity;

import java.util.Date;

public class Reservation {
	private int ReserveNo;
	private String LibraryID;
	private String BookID;
	private Date DReserve;
	private Boolean Status;
	
	public Reservation() {}
	
	public Reservation(int reserveNo, String libraryID, String bookID, Date dReserve, Boolean status) {
		ReserveNo = reserveNo;
		LibraryID = libraryID;
		BookID = bookID;
		DReserve = dReserve;
		Status = status;
	}

	public int getReserveNo() {
		return ReserveNo;
	}

	public void setReserveNo(int reserveNo) {
		ReserveNo = reserveNo;
	}

	public String getLibraryID() {
		return LibraryID;
	}

	public void setLibraryID(String libraryID) {
		LibraryID = libraryID;
	}

	public String getBookID() {
		return BookID;
	}

	public void setBookID(String bookID) {
		BookID = bookID;
	}

	public Date getDReserve() {
		return DReserve;
	}

	public void setDReserve(Date dReserve) {
		DReserve = dReserve;
	}

	public Boolean getStatus() {
		return Status;
	}

	public void setStatus(Boolean status) {
		Status = status;
	}

	@Override
	public String toString() {
		return "Reservation [ReserveNo=" + ReserveNo + ", LibraryID=" + LibraryID + ", BookID=" + BookID + ", DReserve="
				+ DReserve + ", Status=" + Status + "]";
	}
}
