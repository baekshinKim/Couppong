package com.cpn.coupon.model;

import java.sql.Timestamp;

public class couponVO {
	private int coupNo;//쿠폰번호
	private int ctgNo;//쿠폰 카테고리 번호
	private String coupName;//쿠폰 이름
	private int coupPrice;//쿠폰 가격
	private Timestamp coupStartDate;//쿠폰 시작일
	private Timestamp coupEndDate;//쿠폰 마감일
	private Timestamp coupRegDate;//쿠폰 등록일
	private String coupContent;//쿠폰 상세정보
	private String coupFileName;//쿠폰 파일명
	private String coupOriginalFileName;//쿠폰 원본파일명
	private double coupFileSize; //쿠폰 파일크기
	private int coupLikecnt; //쿠폰 조아용
	private int coupPurchase; //쿠폰구매횟수
	private int locNum; //지역 카테고리 번호
	private double latitude; //위도
	private double longitude; //경도
	private String address; //주소
	
	public couponVO() {
		
	}

	public couponVO(int coupNo, int ctgNo, String coupName, int coupPrice, Timestamp coupStartDate,
			Timestamp coupEndDate, Timestamp coupRegDate, String coupContent, String coupFileName,
			String coupOriginalFileName, int coupFileSize, int coupLikecnt, int coupPurchase, int locNum,
			double latitude, double longitude, String address) {
		this.coupNo = coupNo;
		this.ctgNo = ctgNo;
		this.coupName = coupName;
		this.coupPrice = coupPrice;
		this.coupStartDate = coupStartDate;
		this.coupEndDate = coupEndDate;
		this.coupRegDate = coupRegDate;
		this.coupContent = coupContent;
		this.coupFileName = coupFileName;
		this.coupOriginalFileName = coupOriginalFileName;
		this.coupFileSize = coupFileSize;
		this.coupLikecnt = coupLikecnt;
		this.coupPurchase = coupPurchase;
		this.locNum = locNum;
		this.latitude = latitude;
		this.longitude = longitude;
		this.address = address;
	}

	public int getCoupNo() {
		return coupNo;
	}

	public void setCoupNo(int coupNo) {
		this.coupNo = coupNo;
	}

	public int getCtgNo() {
		return ctgNo;
	}

	public void setCtgNo(int ctgNo) {
		this.ctgNo = ctgNo;
	}

	public String getCoupName() {
		return coupName;
	}

	public void setCoupName(String coupName) {
		this.coupName = coupName;
	}

	public int getCoupPrice() {
		return coupPrice;
	}

	public void setCoupPrice(int coupPrice) {
		this.coupPrice = coupPrice;
	}

	public Timestamp getCoupStartDate() {
		return coupStartDate;
	}

	public void setCoupStartDate(Timestamp coupStartDate) {
		this.coupStartDate = coupStartDate;
	}

	public Timestamp getCoupEndDate() {
		return coupEndDate;
	}

	public void setCoupEndDate(Timestamp coupEndDate) {
		this.coupEndDate = coupEndDate;
	}

	public Timestamp getCoupRegDate() {
		return coupRegDate;
	}

	public void setCoupRegDate(Timestamp coupRegDate) {
		this.coupRegDate = coupRegDate;
	}

	public String getCoupContent() {
		return coupContent;
	}

	public void setCoupContent(String coupContent) {
		this.coupContent = coupContent;
	}

	public String getCoupFileName() {
		return coupFileName;
	}

	public void setCoupFileName(String coupFileName) {
		this.coupFileName = coupFileName;
	}

	public String getCoupOriginalFileName() {
		return coupOriginalFileName;
	}

	public void setCoupOriginalFileName(String coupOriginalFileName) {
		this.coupOriginalFileName = coupOriginalFileName;
	}

	public double getCoupFileSize() {
		return coupFileSize;
	}

	public void setCoupFileSize(double coupFileSize) {
		this.coupFileSize = coupFileSize;
	}

	public int getCoupLikecnt() {
		return coupLikecnt;
	}

	public void setCoupLikecnt(int coupLikecnt) {
		this.coupLikecnt = coupLikecnt;
	}

	public int getCoupPurchase() {
		return coupPurchase;
	}

	public void setCoupPurchase(int coupPurchase) {
		this.coupPurchase = coupPurchase;
	}

	public int getLocNum() {
		return locNum;
	}

	public void setLocNum(int locNum) {
		this.locNum = locNum;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "couponVO [coupNo=" + coupNo + ", ctgNo=" + ctgNo + ", coupName=" + coupName + ", coupPrice=" + coupPrice
				+ ", coupStartDate=" + coupStartDate + ", coupEndDate=" + coupEndDate + ", coupRegDate=" + coupRegDate
				+ ", coupContent=" + coupContent + ", coupFileName=" + coupFileName + ", coupOriginalFileName="
				+ coupOriginalFileName + ", coupFileSize=" + coupFileSize + ", coupLikecnt=" + coupLikecnt
				+ ", coupPurchase=" + coupPurchase + ", locNum=" + locNum + ", latitude=" + latitude + ", longitude="
				+ longitude + ", address=" + address + "]";
	}
	
	
	
	
}
