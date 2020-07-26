package entity;

import java.util.Date;

public class LendingHistory {
	private int LendNo;
	private int ReserveNo;
	private int AccountNo;
	private int ItemNo;
	private String LibraryID;
	private int BookID;
	private Date DIssued;
	private Date DReturned;
	private Boolean Status;
	
	public LendingHistory() {}
	
	public LendingHistory(int lendNo, String libraryID, int bookID, Date dIssued, Date dReturned, Boolean status) {
		LendNo = lendNo;
		LibraryID = libraryID;
		BookID = bookID;
		DIssued = dIssued;
		DReturned = dReturned;
		Status = status;
	}

	public int getLendNo() {
		return LendNo;
	}
	
	public int getReserveNo() {
		return ReserveNo;
	}

	public int getAccountNo() {
		return AccountNo;
	}

	public int getItemNo() {
		return ItemNo;
	}

	public void setLendNo(int lendNo) {
		LendNo = lendNo;
	}
	
	public void setReserveNo(int ReserveNo) {
		ReserveNo = ReserveNo;
	}

	public void setAccountNo(int AccountNo) {
		AccountNo = AccountNo;
	}

	public void setItemNo(int ItemNo) {
		ItemNo = ItemNo;
	}

	public String getLibraryID() {
		return LibraryID;
	}

	public void setLibraryID(String libraryID) {
		LibraryID = libraryID;
	}

	public int getBookID() {
		return BookID;
	}

	public void setBookID(int bookID) {
		BookID = bookID;
	}

	public Date getDIssued() {
		return DIssued;
	}

	public void setDIssued(Date dIssued) {
		DIssued = dIssued;
	}

	public Date getDReturned() {
		return DReturned;
	}

	public void setDReturned(Date dReturned) {
		DReturned = dReturned;
	}

	public Boolean getStatus() {
		return Status;
	}

	public void setStatus(Boolean status) {
		Status = status;
	}

	@Override
	public String toString() {
		return "LendingHistory [LendNo=" + LendNo + ", ReserveNo=" + ReserveNo + ", AccountNo=" + AccountNo + ", ItemNo=" + ItemNo + ", LibraryID=" + LibraryID + ", BookID=" + BookID + ", DIssued="
				+ DIssued + ", DReturned=" + DReturned + ", Status=" + Status + "]";
	} 
}
