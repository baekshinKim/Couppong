package com.cpn.admin.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cpn.common.util;
import com.cpn.db.ConnectionPoolMgr2;
import com.cpn.member.model.MemberService;

public class adminDAO {
	private ConnectionPoolMgr2 pool;
	
	public adminDAO() {
		pool=new ConnectionPoolMgr2();
	}
	
	public String selectNameByNo(int adminNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String adminName="";
		try {
			con=pool.getConnection();
			
			String sql="select adminName from admin\r\n" + 
					" where adminNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, adminNo);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				adminName=rs.getString(1);
			}
			return adminName;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public adminVO selectAdminByAdminId(String adminId) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		adminVO vo = new adminVO();
		try {
			con=pool.getConnection();
			
			String sql="select * from admin where adninId=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, adminId);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				int adminNo =rs.getInt("adminNo");
				String adminName =rs.getString("adminName");
				String adminPwd =rs.getString("adminPwd");
				int rigNo = rs.getInt("rigNo");
			
				vo.setAdminNo(adminNo);
				vo.setAdminName(adminName);
				vo.setAdminName(adminPwd);
				vo.setRigNo(rigNo);
			}
	
			System.out.println("[관리자 정보] 처리결과 vo="+vo+  
					 			"매개변수 관리자아이디=" + adminId );
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	
	//관리자로그인 체크
	// 로그인
		public int adminLoginCheck(String adminId, String adminPwd) throws SQLException {
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;

			int result = 0;
			try {
				con = pool.getConnection();
															//컬럼명 adnin임(admin으로 하면 익셉션)
				String sql = "select adminPwd from admin" + " where adninid=? and rigno=2";
														//관리자 아이디도 맞아야하고 , 권한번호가 2여야함
				ps = con.prepareStatement(sql);

				ps.setString(1, adminId);
				

				rs = ps.executeQuery();
				if (rs.next()) {
					String DBadminPwd= rs.getString(1);

					//관리자로그인 체크했는데 관리자가 아닌경우
					if(DBadminPwd == null || DBadminPwd.isEmpty()) {
						int rigNo=1;		//권한번호 1 (회원)
						boolean isAdmin = util.chkRig(rigNo);	
						
						if(!isAdmin){	//false면
							result = 0;//메서드 종료-> 돌아가서 권한없음 메세지 띄우기
						}
						
					//관리자로그인 체크했는데 관리자인 경우
					}else {

						if (DBadminPwd.equals(adminPwd)) {
							// 관리자인데 로그인성공
							result = MemberService.LOGIN_OK;//1
						} else {
							// 관리자인데 비번틀림
							result = MemberService.PWD_DISAGREE;	//3
						}//if:관리자인데 로그인정보 확인

					}//if:관리자인지 아닌지확인

				//아이디 없음
				} else {
					result = MemberService.ID_NONE;//2
				}

				System.out.println("[관리자 로그인] 0 관리자아님 | 1 관리자로그인 성공 | 2 아이디없음 | 3 관리자 비번확인");
				System.out.println("[관리자 로그인]처리결과  result =" + result 
						+ "매개변수 : 아이디" + adminId + ",비번" + adminPwd );
				return result;

			} finally {
				pool.dbClose(rs, ps, con);

			}

		}//

}
