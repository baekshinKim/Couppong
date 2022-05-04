<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.common.util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="noServ" class="com.cpn.noticeBoard.model.noticeService"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	
	if(rigNo!=util.STAFF){%>
		<script type="text/javascript">
			alert("접근 권한이 없습니다.");
			location.href="<%=request.getContextPath()%>/index.jsp";
		</script>
	<%}
	//http://localhost:9090/cpn/noticeBoard/noticeDelete.jsp?noticeNo=14
	String noticeNo = request.getParameter("noticeNo");
	if(noticeNo==null || noticeNo.isEmpty()){%>
		<script type="text/javascript">
			alert("잘못된 접근 입니다.");
			location.href="<%=request.getContextPath()%>/index.jsp";
		</script>
	<%}
	int cnt=0;
	try{
		cnt=noServ.deleteNotice(Integer.parseInt(noticeNo));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	if(cnt>0){%>
		<script type="text/javascript">
			alert("공지 삭제 성공!");
			location.href="noticeList.jsp";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert("잘못된 접근 입니다.");
			location.href="noticeDetail.jsp?noticeNo=<%=noticeNo%>";
		</script>
	<%}
		
%>
</body>
</html>