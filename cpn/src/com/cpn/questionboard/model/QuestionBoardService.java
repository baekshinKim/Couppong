package com.cpn.questionboard.model;

import java.sql.SQLException;
import java.util.List;

public class QuestionBoardService {
	
	private ReQuestionBoardDAO qboardDao;
	
	public QuestionBoardService() {
		qboardDao=new ReQuestionBoardDAO();
	}
	
	public int insertBoard(ReQuestionBoardVO vo) throws SQLException {
		return qboardDao.insertReBoard(vo);
	}

	public List<ReQuestionBoardVO> selectAll(String condition, String keyword) throws SQLException{
		return qboardDao.selectAll(condition, keyword);
	}
	
	public ReQuestionBoardVO selectByNo(int no) throws SQLException {
		return qboardDao.selectByNo(no);
	}
	
	public int updateBoard(ReQuestionBoardVO vo) throws SQLException {
		return qboardDao.updateReBoard(vo);
	}
	
	public int deleteBoard(int QBoardNo) throws SQLException {
		return qboardDao.deleteReBoard(QBoardNo);
	}
	public int insertReBoard(ReQuestionBoardVO vo) throws SQLException {
		return qboardDao.insertReBoard(vo);
	}
		
	
}
