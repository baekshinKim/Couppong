package com.cpn.coupon.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class couponService {
	private couponDAO dao;
	
	public couponService() {
		dao=new couponDAO();
	}
	
	public int insertCoup(couponVO vo) throws SQLException {
		return dao.insertCoup(vo);
	}
	
	public couponVO selectByNo(int coupNo) throws SQLException {
		return dao.selectByNo(coupNo);
	}
	
	public List<couponVO> selectCoupon(String searchTxt,int locNum,int ctgNo,int sort) throws SQLException{
		return dao.selectCoupon(searchTxt,locNum,ctgNo,sort);
	}
	
	public List<couponVO> selectByCtg(int ctgNo) throws SQLException {
		return dao.selectByCtg(ctgNo);
	}
	
	public int editCoupon(couponVO vo) throws SQLException {
		return dao.editCoupon(vo);
	}
	
	public int deleteCoupon(int coupNo) throws SQLException {
		return dao.deleteCoupon(coupNo);
	}
	
	//관심등록하면 likeCnt++, 해제하면 likeCnt--;
	 public int likeUp(int coupNo) throws SQLException {
		 return dao.likeUp(coupNo);
	 }
	 
	 public int likeDown(int coupNo) throws SQLException {
		return dao.likeDown(coupNo);
	 }
	 
	 public int purUp(int coupNo) throws SQLException {
		return dao.purUp(coupNo);
	}
	 
	 public int purDown(int coupNo) throws SQLException {
		return dao.purDown(coupNo);
	 }
}
