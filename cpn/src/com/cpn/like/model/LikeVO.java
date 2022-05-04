package com.cpn.like.model;

public class LikeVO {
	private int MemNo;  /* 회원번호 */
	private int CoupNo;  /* 쿠폰번호 */
	
	public LikeVO() {
		super();
	}
	
	public LikeVO(int MemNo, int CoupNo) {
		super();
		this.MemNo=MemNo;
		this.CoupNo=CoupNo;
	}
	
	
	public int getMemNo() {
		return MemNo;
	}

	public void setMemNo(int memNo) {
		MemNo = memNo;
	}

	public int getCoupNo() {
		return CoupNo;
	}

	public void setCoupNo(int coupNo) {
		CoupNo = coupNo;
	}


	@Override
	public String toString() {
		return "LikeDTO [MemNo=" + MemNo + ", CoupNo=" + CoupNo + "]";
	}
	
}
