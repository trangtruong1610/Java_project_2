package entity;

import java.util.Date;

public class Reservation {
	private int ReserveNo;
	private int AccountNo;
	private int ItemNo;
	private Date DReserve;
	private Boolean Status;
	
	public Reservation() {}
	
	
	public Reservation(int reserveNo, int accountNO, int bookID, Date dReserve, Boolean status) {
		ReserveNo = reserveNo;
		AccountNo = accountNO;
		ItemNo = bookID;
		DReserve = dReserve;
		Status = status;
	}


	public int getReserveNo() {
		return ReserveNo;
	}

	public void setReserveNo(int reserveNo) {
		ReserveNo = reserveNo;
	}

	public int getAccountNO() {
		return AccountNo;
	}

	public void setAccountNO(int accountNO) {
		AccountNo = accountNO;
	}


	public int getBookID() {
		return ItemNo;
	}

	public void setBookID(int bookID) {
		ItemNo = bookID;
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
		return "Reservation [ReserveNo=" + ReserveNo + ", AccountNO=" + AccountNo + ", ItemNo=" + ItemNo + ", DReserve="
				+ DReserve + ", Status=" + Status + "]";
	}


}
