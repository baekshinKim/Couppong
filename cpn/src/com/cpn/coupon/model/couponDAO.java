package com.cpn.coupon.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cpn.db.ConnectionPoolMgr2;

public class couponDAO {
	private ConnectionPoolMgr2 pool=null;
	
	public couponDAO() {
		pool=new ConnectionPoolMgr2();
	}
	
	public int insertCoup(couponVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="insert into coupon(coupno,ctgno,coupname,coupprice,"
					+ " coupstartdate,coupenddate,coupcontent,coupfilename,"
					+ " couporiginalfilename,coupfilesize,locnum,latitude,longitude,address)\r\n" + 
					" values(SEQ_COUPON.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getCtgNo());
			ps.setString(2, vo.getCoupName());
			ps.setInt(3, vo.getCoupPrice());
			ps.setTimestamp(4, vo.getCoupStartDate());
			ps.setTimestamp(5, vo.getCoupEndDate());
			ps.setString(6, vo.getCoupContent());
			ps.setString(7, vo.getCoupFileName());
			ps.setString(8, vo.getCoupOriginalFileName());
			ps.setDouble(9, vo.getCoupFileSize());
			ps.setInt(10, vo.getLocNum());
			ps.setDouble(11, vo.getLatitude());
			ps.setDouble(12, vo.getLongitude());
			ps.setString(13, vo.getAddress());
			
			int cnt=ps.executeUpdate();
			System.out.println("쿠폰 입력결과 cnt="+cnt+", 매개변수 vo="+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public couponVO selectByNo(int coupNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		couponVO vo=new couponVO();
		try {
			con=pool.getConnection();
			String sql="select * from coupon where coupNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, coupNo);
			rs=ps.executeQuery();
			while(rs.next()) {
				vo.setCoupName(rs.getString("coupName"));
				vo.setAddress(rs.getString("address"));
				vo.setCoupContent(rs.getString("coupcontent"));
				vo.setCoupEndDate(rs.getTimestamp("coupenddate"));
				vo.setCoupFileName(rs.getString("coupfilename"));
				vo.setCoupLikecnt(rs.getInt("couplikecnt"));
				vo.setCoupPrice(rs.getInt("coupprice"));
				vo.setCoupPurchase(rs.getInt("couppurchase"));
				vo.setCoupRegDate(rs.getTimestamp("coupregdate"));
				vo.setCoupStartDate(rs.getTimestamp("coupstartdate"));
				vo.setCtgNo(rs.getInt("ctgNo"));
				vo.setLatitude(rs.getDouble("latitude"));
				vo.setLongitude(rs.getDouble("longitude"));
				vo.setLocNum(rs.getInt("locnum"));
				vo.setCoupNo(coupNo);
			}
			System.out.println("매개변수 coupNo="+coupNo);
			return vo;
		}finally {
			pool.dbClose(rs,ps,con);
		}
	}
	
	public List<couponVO> selectCoupon(String searchTxt,int locNum,int ctgNo,int sort) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<couponVO> list=new ArrayList<couponVO>();
		try {
			con=pool.getConnection();
			
			//sql 작성
			String sql="select * from coupon where coupName like '%' || ? || '%'";
			
			
			if(locNum>0) {
				sql+=" and locNum=?";
			}
			if(ctgNo>0) {
				sql+= " and ctgNo=?";
			}
			
			if(sort==4) {
				sql+=" and coupEndDate<trunc(sysdate)";
			}
			
			switch(sort) {
			case 0 :
				sql+=" order by coupNo desc";
				break;
			case 1 :
				sql+=" order by coupPrice";
				break;
			case 2:
				sql+=" order by coupPurchase desc";
				break;
			case 3:
				sql+=" order by coupLikecnt desc";
				break;
			default :
				sql+=" order by coupNo desc";
			}
			
			//파라미터 인덱스
			ps=con.prepareStatement(sql);
			ps.setString(1, searchTxt);
			
			if(locNum>0) {
				ps.setInt(2, locNum);
			}
			if(locNum<1 && ctgNo>0) {
				ps.setInt(2, ctgNo);
			}else if(locNum>0 && ctgNo>0){
				ps.setInt(3, ctgNo);
			}
			
			
			rs=ps.executeQuery();
			while(rs.next()) {
				couponVO vo=new couponVO();
				vo.setAddress(rs.getString("address"));
				vo.setCoupContent(rs.getString("coupContent"));
				vo.setCoupEndDate(rs.getTimestamp("coupEndDate"));
				vo.setCoupFileName(rs.getString("coupFileName"));
				vo.setCoupLikecnt(rs.getInt("coupLikeCnt"));
				vo.setCoupName(rs.getString("coupName"));
				vo.setCoupNo(rs.getInt("coupNo"));
				vo.setCoupOriginalFileName(rs.getString("coupOriginalFileName"));
				vo.setCoupPrice(rs.getInt("coupPrice"));
				vo.setCoupPurchase(rs.getInt("coupPurchase"));
				vo.setCoupRegDate(rs.getTimestamp("coupRegDate"));
				vo.setCoupStartDate(rs.getTimestamp("coupStartDate"));
				vo.setCtgNo(rs.getInt("ctgNo"));
				vo.setLatitude(rs.getDouble("latitude"));
				vo.setLocNum(rs.getInt("locNum"));
				vo.setLongitude(rs.getDouble("longitude"));
				
				list.add(vo);
			}
			
			System.out.println("List출력 결과 갯수:"+list.size());
			return list;
		}finally {
			pool.dbClose(rs,ps, con);
		}
	}
	
	public List<couponVO> selectByCtg(int ctgNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<couponVO> list=new ArrayList<couponVO>();
		try {
			con=pool.getConnection();
			String sql="select * from coupon where ctgNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, ctgNo);
			rs=ps.executeQuery();
			while(rs.next()) {
				couponVO vo=new couponVO();
				
				vo.setCoupNo(rs.getInt("coupNo"));
				vo.setCoupName(rs.getString("coupName"));
				vo.setAddress(rs.getString("address"));
				vo.setCoupContent(rs.getString("coupcontent"));
				vo.setCoupEndDate(rs.getTimestamp("coupenddate"));
				vo.setCoupFileName(rs.getString("coupfilename"));
				vo.setCoupLikecnt(rs.getInt("couplikecnt"));
				vo.setCoupPrice(rs.getInt("coupprice"));
				vo.setCoupPurchase(rs.getInt("couppurchase"));
				vo.setCoupRegDate(rs.getTimestamp("coupregdate"));
				vo.setCoupStartDate(rs.getTimestamp("coupstartdate"));
				vo.setLatitude(rs.getDouble("latitude"));
				vo.setLongitude(rs.getDouble("longitude"));
				vo.setLocNum(rs.getInt("locnum"));
				
				list.add(vo);
			}
			System.out.println("카테고리 번호로 쿠폰조회결과 list.size="+list.size());
			return list;
		}finally {
			pool.dbClose(rs,ps,con);
		}
	}
	
	public int editCoupon(couponVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="update coupon\r\n" + 
					" set coupName=?, coupPrice=?, coupStartdate=?, coupenddate=?, coupContent=?,locNum=?,latitude=?,longitude=?,address=?";
			if(vo.getCoupFileName()!=null && !vo.getCoupFileName().isEmpty()) {
				sql+=" ,coupFileName=?,coupOriginalFileName=?,coupFileSize=?";
			}
			sql+=" where coupNo=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getCoupName());
			ps.setInt(2, vo.getCoupPrice());
			ps.setTimestamp(3, vo.getCoupStartDate());
			ps.setTimestamp(4, vo.getCoupEndDate());
			ps.setString(5, vo.getCoupContent());
			ps.setInt(6, vo.getLocNum());
			ps.setDouble(7, vo.getLatitude());
			ps.setDouble(8, vo.getLongitude());
			ps.setString(9, vo.getAddress());
			
			if(vo.getCoupFileName()!=null && !vo.getCoupFileName().isEmpty()) {
				ps.setString(10, vo.getCoupFileName());
				ps.setString(11, vo.getCoupOriginalFileName());
				ps.setDouble(12, vo.getCoupFileSize());
				ps.setInt(13, vo.getCoupNo());
			}else {
				ps.setInt(10, vo.getCoupNo());
			}
			int cnt=ps.executeUpdate();
			System.out.println("쿠폰 수정 결과 cnt="+cnt);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int deleteCoupon(int coupNo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="delete from coupon where coupNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, coupNo);
			
			int cnt=ps.executeUpdate();
			System.out.println("삭제결과 cnt="+cnt+", 매개변수 coupNo="+coupNo);
			
			return cnt;
					
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	
	//관심등록하면 likeCnt++, 해제하면 likeCnt--;
	 public int likeUp(int coupNo) throws SQLException {
		 Connection con=null;
		 PreparedStatement ps=null;
		 
		 try {
			 con=pool.getConnection();
			 
			 String sql="update coupon \r\n" + 
			 		" set couplikecnt=couplikecnt+1\r\n" + 
			 		" where coupNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, coupNo);
			
			int cnt=ps.executeUpdate();
			System.out.println("좋아요 반영됨 결과 cnt="+cnt+", 쿠폰번호 coupNo="+coupNo);
			return cnt;
		 }finally {
			pool.dbClose(ps, con);
		}
	 }
	 
	 public int likeDown(int coupNo) throws SQLException {
		 Connection con=null;
		 PreparedStatement ps=null;
		 
		 try {
			 con=pool.getConnection();
			 
			 String sql="update coupon \r\n" + 
					 " set couplikecnt=couplikecnt-1\r\n" + 
					 " where coupNo=?";
			 ps=con.prepareStatement(sql);
			 ps.setInt(1, coupNo);
			 
			 int cnt=ps.executeUpdate();
			 System.out.println("좋아요 취소 결과 cnt="+cnt+", 쿠폰번호 coupNo="+coupNo);
			 return cnt;
		 }finally {
			 pool.dbClose(ps, con);
		 }
	 }
	 
	 public int purUp(int coupNo) throws SQLException {
		 Connection con=null;
		 PreparedStatement ps=null;
		 
		 try {
			 con=pool.getConnection();
			 
			 String sql="update coupon set coupPurchase=coupPurchase+1 where coupNo=?";
			 ps=con.prepareStatement(sql);
			 ps.setInt(1, coupNo);
			 
			 int cnt=ps.executeUpdate();
			 System.out.println("구매cnt Up 결과 cnt="+cnt+", 쿠폰번호 coupNo="+coupNo);
			 return cnt;
		 }finally {
			 pool.dbClose(ps, con);
		 }
	 }
	 
	 public int purDown(int coupNo) throws SQLException {
		 Connection con=null;
		 PreparedStatement ps=null;
		 
		 try {
			 con=pool.getConnection();
			 
			 String sql="update coupon set coupPurchase=coupPurchase-1 where coupNo=?";
			 ps=con.prepareStatement(sql);
			 ps.setInt(1, coupNo);
			 
			 int cnt=ps.executeUpdate();
			 System.out.println("구매cnt Down 결과 cnt="+cnt+", 쿠폰번호 coupNo="+coupNo);
			 return cnt;
		 }finally {
			 pool.dbClose(ps, con);
		 }
	 }
	 
	
}
