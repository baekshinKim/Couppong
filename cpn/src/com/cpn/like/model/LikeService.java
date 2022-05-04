package com.cpn.like.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class LikeService {	
		private LikeDAO likeDao;
		
		public LikeService() {
			super();
			this.likeDao=new LikeDAO();
		}

		public int insertLike(LikeVO vo) throws SQLException {
			return likeDao.insertLike(vo);
		}
		
		public int deleteLike(LikeVO vo) throws SQLException {
			return likeDao.deleteLike(vo);
		}
		
		//관심등록인지 취소인지 확인하는 메소드 - true면 등록, false면 취소 , 매개변수 LikeVO vo
		public boolean isLike(LikeVO vo) throws SQLException {
			return likeDao.isLike(vo);
		}
		
	
}
