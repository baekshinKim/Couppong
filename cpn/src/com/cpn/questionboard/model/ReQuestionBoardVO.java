package com.cpn.questionboard.model;

import java.sql.Timestamp;

public class ReQuestionBoardVO {
	
	private int QBoardNo;
	private int MemNo; /* 회원번호 */
	private String QBoardTitle; /* 일대일게시글 제목 */
	private String QBoardContent; /* 일대일게시글 내용 */
	private Timestamp QBoardRegdate; /* 일대일게시글 등록일 */
	private String QBoardRigReadFlag; /* 관리자조회여부플래그 */
	private int rigNo; /* 권한번호 */
	private int QBoardGroupNo; /* 답변글번호 */
	private int QBoardStep;  /* 글순서 */
	private String QBoardPrivateFlag; /* 비공개플래그 */
	
	public ReQuestionBoardVO(){
		super();
	}
	
	public ReQuestionBoardVO(int qBoardNo, int memNo, String qBoardTitle, String qBoardContent, Timestamp qBoardRegdate,
			String qBoardRigReadFlag, int rigNo, int qBoardGroupNo, int qBoardStep, String qBoardPrivateFlag) {
		super();
		this.QBoardNo = qBoardNo;
		this.MemNo = memNo;
		this.QBoardTitle = qBoardTitle;
		this.QBoardContent = qBoardContent;
		this.QBoardRegdate = qBoardRegdate;
		this.QBoardRigReadFlag = qBoardRigReadFlag;
		this.rigNo = rigNo;
		this.QBoardGroupNo = qBoardGroupNo;
		this.QBoardStep = qBoardStep;
		this.QBoardPrivateFlag = qBoardPrivateFlag;
	}
	
	public int getQBoardNo() {
		return QBoardNo;
	}


	public void setQBoardNo(int qBoardNo) {
		QBoardNo = qBoardNo;
	}

	public int getMemNo() {
		return MemNo;
	}

	public void setMemNo(int memNo) {
		MemNo = memNo;
	}

	public String getQBoardTitle() {
		return QBoardTitle;
	}

	public void setQBoardTitle(String qBoardTitle) {
		QBoardTitle = qBoardTitle;
	}

	public String getQBoardContent() {
		return QBoardContent;
	}

	public void setQBoardContent(String qBoardContent) {
		QBoardContent = qBoardContent;
	}

	public Timestamp getQBoardRegdate() {
		return QBoardRegdate;
	}

	public void setQBoardRegdate(Timestamp qBoardRegdate) {
		QBoardRegdate = qBoardRegdate;
	}

	public String getQBoardRigReadFlag() {
		return QBoardRigReadFlag;
	}

	public void setQBoardRigReadFlag(String qBoardRigReadFlag) {
		QBoardRigReadFlag = qBoardRigReadFlag;
	}

	public int getRigNo() {
		return rigNo;
	}

	public void setRigNo(int rigNo) {
		this.rigNo = rigNo;
	}

	public int getQBoardGroupNo() {
		return QBoardGroupNo;
	}

	public void setQBoardGroupNo(int qBoardGroupNo) {
		QBoardGroupNo = qBoardGroupNo;
	}

	public int getQBoardStep() {
		return QBoardStep;
	}

	public void setQBoardStep(int qBoardStep) {
		QBoardStep = qBoardStep;
	}

	public String getQBoardPrivateFlag() {
		return QBoardPrivateFlag;
	}

	public void setQBoardPrivateFlag(String qBoardPrivateFlag) {
		QBoardPrivateFlag = qBoardPrivateFlag;
	}

	@Override
	public String toString() {
		return "QuestionBoardVO [QBoardNo=" + QBoardNo + ", MemNo=" + MemNo + ", QBoardTitle=" + QBoardTitle
				+ ", QBoardContent=" + QBoardContent + ", QBoardRegdate=" + QBoardRegdate + ", QBoardRigReadFlag="
				+ QBoardRigReadFlag + ", rigNo=" + rigNo + ", QBoardGroupNo=" + QBoardGroupNo + ", QBoardStep="
				+ QBoardStep + ", QBoardPrivateFlag=" + QBoardPrivateFlag + "]";
	}
	
}
