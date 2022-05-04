package com.cpn.coupCategory.model;

public class CoupCategoryVO {
	private int ctgNo;
	private String ctgName;
	
	public CoupCategoryVO() {
		super();
	}

	public int getCtgNo() {
		return ctgNo;
	}

	public void setCtgNo(int ctgNo) {
		this.ctgNo = ctgNo;
	}

	public String getCtgName() {
		return ctgName;
	}

	public void setCtgName(String ctgName) {
		this.ctgName = ctgName;
	}

	@Override
	public String toString() {
		return "CoupCategoryVO [ctgNo=" + ctgNo + ", ctgName=" + ctgName + "]";
	}
	
	
}
