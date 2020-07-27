package entity;

public class Fine {
	private int FineNo;
	private int LendNo;
	private int OverduedDate;
	private int FineAmount;
	
	public Fine() {} 
	
	
	public Fine(int fineNo, int lendNo, int overduedDate, int fineAmount) {
		FineNo = fineNo;
		LendNo = lendNo;
		OverduedDate = overduedDate;
		FineAmount = fineAmount;
	}


	public int getFineNo() {
		return FineNo;
	}


	public void setFineNo(int fineNo) {
		FineNo = fineNo;
	}


	public int getLendNo() {
		return LendNo;
	}


	public void setLendNo(int lendNo) {
		LendNo = lendNo;
	}


	public int getOverduedDate() {
		return OverduedDate;
	}


	public void setOverduedDate(int overduedDate) {
		OverduedDate = overduedDate;
	}


	public int getFineAmount() {
		return FineAmount;
	}


	public void setFineAmount(int fineAmount) {
		FineAmount = fineAmount;
	}


	@Override
	public String toString() {
		return "Fine [FineNo=" + FineNo + ", LendNo=" + LendNo + ", OverduedDate=" + OverduedDate + ", FineAmount="
				+ FineAmount + "]";
	} 
}
