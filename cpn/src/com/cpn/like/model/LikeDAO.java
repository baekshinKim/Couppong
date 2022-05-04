package com.cpn.like.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cpn.db.ConnectionPoolMgr2;

public class LikeDAO {
	private ConnectionPoolMgr2 pool;
	
	public LikeDAO() {
		this.pool= new ConnectionPoolMgr2();
	}
	
	//좋아요 누르면 등록되는 메서드
	public int insertLike(LikeVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql = "insert into LikeIndex(MemNo,  CoupNo)"
					+ " values(?,?) ";
			
			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getMemNo());
			ps.setInt(2, vo.getCoupNo());
			System.out.println(sql);
			
			int cnt=ps.executeUpdate();
			System.out.println("좋아요 입력 결과 cnt="+cnt+", 매개변수 vo="+vo);
			return cnt;
		
		}finally {
			pool.dbClose(ps, con);
		}	
	}
	
	
	//좋아요 취소 누르면 등록되는 메서드
	public int deleteLike(LikeVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql = "delete from LikeIndex where CoupNo=? and memNo=?";
			
			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getCoupNo());
			ps.setInt(2, vo.getMemNo());
			System.out.println(sql);
			
			int cnt=ps.executeUpdate();
			System.out.println("좋아요 삭제 결과 cnt="+cnt+", 매개변수 vo="+vo);
			return cnt;
		
		}finally {
			pool.dbClose(ps, con);
		}	
	}
	
	//관심등록인지 취소인지 확인하는 메소드 - true면 등록, false면 취소 , 매개변수 LikeVO vo
	public boolean isLike(LikeVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		boolean bool=false;
		try {
			con=pool.getConnection();
			
			String sql="select count(*) from likeindex where memno=? and coupNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getMemNo());
			ps.setInt(2, vo.getCoupNo());
			
			rs=ps.executeQuery();
			
			int idx=0;
			if(rs.next()) {
				idx=rs.getInt(1);
			}
			
			if(idx==0) {
				bool=true;
			}
		}finally {
			pool.dbClose(rs,ps, con);
		}
		
		System.out.println("관심등록or취소 확인 메소드 true : 등록  || false : 취소  || 결과 : "+bool);
		return bool;
	}
	
	public List<LikeVO> selectByMemNo(int memNo) throws SQLException{
		Connection con=null;
		PreparedStatement ps = null;
		ResultSet rs=null;
		
		List<LikeVO> list=new ArrayList<LikeVO>();
		try {
			
			con=pool.getConnection();
			
			String sql="select * from likeindex where memno=?";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, memNo);
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				LikeVO vo=new LikeVO();
				vo.setCoupNo(rs.getInt("coupNo"));
				vo.setMemNo(memNo);
				
				list.add(vo);
			}
			
			System.out.println("list.size="+list.size());
			return list;
		}finally {
			pool.dbClose(rs,ps, con);
		}
		
		
		
	}
}
