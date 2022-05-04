package com.cpn.comments.model;

import java.sql.Timestamp;

public class CommentsVO {
	private int reNo; //리뷰번호
	private String memId; //회원아이디	 
	private String reContents;//리뷰내용 
	private int coupNo;//쿠폰번호 
	
	
	public CommentsVO() {
		super();
	}


	public CommentsVO(int reNo, String memId, String reContents, int coupNo) {
		super();
		this.reNo = reNo;
		this.memId = memId;
		this.reContents = reContents;
		this.coupNo = coupNo;
	}


	public int getReNo() {
		return reNo;
	}


	public void setReNo(int reNo) {
		this.reNo = reNo;
	}


	public String getMemId() {
		return memId;
	}


	public void setMemId(String memId) {
		this.memId = memId;
	}


	public String getReContents() {
		return reContents;
	}


	public void setReContents(String reContents) {
		this.reContents = reContents;
	}


	public int getCoupNo() {
		return coupNo;
	}


	public void setCoupNo(int coupNo) {
		this.coupNo = coupNo;
	}


	@Override
	public String toString() {
		return "CommentsVO [reNo=" + reNo + ", memId=" + memId + ", reContents=" + reContents + ", coupNo=" + coupNo
				+ "]";
	}

	
}
	
