package com.cpn.noticeBoard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class noticeService {
	private noticeDAO dao;
	public noticeService() {
		dao=new noticeDAO();
	}
	
	public int insertNotice(noticeVO vo) throws SQLException {
		return dao.insertNotice(vo);
	}
	
	public List<noticeVO> selectAll(String condition, String keyword) throws SQLException{ 
		return dao.selectAll(condition, keyword);
	}
	
	public int updateCount(int noticeNo) throws SQLException {
		return dao.updateCount(noticeNo);
	}
	
	public noticeVO selectByNo(int noticeNo) throws SQLException {
		return dao.selectByNo(noticeNo);
	}
	
	public int updateNotice(noticeVO vo) throws SQLException {
		return dao.updateNotice(vo);
	}
	
	public int deleteNotice(int noticeNo) throws SQLException {
		return dao.deleteNotice(noticeNo);
	}
}
