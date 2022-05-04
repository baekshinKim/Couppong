package com.cpn.coupCategory.model;

import java.sql.SQLException;
import java.util.List;

public class CoupCategoryService {
	private CoupCategoryDAO dao;

	public CoupCategoryService() {
		dao=new CoupCategoryDAO();
	}

	public String selectLocByCtgNo(int ctgNo) throws SQLException {
		return dao.selectLocByCtgNo(ctgNo);
	}
	
	public List<CoupCategoryVO> selectAll() throws SQLException {
		return dao.selectAll();
	}
}

