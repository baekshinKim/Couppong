package com.cpn.reservation.model;

import java.sql.Timestamp;

public class ReservationVO {
	private int reserveNo;		// number not null, /* 예약번호 */
	private int coupNo;			// number not null, /* 쿠폰번호 */
	private int memNo;			// number not null, /* 회원번호 */
	private Timestamp reserveRegdate;	// date default trunc(sysdate), /* 예약일자 */
	private int reservePrice;	// number not null,/* 총액 */
	private int reservePer;		// number not null/* 사용인원 */

	public ReservationVO() {
		super();
	}
	
	public ReservationVO(int reserveNo, int coupNo, int memNo, Timestamp reserveRegdate, int reservePrice,
			int reservePer) {
		super();
		this.reserveNo = reserveNo;
		this.coupNo = coupNo;
		this.memNo = memNo;
		this.reserveRegdate = reserveRegdate;
		this.reservePrice = reservePrice;
		this.reservePer = reservePer;
	}

	public int getReserveNo() {
		return reserveNo;
	}

	public void setReserveNo(int reserveNo) {
		this.reserveNo = reserveNo;
	}

	public int getCoupNo() {
		return coupNo;
	}

	public void setCoupNo(int coupNo) {
		this.coupNo = coupNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public Timestamp getReserveRegdate() {
		return reserveRegdate;
	}

	public void setReserveRegdate(Timestamp reserveRegdate) {
		this.reserveRegdate = reserveRegdate;
	}

	public int getReservePrice() {
		return reservePrice;
	}

	public void setReservePrice(int reservePrice) {
		this.reservePrice = reservePrice;
	}

	public int getReservePer() {
		return reservePer;
	}

	public void setReservePer(int reservePer) {
		this.reservePer = reservePer;
	}

	@Override
	public String toString() {
		return "ReservationVO [reserveNo=" + reserveNo + ", coupNo=" + coupNo + ", memNo=" + memNo + ", reserveRegdate="
				+ reserveRegdate + ", reservePrice=" + reservePrice + ", reservePer=" + reservePer + "]";
	}
	
	
	
}
