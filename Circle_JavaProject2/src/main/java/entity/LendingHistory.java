package entity;

import java.util.Date;

public class LendingHistory {
	private int LendNo;
	private int ReserveNo;
	private String LibraryID;
	private int AccountNo;
	private int ItemNo;
	private int BookID;
	private Date DIssued;
	private Date DReturned;
	private Boolean Status;
	
	public LendingHistory() {}
	
	public LendingHistory(int lendNo, int reserveNo, String libraryID, int bookID, Date dIssued, Date dReturned, Boolean status) {
		LendNo = lendNo;
		ReserveNo = reserveNo;
		LibraryID = libraryID;
		BookID = bookID;
		DIssued = dIssued;
		DReturned = dReturned;
		Status = status;
	}
	
	public int getLendNo() {
		return LendNo;
	}

	public void setLendNo(int lendNo) {
		LendNo = lendNo;
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
	

	public int getAccountNo() {
		return AccountNo;
	}

	public void setAccountNo(int accountNo) {
		AccountNo = accountNo;
	}

	public int getItemNo() {
		return ItemNo;
	}

	public void setItemNo(int itemNo) {
		ItemNo = itemNo;
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
		return "LendingHistory [LendNo=" + LendNo + ", ReserveNo=" + ReserveNo + ", AccountNo=" + AccountNo + ", ItemNo=" + ItemNo + ", DIssued="
				+ DIssued + ", DReturned=" + DReturned + ", Status=" + Status + "]";
	} 
	
	
}