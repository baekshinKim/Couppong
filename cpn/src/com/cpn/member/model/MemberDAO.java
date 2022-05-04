package com.cpn.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.cpn.db.ConnectionPoolMgr2;

public class MemberDAO {
	private ConnectionPoolMgr2 pool;

	public MemberDAO() {
		pool = new ConnectionPoolMgr2();
	}

	public int insertMember(MemberVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			// 1,2
			con = pool.getConnection();

			// 3
			String sql = "insert into member(memno, memid, memname, mempwd," + " mememail, memtel, memaddress,rigNo)"
					+ "values(SEQ_MEMBER.nextval, ?,?,?, ?, ?,?,1)";
			ps = con.prepareStatement(sql);

			ps.setString(1, vo.getMemId());
			ps.setString(2, vo.getMemName());
			ps.setString(3, vo.getMemPwd());
			ps.setString(4, vo.getMemEmail());
			ps.setString(5, vo.getMemTel());
			ps.setString(6, vo.getMemAddress());

			// 4
			int cnt = ps.executeUpdate();
			System.out.println("회원가입 결과, cnt=" + cnt + ", 매개변수 vo=" + vo);

			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}
	}

	// 아이지중복확인
	public int checkDup(String memid) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int result = 0;
		try {
			con = pool.getConnection();

			String sql = "select count(*) from member" + " where memid=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, memid);

			rs = ps.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1);
				if (count > 0) {
					result = MemberService.EXIST_ID; // 이미 존재
				} else {
					result = MemberService.NON_EXIST_ID;
					// 0개 -> 없음 -> 사용가능한 아이디
				}
			} // if

			System.out.println("아이디 DB에서 중복확인 결과, result=" + result + ", 매개변수 memid=" + memid);

			return result;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}

	// 로그인
	public int loginCheck(String userid, String pwd) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int result = 0;
		try {
			con = pool.getConnection();

			String sql = "select mempwd from member" + " where memid=? and memoutdate is null";
			ps = con.prepareStatement(sql);

			ps.setString(1, userid);

			rs = ps.executeQuery();
			if (rs.next()) {
				String dbPwd = rs.getString(1);

				if (dbPwd.equals(pwd)) {
					// 로그인성공여부
					result = MemberService.LOGIN_OK;
				} else {
					// 비번일치여부
					result = MemberService.PWD_DISAGREE;
				}

				// 아이디가 없는 경우 ->밖에다 else
			} else {
				result = MemberService.ID_NONE;
			}

			System.out.println("로그인처리결과  result =" + result + "매개변수 : 아이디" + userid + ",비번" + pwd);
			return result;

		} finally {
			pool.dbClose(rs, ps, con);

		}

	}//

	// 회원정보가져오기
	public MemberVO selectMember(String memid) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		MemberVO vo = new MemberVO();
		try {
			con = pool.getConnection();

			String sql = "select * from member  where memid=?";
			ps = con.prepareStatement(sql);

			ps.setString(1, memid);

			rs = ps.executeQuery();
			if (rs.next()) {
				int memNo = rs.getInt("memNo");
				// 아이디는 매개변수로 받음
				String memName = rs.getString("memName");
				String memPwd = rs.getString("memPwd");

				String memEmail = rs.getString("memEmail");
				String memTel = rs.getString("MemTel");

				String memAddress = rs.getString("MemAddress");
				Timestamp memRegdate = rs.getTimestamp("MemRegdate");
				Timestamp memOutdate = rs.getTimestamp("MemOutdate");
				int rigNo = rs.getInt("rigNo");

				// vo에 세팅
				vo.setMemNo(memNo);
				vo.setMemId(memid);
				vo.setMemName(memName);
				vo.setMemPwd(memPwd);

				vo.setMemEmail(memEmail);
				vo.setMemTel(memTel);

				vo.setMemAddress(memAddress);

				vo.setMemRegdate(memRegdate);
				vo.setMemOutdate(memOutdate);
				vo.setRigNo(rigNo);

			}

			System.out.println("조회결과 userid=" + memid + "의 사용자정보 vo:" + vo);
			return vo;
		} finally {
			pool.dbClose(rs, ps, con);

		}
	}

	
	public int updateMember(MemberVO vo) throws SQLException { Connection
		con=null; PreparedStatement ps=null;

		try { con=pool.getConnection();

		String sql ="update member"
				+ " set memEmail =?, memTel =?, memAddress=?"
				+ " where memid=?";
		ps=con.prepareStatement(sql);

		ps.setString(1, vo.getMemEmail()); 
		ps.setString(2, vo.getMemTel()); 
		ps.setString(3,	vo.getMemAddress()); 
		ps.setString(4, vo.getMemId()); 


			int cnt = ps.executeUpdate();
				System.out.println("회원수정결과 cnt="+cnt+", 매개변수 vo ="+vo); return cnt; }finally
		{ pool.dbClose(ps, con);

		}

	}
	 

	// 탈퇴
	public int withdrawMember(String memid) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "update member set memoutdate=sysdate" + " where memid=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, memid);

			int cnt = ps.executeUpdate();
			System.out.println("회원 탈퇴 결과(1이면 outdate들어간거임) cnt=" + cnt + ", 매개변수 userid =" + memid);
			return cnt;
		} finally {
			pool.dbClose(ps, con);

		}

	}
	
	public String selectNameByNo(int memNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		ResultSet rs=null;
		
		String memid="";
		try {
			con=pool.getConnection();
			
			String sql="select memid from member where memNo=?";
			
			ps=con.prepareStatement(sql);
			ps.setInt(1, memNo);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				memid=rs.getString(1);
			}
			
			System.out.println("회원번호로 조회 결과 memid="+memid);
			return memid;
		}finally {
			pool.dbClose(rs,ps, con);
		}
	}

}
