package com.cpn.admin.model;

import java.sql.SQLException;

public class adminService {
	adminDAO dao=null;
	
	public adminService() {
		dao=new adminDAO();
	}
	
	public String selectNameByNo(int adminNo) throws SQLException {
		return dao.selectNameByNo(adminNo);
	}
	
	public int adminLoginCheck(String adminId, String adminPwd) throws SQLException {
		return dao.adminLoginCheck(adminId, adminPwd);
		
	}
	
	public adminVO selectAdminByAdminId(String adminId) throws SQLException {
		return dao.selectAdminByAdminId(adminId);		
	}
	
	
	
}
