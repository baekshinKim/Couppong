package com.cpn.location.model;

import java.sql.SQLException;
import java.util.List;

public class LocationService {
	private LocationDAO dao;
	
	public LocationService() {
		dao=new LocationDAO();
	}
	public String selectLocByLocNum(int locNum) throws SQLException {
		return dao.selectLocByLocNum(locNum);
	}
	
	public List<LocationVO> selectAll() throws SQLException {
		return dao.selectAll();
	}
}
