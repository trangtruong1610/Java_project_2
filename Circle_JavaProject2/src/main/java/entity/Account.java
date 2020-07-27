package entity;

//import java.util.Date;

public class Account {
	private int AccountNo;
	private String AccountName;
	private String LibraryID;
	private String Password;
	private Boolean IsAdmin;
	private String DJoined;
	private String DExpired;
	private int Point;
	private Boolean Status;
	
	public Account() {}
	public Account(int accountNo) {
		AccountNo = accountNo;
	}
	
	public Account(String accountName, String libraryID) {
		AccountName = accountName;
		LibraryID = libraryID;
	}
	
	public Account(int accountNo, String accountName, String libraryID, String password, Boolean isAdmin, String dJoined,
			String dExpired, int point, Boolean status) {
		AccountNo = accountNo;
		AccountName = accountName;
		LibraryID = libraryID;
		Password = password;
		IsAdmin = isAdmin;
		DJoined = dJoined;
		DExpired = dExpired;
		Point = point;
		Status = status;
	}

	public int getAccountNo() {
		return AccountNo;
	}

	public void setAccountNo(int accountNo) {
		AccountNo = accountNo;
	}

	public String getAccountName() {
		return AccountName;
	}

	public void setAccountName(String accountName) {
		AccountName = accountName;
	}

	public String getLibraryID() {
		return LibraryID;
	}

	public void setLibraryID(String libraryID) {
		LibraryID = libraryID;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public Boolean getIsAdmin() {
		return IsAdmin;
	}

	public void setIsAdmin(Boolean isAdmin) {
		IsAdmin = isAdmin;
	}

	public String getDJoined() {
		return DJoined;
	}

	public void setDJoined(String dJoined) {
		DJoined = dJoined;
	}

	public String getDExpired() {
		return DExpired;
	}

	public void setDExpired(String dExpired) {
		DExpired = dExpired;
	}

	public int getPoint() {
		return Point;
	}

	public void setPoint(int point) {
		Point = point;
	}

	public Boolean getStatus() {
		return Status;
	}

	public void setStatus(Boolean status) {
		Status = status;
	}

	@Override
	public String toString() {
		return "Account [AccountNo=" + AccountNo + ", AccountName=" + AccountName + ", LibraryID=" + LibraryID
				+ ", Password=" + Password + ", IsAdmin=" + IsAdmin + ", DJoined=" + DJoined + ", DExpired=" + DExpired
				+ ", Point=" + Point + ", Status=" + Status + "]";
	}	
}
