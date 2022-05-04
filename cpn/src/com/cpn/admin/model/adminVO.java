package com.cpn.admin.model;

public class adminVO {
	private int adminNo;
	private String adminName;
	private String adminId;
	private String adminPwd;
	private int rigNo;
	
	
	public adminVO() {
		super();
	}

	public adminVO(int adminNo, String adminName, String adminId, String adminPwd, int rigNo) {
		super();
		this.adminNo = adminNo;
		this.adminName = adminName;
		this.adminId = adminId;
		this.adminPwd = adminPwd;
		this.rigNo = rigNo;
	}
	
	public int getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(int adminNo) {
		this.adminNo = adminNo;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPwd() {
		return adminPwd;
	}
	public void setAdminPwd(String adminPwd) {
		this.adminPwd = adminPwd;
	}
	public int getRigNo() {
		return rigNo;
	}
	public void setRigNo(int rigNo) {
		this.rigNo = rigNo;
	}

	@Override
	public String toString() {
		return "adminVO [adminNo=" + adminNo + ", adminName=" + adminName + ", adminId=" + adminId + ", adminPwd="
				+ adminPwd + ", rigNo=" + rigNo + "]";
	}
	
	
	
}
