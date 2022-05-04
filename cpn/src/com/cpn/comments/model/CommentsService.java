package com.cpn.comments.model;

import java.sql.SQLException;
import java.util.List;

import com.cpn.noticeBoard.model.noticeVO;

public class CommentsService {
	private CommentsDAO commentsDao;
	
	public CommentsService() {
		commentsDao=new CommentsDAO();
	}
	
	public List<CommentsVO> selectByCoupNo(int CoupNo) throws SQLException{
		return commentsDao.selectByCoupNo(CoupNo);
	}
	
	public int insertComments(CommentsVO vo) throws SQLException {
		return commentsDao.insertComments(vo);
	}
	
	public int selectCommentsCnt(int CoupNo) throws SQLException {
		return commentsDao.selectCommentsCnt(CoupNo);
	}
	
}
