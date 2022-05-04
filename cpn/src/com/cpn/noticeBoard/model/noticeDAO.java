package com.cpn.noticeBoard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cpn.db.ConnectionPoolMgr2;

public class noticeDAO {
	ConnectionPoolMgr2 pool;

	public noticeDAO() {
		pool=new ConnectionPoolMgr2();
	}

	public int insertNotice(noticeVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			con=pool.getConnection();

			String sql="insert into noticeboard(noticeno,noticetitle,noticecontent,rigno,adminno)\r\n" + 
					" values(SEQ_NOTICE.nextval,?,?,2,?)";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getNoticeTitle());
			ps.setString(2, vo.getNoticeContent());
			ps.setInt(3, vo.getAdminNo());

			int cnt=ps.executeUpdate();
			System.out.println("cnt="+cnt+", vo="+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	public List<noticeVO> selectAll(String condition, String keyword) throws SQLException{ 


		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;

		List<noticeVO> list=new ArrayList<noticeVO>();
		try {
			//1,2 con
			con=pool.getConnection();

			//3 ps
			String sql="select * from noticeBoard ";
			if(keyword!=null && !keyword.isEmpty()) {
				sql+=" where "+condition+" like '%' || ? || '%' ";
			}
			sql+="order by noticeNo desc";

			ps=con.prepareStatement(sql);

			if(keyword!=null && !keyword.isEmpty()) {
				ps.setString(1, keyword);;
			}
			rs=ps.executeQuery();

			while(rs.next()) {
				int noticeNo=rs.getInt("noticeNo");
				String noticeTitle=rs.getString("noticeTitle");
				String noticeContent=rs.getString("noticeContent");
				Timestamp noticeRegdate=rs.getTimestamp(4);
				int noticeReadCount=rs.getInt("noticeReadCount");
				int rigNo=rs.getInt("rigNo");
				int adminNo=rs.getInt("adminNo");
				noticeVO vo=new noticeVO(noticeNo,noticeTitle,noticeContent,noticeRegdate,noticeReadCount,rigNo,adminNo);
				list.add(vo);
			}
			System.out.println("글 전체목록 결과 list.size="+list.size()
			+", 매개변수 condition="+condition+", keyword="+keyword);
			return list;

		}finally {
			pool.dbClose(rs,ps,con);
		}
	}
	
	public int updateCount(int noticeNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="update noticeboard\r\n" + 
					"set noticereadcount=noticereadcount+1\r\n" + 
					"where noticeNo=?";
			ps=con.prepareCall(sql);
			ps.setInt(1, noticeNo);
			
			int cnt=ps.executeUpdate();
			System.out.println("조회수 증가 결과 cnt="+cnt+", noticeNo="+noticeNo);
			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}
	}
	
	public noticeVO selectByNo(int noticeNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		noticeVO vo=null;
		try {
			con=pool.getConnection();
			
			String sql="select * from noticeboard \r\n" + 
					" where noticeNo=?";
			
			ps=con.prepareStatement(sql);
			ps.setInt(1, noticeNo);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				String noticeTitle=rs.getString("noticeTitle");
				String noticeContent=rs.getString("noticeContent");
				Timestamp noticeRegdate=rs.getTimestamp(4);
				int noticeReadCount=rs.getInt("noticeReadCount");
				int rigNo=rs.getInt("rigNo");
				int adminNo=rs.getInt("adminNo");
				vo=new noticeVO(noticeNo,noticeTitle,noticeContent,noticeRegdate,noticeReadCount,rigNo,adminNo);

			}
			
			System.out.println("vo="+vo+", noticeNo="+noticeNo);
			return vo;
		
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int updateNotice(noticeVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="update noticeboard\r\n" + 
					"set noticeTitle=?,noticeContent=?,adminNo=?\r\n" + 
					"where noticeNo=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getNoticeTitle());
			ps.setString(2, vo.getNoticeContent());
			ps.setInt(3, vo.getAdminNo());
			ps.setInt(4, vo.getNoticeNo());
			
			int cnt=ps.executeUpdate();
			System.out.println("수정 cnt="+cnt+", vo="+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int deleteNotice(int noticeNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try{
			con=pool.getConnection();
			
			String sql="delete from noticeboard where noticeNo=?";
			
			ps=con.prepareStatement(sql);
			ps.setInt(1, noticeNo);
			
			int cnt=ps.executeUpdate();
			
			System.out.println("공지사항 삭제결과 cnt="+cnt+", 매개변수 noticeNo="+noticeNo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
