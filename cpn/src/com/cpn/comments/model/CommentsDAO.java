package com.cpn.comments.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cpn.db.ConnectionPoolMgr2;


public class CommentsDAO {
	private ConnectionPoolMgr2 pool;
	
	public CommentsDAO(){
		pool=new ConnectionPoolMgr2();
	}
	
	public List<CommentsVO> selectByCoupNo(int CoupNo) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<CommentsVO> list=new ArrayList<CommentsVO>();
		try {
			con=pool.getConnection();
			
			String sql="select * from review"
					+ " where coupno=?"
					+ " order by reNo desc";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, CoupNo);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				String memId=rs.getString("memId");
				String reContents=rs.getString("reContents");
				int coupNo=rs.getInt("coupNo");
				
				
				CommentsVO vo=new CommentsVO();
				vo.setMemId(memId);
				vo.setReContents(reContents);
				vo.setCoupNo(coupNo);
				vo.setReNo(rs.getInt("reNo"));
				list.add(vo);
			}
			
			System.out.println("댓글 조회 결과 list.size()="+list.size());
			
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int insertComments(CommentsVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		int cnt=0;
		try {
			con=pool.getConnection();
			
			String sql="insert into review(reNo, memId, reContents, coupNo)"
					+ " values(SEQ_REVIEW.nextVal, ?, ?, ?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getMemId());
			ps.setString(2, vo.getReContents());
			ps.setInt(3, vo.getCoupNo());
			
			cnt=ps.executeUpdate();
			
			System.out.println("댓글 입력 결과 cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int selectCommentsCnt(int CoupNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		int count=0;
		try {
			con=pool.getConnection();
			
			String sql="select count(*) from review"
					+ " where coupno=?";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, CoupNo);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
			System.out.println("코멘트 조회 수 count="+count+", 매개변수 ReNo="+CoupNo);
			
			return count;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	/*
	 * public List<CommentsVO> selectAll(String condition, String keyword) throws
	 * SQLException{
	 * 
	 * Connection con=null; PreparedStatement ps=null; ResultSet rs=null;
	 * 
	 * List<CommentsVO> list=new ArrayList<CommentsVO>(); try { //1,2 con
	 * con=pool.getConnection();
	 * 
	 * //3 ps String sql="select * from Review "; if(keyword!=null &&
	 * !keyword.isEmpty()) { sql+=" where "+condition+" like '%' || ? || '%' "; }
	 * sql+="order by CoupNo desc";
	 * 
	 * ps=con.prepareStatement(sql);
	 * 
	 * if(keyword!=null && !keyword.isEmpty()) { ps.setString(1, keyword);; }
	 * rs=ps.executeQuery();
	 * 
	 * while(rs.next()) { int CoupNo=rs.getInt("CoupNo"); String
	 * reContents=rs.getString("reContents"); Timestamp
	 * noticeRegdate=rs.getTimestamp(4); int
	 * noticeReadCount=rs.getInt("noticeReadCount"); int ReNo=rs.getInt("ReNo"); int
	 * memId=rs.getInt("memId"); CommentsVO vo= new CommentsVO(); list.add(vo); }
	 * System.out.println("글 전체목록 결과 list.size="+list.size()
	 * +", 매개변수 condition="+condition+", keyword="+keyword); return list;
	 * 
	 * }finally { pool.dbClose(rs,ps,con); } }
	 */
}
