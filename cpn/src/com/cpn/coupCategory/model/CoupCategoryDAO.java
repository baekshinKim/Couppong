package com.cpn.coupCategory.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cpn.coupon.model.couponVO;
import com.cpn.db.ConnectionPoolMgr2;

public class CoupCategoryDAO {
	private ConnectionPoolMgr2 pool;
	
	public CoupCategoryDAO() {
		pool=new ConnectionPoolMgr2();
	}
	
	public String selectLocByCtgNo(int ctgNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String ctgName="";
		try {
			con=pool.getConnection();
			String sql="select ctgName  from coupcategory where ctgNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, ctgNo);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				ctgName=rs.getString(1);
			}
			System.out.println("지역번호로 조회결과 ctgName="+ctgName+", 매개변수 locNum="+ctgNo);
			return ctgName;
		}finally {
			pool.dbClose(rs,ps, con);
		}
	}
	
	public List<CoupCategoryVO> selectAll() throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<CoupCategoryVO> list=new ArrayList<CoupCategoryVO>();
		try {
			con=pool.getConnection();
			String sql="select * from coupcategory";
			ps=con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				CoupCategoryVO vo=new CoupCategoryVO();
				vo.setCtgNo(rs.getInt("ctgNo"));
				vo.setCtgName(rs.getString("ctgName"));
				
				list.add(vo);
			}
			System.out.println("카테고리 전체 출력 결과 = "+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
