package com.cpn.member.model;

import java.sql.Timestamp;

public class MemberVO {
	private int memNo; 			//NUMBER NOT NULL, /* 회원번호 */
	private String memId; 		//VARCHAR(100) NOT NULL UNIQUE, /* 회원아이디 */
	private String memName; 	//VARCHAR2(100) NOT NULL, /* 회원이름 */
	private String memPwd; 		//VARCHAR2(100) NOT NULL, /* 비밀번호 */
	private String memEmail; 	//VARCHAR2(100), /* 이메일 */
	private String memTel; 		//VARCHAR2(100), /* 전화번호 */
	private String memAddress; 	//VARCHAR2(100), /* 주소 */
	private Timestamp memRegdate;	// DATE default trunc(sysdate), /* 가입일 */
	private Timestamp memOutdate;	// DATE /* 탈퇴일 */
	private int rigNo; 				//NUMBER NOT NULL /* 권한번호 */
	//회원 권한번호 -> default값 넣기 
	
	
	
	public MemberVO() {
		super();
	}

	public MemberVO(int memNo, String memId, String memName, String memPwd, String memEmail, String memTel,
			String memAddress, Timestamp memRegdate, Timestamp memOutdate, int rigNo) {
		super();
		this.memNo = memNo;
		this.memId = memId;
		this.memName = memName;
		this.memPwd = memPwd;
		this.memEmail = memEmail;
		this.memTel = memTel;
		this.memAddress = memAddress;
		this.memRegdate = memRegdate;
		this.memOutdate = memOutdate;
		this.rigNo = rigNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemPwd() {
		return memPwd;
	}

	public void setMemPwd(String memPwd) {
		this.memPwd = memPwd;
	}

	public String getMemEmail() {
		return memEmail;
	}

	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}

	public String getMemTel() {
		return memTel;
	}

	public void setMemTel(String memTel) {
		this.memTel = memTel;
	}

	public String getMemAddress() {
		return memAddress;
	}

	public void setMemAddress(String memAddress) {
		this.memAddress = memAddress;
	}

	public Timestamp getMemRegdate() {
		return memRegdate;
	}

	public void setMemRegdate(Timestamp memRegdate) {
		this.memRegdate = memRegdate;
	}

	public Timestamp getMemOutdate() {
		return memOutdate;
	}

	public void setMemOutdate(Timestamp memOutdate) {
		this.memOutdate = memOutdate;
	}

	public int getRigNo() {
		return rigNo;
	}

	public void setRigNo(int rigNo) {
		this.rigNo = rigNo;
	}

	@Override
	public String toString() {
		return "MemberVO [memNo=" + memNo + ", memId=" + memId + ", memName=" + memName + ", memPwd=" + memPwd
				+ ", memEmail=" + memEmail + ", memTel=" + memTel + ", memAddress=" + memAddress + ", memRegdate="
				+ memRegdate + ", memOutdate=" + memOutdate + ", rigNo=" + rigNo + "]";
	}
    
	
	
	
	
}
