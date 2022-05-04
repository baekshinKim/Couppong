<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.noticeBoard.model.noticeService"%>
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

	String noticeNo=request.getParameter("noticeNo");
	
	noticeService noServ = new noticeService();
	
	if(noticeNo==null || noticeNo.isEmpty()){%>
	<script type="text/javascript">
		alert('잘못된 url 접근');
		history.back();
	</script>
	<% return;
	}
	try{
		int cnt=noServ.updateCount(Integer.parseInt(noticeNo));
		
		if(cnt>0){
			response.sendRedirect("noticeDetail.jsp?noticeNo="+noticeNo);
		}else{%>
			<script type="text/javascript">
				alert("조회 실패");
				history.back();
			</script>
	<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>
</body>
</html>