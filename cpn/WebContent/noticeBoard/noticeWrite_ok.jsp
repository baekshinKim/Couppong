<%@page import="com.cpn.noticeBoard.model.noticeVO"%>
<%@page import="com.cpn.noticeBoard.model.noticeService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");

	String noticeTitle=request.getParameter("noticeTitle");
	String noticeContent=request.getParameter("noticeContent");
	String adminNo=request.getParameter("adminNo");
	
	noticeService noServ = new noticeService();
	noticeVO vo=new noticeVO();
	vo.setNoticeTitle(noticeTitle);
	vo.setNoticeContent(noticeContent);
	vo.setAdminNo(Integer.parseInt(adminNo));
	
	
	String msg="공지 입력 실패",url="/noticeBoard/noticeWrite.jsp";
	try{
		int cnt=noServ.insertNotice(vo);
		
		if(cnt>0){
			msg="공지 입력 성공";
			url="/noticeBoard/noticeList.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	request.setAttribute("msg", msg);
	request.setAttribute("url",url);
%>
<jsp:forward page="../common/message.jsp" />
</body>
</html>