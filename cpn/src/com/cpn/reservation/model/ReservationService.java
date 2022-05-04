package com.cpn.reservation.model;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class ReservationService {
	private ReservationDAO reserveDao;

	public ReservationService() {
		super();
		this.reserveDao=new ReservationDAO();
	}

	//1.예약하면 예약목록에 등록되는 메서드
	public int insertReservation(ReservationVO vo) throws SQLException {
		return reserveDao.insertReservation(vo);
	}


	//2. 예약 1건 조회
	public ReservationVO selectReserveByMemNo(int memNo,int reserveNo) throws SQLException {
		return reserveDao.selectReserveByMemNo(memNo, reserveNo);
	}
	
	//마이페이지에서 검색
	//3.내 예약목록 검색 - 회원번호로 조회(회원별 예약목록) : 마이페이지의 예약목록가져오기
	public List<ReservationVO> selectMyReserve(int memNo) throws SQLException {
		return reserveDao.selectMyReserve(memNo);
	} 
	
	// 4. 취소 가능한 예약인지 확인 ->  쿠폰번호, 현재일시 넣으면 사용시작일/종료일과 현재날짜 비교하여 취소가능여부 판단 
	public boolean isRevocableReserve(int coupNo, Timestamp curTime) throws SQLException {
		//true면 취소가능
		return reserveDao.isRevocableReserve(coupNo, curTime);
	}
	
	//5.예약취소하는 메서드
	public int deleteReserve(int reserveNo) throws SQLException {
		return reserveDao.deleteReserve(reserveNo);
	}	
	
}
