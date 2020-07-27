package entity;

public class Notification {
	private int NotiNo;
	private String NotiSubject;
	private String NotiContent;
	
	public Notification() {}
	
	public Notification(int notiNo, String notiSubject, String notiContent) {
		NotiNo = notiNo;
		NotiSubject = notiSubject;
		NotiContent = notiContent;
	}

	public int getNotiNo() {
		return NotiNo;
	}

	public void setNotiNo(int notiNo) {
		NotiNo = notiNo;
	}

	public String getNotiSubject() {
		return NotiSubject;
	}

	public void setNotiSubject(String notiSubject) {
		NotiSubject = notiSubject;
	}

	public String getNotiContent() {
		return NotiContent;
	}

	public void setNotiContent(String notiContent) {
		NotiContent = notiContent;
	}

	@Override
	public String toString() {
		return "Notification [NotiNo=" + NotiNo + ", NotiSubject=" + NotiSubject + ", NotiContent=" + NotiContent + "]";
	}
}
