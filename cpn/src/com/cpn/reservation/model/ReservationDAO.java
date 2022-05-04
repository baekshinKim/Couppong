package com.cpn.reservation.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cpn.coupon.model.couponDAO;
import com.cpn.coupon.model.couponVO;
import com.cpn.db.ConnectionPoolMgr2;

public class ReservationDAO {
	private ConnectionPoolMgr2 pool;

	//생성자에서 커넥션객체 생성
	public ReservationDAO() {
		this.pool = new ConnectionPoolMgr2();
	}


	//1.예약하면 예약목록에 등록되는 메서드
	public int insertReservation(ReservationVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			con=pool.getConnection();

			String sql = "insert into Reservation ( ReserveNo, CoupNo, MemNo,ReservePrice,ReservePer)"
					+ " values ( SEQ_RESERV.nextval, ?,?,?,?) ";

			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getCoupNo());
			ps.setInt(2, vo.getMemNo());
			ps.setInt(3, vo.getReservePrice());
			ps.setInt(4, vo.getReservePer());
			System.out.println(sql);

			int cnt=ps.executeUpdate();
			System.out.println("예약 입력 결과 cnt="+cnt+", 매개변수 vo="+vo);
			return cnt;

		}finally {
			pool.dbClose(ps, con);
		}

	}

	//2. 예약 1건 조회
	public ReservationVO selectReserveByMemNo(int memNo,int reserveNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps= null;
		ResultSet rs = null;

		ReservationVO vo = new ReservationVO();
		try {
			con=pool.getConnection();

			String sql="select * from reservation where memNo=? and reserveNo=?";
			ps= con.prepareStatement(sql);
			ps.setInt(1, memNo);
			ps.setInt(2, reserveNo);

			rs=ps.executeQuery();
			while(rs.next()) {
				//reserveNo는 매개변수
				vo.setCoupNo(rs.getInt("coupNo"));
				//memNo는 매개변수
				vo.setReserveRegdate(rs.getTimestamp("reserveRegdate"));
				vo.setReservePrice(rs.getInt("reservePrice"));
				vo.setReservePer(rs.getInt("reservePer"));

			}//w

			System.out.println("예약번호로 조회");
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}		
	}


	//마이페이지에서 검색
	//3.내 예약목록 검색 - 회원번호로 조회(회원별 예약목록) : 마이페이지의 예약목록가져오기
	public List<ReservationVO> selectMyReserve(int memNo) throws SQLException { 
		Connection con=null;
		PreparedStatement ps=null; 
		ResultSet rs=null;

		List<ReservationVO> reserveList = new ArrayList<ReservationVO>();
		try {
			con=pool.getConnection();

			String sql="select * from Reservation where memno=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, memNo);

			rs=ps.executeQuery();
			while (rs.next()) {
				ReservationVO vo = new ReservationVO();
				vo.setReserveNo(rs.getInt("reserveNo"));
				vo.setCoupNo(rs.getInt("coupNo"));
				vo.setMemNo(rs.getInt("MemNo"));
				vo.setReserveRegdate(rs.getTimestamp("reserveRegdate"));
				vo.setReservePrice(rs.getInt("reservePrice"));
				vo.setReservePer(rs.getInt("reservePer"));

				reserveList.add(vo);

			}
			System.out.println("myReserve리스트전체 : reserveList.size()="+reserveList.size());

			return reserveList;
		} finally {
			pool.dbClose(rs, ps, con);


		}


	}


	// 4. 취소 가능한 예약인지 확인하기 위해 ->  쿠폰번호, 현재일시 넣으면 사용시작일/종료일과 현재날짜 비교하여 취소가능여부 판단 
	public boolean isRevocableReserve(int coupNo, Timestamp curTime) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;


		couponDAO coupDao = new couponDAO();
		couponVO coupVo = new couponVO();
		try {
			con = pool.getConnection();

			coupVo = coupDao.selectByNo(coupNo);	//쿠폰번호로 
			Timestamp useStart = coupVo.getCoupStartDate();	//시작날짜 
			Timestamp useEnd = coupVo.getCoupEndDate();	// 종료날짜

			//시작날짜가 현재보다 늦어야함 
			//boolean isStartReserve = useStart.before(curTime);	//true면 사용가능/사용예정 -> 취소가능
			boolean isCurReserve = curTime.before(useStart);	//true면 현재사용가능-> 취소 가능

			//boolean isEndReserve = useEnd.after(curTime);	//false면 사용불가능 -> 취소 불가능

			boolean result = false;

			/*if(isStartReserve){ //true면 사용가능/사용예정 -> 취소가능
				System.out.println("사용 예정 쿠폰, 취소가능");
				result = true;*/
			if(isCurReserve) {
				System.out.println("현재 사용가능한 쿠폰 , 취소가능");
				result = true;

			} /*
				 * else if(isEndReserve) { //true면 사용불가능 -> 취소 불가능
				 * System.out.println("사용기한 종료된 쿠폰, 취소 불가능"); result = false; }
				 */
			return result;

		}finally {
			pool.dbClose(ps, con);

		}


		//		 Timestamp ts1 = Timestamp.valueOf("2020-09-01 09:01:15");//ts1이 before면 true를 리턴  
		//	      Timestamp ts2 = Timestamp.valueOf("2020-09-01 09:01:16"); //매개변수 ts2가 나중이면 true를 리턴(기한남았으면)
		//	        														  //매개변수 ts2가 이전이면 false를 리턴(기한지났으면)
	}


	//5.예약취소하는 메서드
	public int deleteReserve(int reserveNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con=pool.getConnection();
			String sql = "delete from Reservation where reserveNo=?";
			ps=con.prepareStatement(sql);

			ps.setInt(1, reserveNo);
			int cnt = ps.executeUpdate();
			if(cnt>0){
				System.out.println("예약번호"+reserveNo+"번 삭제성공!");		
			}
			return cnt;

		} finally {
			pool.dbClose(ps, con);

		}


	}


	//7.내 예약중 사용불가(취소건) 검색 : 사용기한에 오늘날짜가 포함되는 예약건



	//7.내 예약중 현재 사용가능한 예약 검색 : 사용기한에 오늘날짜가 포함되는 예약건
	// selectMyReserve(int memNo) 중에서 


	//7.내 예약중 사용예정 검색 : 사용기한이 오늘을 포함하지 않고 내일이후인 예약건

	//7.내 예약중 사용불가(기한지남) 검색 : 사용기한이 오늘을 포함하지 않고 어제까지 내 예약건

	//8.예약검색 - 사용 불가능한 예약건 조회 : : 사용기한에 오늘날짜가 포함되지 않는 예약건




	//관리자가 검색
	//6.예약검색 - 쿠폰번호로 조회(쿠폰별 예약목록) : 관리자 페이지에서 조회 (쿠폰별 예약목록 조회)



}
