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
	//post
	
	request.setCharacterEncoding("utf-8");
	String noticeTitle=request.getParameter("noticeTitle");
	String noticeNo=request.getParameter("noticeNo");
	String noticeContent=request.getParameter("noticeContent");
	String adminNo=request.getParameter("adminNo");

%>
<jsp:useBean id="vo" class="com.cpn.noticeBoard.model.noticeVO"></jsp:useBean>
<jsp:setProperty property="*" name="vo"/>
<jsp:useBean id="noServ" class="com.cpn.noticeBoard.model.noticeService"></jsp:useBean>
<%
	
	/* vo.setAdminNo(Integer.parseInt(adminNo));
	vo.setNoticeContent(noticeContent);
	vo.setNoticeTitle(noticeTitle);
	vo.setNoticeNo(Integer.parseInt(noticeNo)); */
	
	try{
		int cnt=noServ.updateNotice(vo);
		
		if(cnt>0){%>
			<script type="text/javascript">
				alert("공지수정 성공");
				location.href="noticeDetail.jsp?noticeNo=<%=vo.getNoticeNo()%>";
			</script>
		<%}else{%>
				alert("공지수정 실패");
				history.back();
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>