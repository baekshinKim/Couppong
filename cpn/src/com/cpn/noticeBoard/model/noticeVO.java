package com.cpn.noticeBoard.model;

import java.sql.Timestamp;

public class noticeVO {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Timestamp noticeRegdate;
	private int noticeReadcount;
	private int rigNo;
	private int adminNo;
	
	
	
	public noticeVO() {
		super();
	}

	public noticeVO(int noticeNo, String noticeTitle, String noticeContent, Timestamp noticeRegdate,
			int noticeReadcount, int rigNo, int adminNo) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeRegdate = noticeRegdate;
		this.noticeReadcount = noticeReadcount;
		this.rigNo = rigNo;
		this.adminNo = adminNo;
	}
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public Timestamp getNoticeRegdate() {
		return noticeRegdate;
	}
	public void setNoticeRegdate(Timestamp noticeRegdate) {
		this.noticeRegdate = noticeRegdate;
	}
	public int getNoticeReadcount() {
		return noticeReadcount;
	}
	public void setNoticeReadcount(int noticeReadcount) {
		this.noticeReadcount = noticeReadcount;
	}
	public int getRigNo() {
		return rigNo;
	}
	public void setRigNo(int rigNo) {
		this.rigNo = rigNo;
	}
	public int getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(int adminNo) {
		this.adminNo = adminNo;
	}
	@Override
	public String toString() {
		return "noticeVO [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeRegdate=" + noticeRegdate + ", noticeReadcount=" + noticeReadcount + ", rigNo=" + rigNo
				+ ", adminNo=" + adminNo + "]";
	}
	
	
	
}
