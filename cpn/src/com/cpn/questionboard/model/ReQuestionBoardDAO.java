package com.cpn.questionboard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cpn.db.ConnectionPoolMgr2;


public class ReQuestionBoardDAO {
	private ConnectionPoolMgr2 pool;
		
	public ReQuestionBoardDAO() {
		pool=new ConnectionPoolMgr2();
	}
	
	public int insertReBoard(ReQuestionBoardVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2 con
			con=pool.getConnection();
			
			//3. ps
			String sql="insert into questionBoard(QboardNo,MemNo, QboardTitle, QboardContent,"
					+ " QBoardGroupNo,rigNo,qBoardPrivateFlag)"
					+ " values(SEQ_QBOARD.nextval,?,?,?,SEQ_QBOARD.nextval,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, vo.getMemNo());
			ps.setString(2, vo.getQBoardTitle());
			ps.setString(3, vo.getQBoardContent());
			ps.setInt(4, vo.getRigNo());
			ps.setString(5, vo.getQBoardPrivateFlag());
			
			//4. exec
			int cnt=ps.executeUpdate();
			System.out.println("글쓰기 결과 cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public List<ReQuestionBoardVO> selectAll(String condition, String keyword)
			throws SQLException{
		/*
		select * from questionBoard
		where title like '%안녕%';
		*/
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ReQuestionBoardVO> list=new ArrayList<ReQuestionBoardVO>();
		try {
			//1,2 con
			con=pool.getConnection();
			
			//3. ps
			String sql="select * from questionBoard ";
			if(keyword!=null && !keyword.isEmpty()) { //검색
				sql += " where "+ condition +" like '%' || ? || '%'";
			}
			sql += " order by qBoardNo desc";
			ps=con.prepareStatement(sql);
			
			if(keyword!=null && !keyword.isEmpty()) { //검색
				ps.setString(1, keyword);
			}
			
			//4. exec
			rs=ps.executeQuery();
			while(rs.next()) {
				int qBoardNo=rs.getInt("qBoardNo");
				int memNo=rs.getInt("memNo");
				String qBoardTitle=rs.getString("qBoardTitle");
				String  qBoardContent=rs.getString("qBoardContent");
				Timestamp  qBoardRegdate=rs.getTimestamp("qBoardRegdate");
				String qBoardRigReadFlag=rs.getString("qBoardRigReadFlag");
				int rigNo=rs.getInt("rigNo");
				int qBoardGroupNo=rs.getInt("qBoardGroupNo");
				int qBoardStep=rs.getInt("qBoardStep");
				String qBoardPrivateFlag=rs.getString("qBoardPrivateFlag");
				
				ReQuestionBoardVO vo = new ReQuestionBoardVO(qBoardNo,  memNo,  qBoardTitle, qBoardContent,  qBoardRegdate,
					 qBoardRigReadFlag, rigNo, qBoardGroupNo,  qBoardStep,  qBoardPrivateFlag);
				list.add(vo);
			}
			System.out.println("글목록 결과 list.size="+list.size()
				+", 매개변수 condition="+condition+", keyword="+keyword);
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public ReQuestionBoardVO selectByNo(int memNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		ReQuestionBoardVO vo = new ReQuestionBoardVO();
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select * from questionBoard where qBoardNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, memNo);
			
			//4
			rs=ps.executeQuery();
			if(rs.next()) {
				int qBoardNo=rs.getInt("qBoardNo");
				String qBoardTitle=rs.getString("qBoardTitle");
				String  qBoardContent=rs.getString("qBoardContent");
				Timestamp  qBoardRegdate=rs.getTimestamp("qBoardRegdate");
				String qBoardRigReadFlag=rs.getString("qBoardRigReadFlag");
				int rigNo=rs.getInt("rigNo");
				int qBoardGroupNo=rs.getInt("qBoardGroupNo");
				int qBoardStep=rs.getInt("qBoardStep");
				String qBoardPrivateFlag=rs.getString("qBoardPrivateFlag");
				
				vo.setQBoardNo(qBoardNo);
				vo.setQBoardTitle(qBoardTitle);
				vo.setQBoardContent(qBoardContent);
				vo.setQBoardRegdate(qBoardRegdate);
				vo.setQBoardRigReadFlag(qBoardRigReadFlag);
				vo.setRigNo(rigNo);
				vo.setQBoardGroupNo(qBoardGroupNo);
				vo.setQBoardStep(qBoardStep);
				vo.setQBoardPrivateFlag(qBoardPrivateFlag);
			}
			System.out.println("글 상세보기 결과 vo="+vo+", 매개변수 no="+memNo);
			
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	 public int updateReBoard(ReQuestionBoardVO vo) throws SQLException {
	      Connection con=null;
	      PreparedStatement ps=null;
	      
	      try {
	         //1,2
	         con=pool.getConnection();
	         
	         //3
	         String sql="update questionBoard" + 
	               " set qBoardTitle=?, qBoardTitle=?";
	         
	         //새로 파일 첨부한 경우만 파일정보 update
	         /*if(vo.getFileName()!=null && !vo.getFileName().isEmpty()) {
	            sql+=", fileName=?, filesize=?, originalFilename=?";
	         }
	         sql += " where no=?";*/
	        
	         ps=con.prepareStatement(sql);
	         
	         ps.setInt(1, vo.getQBoardGroupNo());
	         ps.setString(2, vo.getQBoardTitle());
	         ps.setString(3, vo.getQBoardContent());
	         
	        /* if(vo.getFileName()!=null && !vo.getFileName().isEmpty()) {
	            ps.setString(5, vo.getFileName());
	            ps.setLong(6, vo.getFileSize());
	            ps.setString(7, vo.getOriginalFileName());
	            ps.setInt(8, vo.getNo());
	         }else {*/
	            ps.setInt(4, vo.getMemNo());            
	         //}
	         
	         //4
	         int cnt=ps.executeUpdate();
	         System.out.println("글수정 결과, cnt="+cnt+", 매개변수 vo="+vo);
	         
	         return cnt;
	      }finally {
	         pool.dbClose(ps, con);
	      }
	   }
	
	 public int deleteReBoard(int QBoardNo) throws SQLException {
	      Connection con=null;
	      PreparedStatement ps=null;
	      
	      try {
	         //1,2
	         con=pool.getConnection();
	         
	         //3
	         String sql="delete from questionBoard where QBoardNo=?";
	         ps=con.prepareStatement(sql);
	         ps.setInt(1, QBoardNo);
	         
	         //4
	         int cnt=ps.executeUpdate();
	         System.out.println("글 삭제 결과, cnt="+cnt+", 매개변수 QBoardNo="+QBoardNo);
	         
	         return cnt;
	      }finally {
	         pool.dbClose(ps, con);
	      }
	   }
	 
	 public int reply(ReQuestionBoardVO vo) throws SQLException {
	      Connection con=null;
	      PreparedStatement ps=null;
	      
	      int cnt=0;
	      try {
	         //1,2
	         con=pool.getConnection();
	         
	         con.setAutoCommit(false);  //자동커밋이 안되도록 막는다
	         //트랜잭션 시작
	         
	         //3
	         String sql="update questionBoard" + 
	               " set QBoardNo=QBoardNo+1" + 
	               " where QBoardGroupNo=? and QBoardNo>?";
	         ps=con.prepareStatement(sql);
	         
	         ps.setInt(1, vo.getQBoardGroupNo());
	         ps.setInt(2, vo.getQBoardNo());
	         
	         //4
	         cnt=ps.executeUpdate();
	         
	         //[2] insert
	         String sql2="insert into questionBoard(QboardNo,MemNo, QboardTitle, QboardContent"
						+ " QboardRegdate + QBoardGroupNo + QBoardStep)"
						+ " values(SEQ_QBOARD.nextval,?,?,?,?,?,?)";
				ps=con.prepareStatement(sql2);
				
				ps.setInt(1, vo.getMemNo());
				ps.setString(2, vo.getQBoardTitle());
				ps.setString(3, vo.getQBoardContent());
				ps.setTimestamp(4, vo.getQBoardRegdate());
				ps.setInt(5, vo.getQBoardGroupNo());
				ps.setInt(6, vo.getQBoardStep());
				
	         cnt = ps.executeUpdate();
	         System.out.println("답변하기 결과, cnt="+cnt+", 매개변수 vo="
	            + vo);
	         
	         con.commit(); //트랙잭션 종료, 성공
	      }catch(SQLException e) {
	         con.rollback();  //트랜잭션 실패
	         e.printStackTrace();
	      }finally {
	         con.setAutoCommit(true);
	         pool.dbClose(ps, con);
	      }
	      
	      return cnt;
	   }
	 
	
}
