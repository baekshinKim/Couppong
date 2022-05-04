package com.cpn.location.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cpn.coupCategory.model.CoupCategoryVO;
import com.cpn.db.ConnectionPoolMgr2;

public class LocationDAO {
	private ConnectionPoolMgr2 pool;

	public LocationDAO() {
		pool = new ConnectionPoolMgr2();
	}
	
	public String selectLocByLocNum(int locNum) throws SQLException {
		Connection con = null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String locName="";
		try {
			con=pool.getConnection();
			String sql="select locname from location where locnum=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, locNum);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				locName=rs.getString(1);
			}
			System.out.println("지역번호로 조회결과 locName="+locName+", 매개변수 locNum="+locNum);
			return locName;
		}finally {
			pool.dbClose(rs,ps, con);
		}
	}
	
	public List<LocationVO> selectAll() throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<LocationVO> list=new ArrayList<LocationVO>();
		try {
			con=pool.getConnection();
			String sql="select * from location";
			ps=con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				LocationVO vo=new LocationVO();
				vo.setLocName(rs.getString("locName"));
				vo.setLocNum(rs.getInt("locnum"));
				
				list.add(vo);
			}
			System.out.println("카테고리 전체 출력 결과 = "+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
}
