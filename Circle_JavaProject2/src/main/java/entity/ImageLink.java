package entity;

public class ImageLink {
	private int ImgNo;
	private int BookNo;
	private String Link;
	private Boolean IsCover;
	private Boolean Status;
	
	public ImageLink() {}
	
	public ImageLink(int imgNo, int bookNo, String link, Boolean isCover, Boolean status) {
		ImgNo = imgNo;
		BookNo = bookNo;
		Link = link;
		IsCover = isCover;
		Status = status;
	}

	public int getImgNo() {
		return ImgNo;
	}

	public void setImgNo(int imgNo) {
		ImgNo = imgNo;
	}

	public int getBookNo() {
		return BookNo;
	}

	public void setBookNo(int bookNo) {
		BookNo = bookNo;
	}

	public String getLink() {
		return Link;
	}

	public void setLink(String link) {
		Link = link;
	}

	public Boolean getIsCover() {
		return IsCover;
	}

	public void setIsCover(Boolean isCover) {
		IsCover = isCover;
	}

	public Boolean getStatus() {
		return Status;
	}

	public void setStatus(Boolean status) {
		Status = status;
	}

	@Override
	public String toString() {
		return "ImageLink [ImgNo=" + ImgNo + ", BookNo=" + BookNo + ", Link=" + Link + ", IsCover=" + IsCover
				+ ", Status=" + Status + "]";
	}
}
