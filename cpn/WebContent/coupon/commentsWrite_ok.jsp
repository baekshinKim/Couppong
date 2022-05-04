<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="commService" class="com.cpn.comments.model.CommentsService"
				scope="page"></jsp:useBean>
<jsp:useBean id="commVo" class="com.cpn.comments.model.CommentsVO"
				scope="page"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>commentsWrite_ok.jsp</title>
</head>
<body>
<%
	//commentsWrite.jsp(include)에서 post방식으로 submit
	//1.
	request.setCharacterEncoding("utf-8");
		
	String coupNo=request.getParameter("c_coupNo");
	String reContents=request.getParameter("reContents");
	
	
	//2.
	String memid="";
	if(session.getAttribute("memid")!=null){
		memid=(String)session.getAttribute("memid");
	}
	
	if(memid==""){%>
	<script type="text/javascript">
		alert("비회원은 작성할 수 없습니다");
		history.back();
		return false;
	</script>
	<%}
	
	commVo.setMemId(memid);
	commVo.setCoupNo(Integer.parseInt(coupNo));
	commVo.setReContents(reContents);
	
	
	int cnt=0;
	try{
		cnt=commService.insertComments(commVo);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3.
	if(cnt>0){%>
		<script type="text/javascript">
			alert('글 입력 성공.');
			location.href="couponDetail.jsp?coupNo=<%=coupNo%>";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert('글 입력 실패.');
			history.go(-1);
		</script>
	<%}%>
</body>
</html>