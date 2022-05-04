package com.cpn.location.model;

public class LocationVO {
	private int locNum;
	private String locName;
	
	public LocationVO() {
		
	}

	public LocationVO(int locNum, String locName) {
		this.locNum = locNum;
		this.locName = locName;
	}

	public int getLocNum() {
		return locNum;
	}

	public void setLocNum(int locNum) {
		this.locNum = locNum;
	}

	public String getLocName() {
		return locName;
	}

	public void setLocName(String locName) {
		this.locName = locName;
	}

	@Override
	public String toString() {
		return "LocationVO [locNum=" + locNum + ", locName=" + locName + "]";
	}
	
	
	
}
