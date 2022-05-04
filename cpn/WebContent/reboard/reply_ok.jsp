<%@page import="com.cpn.questionboard.model.ReQuestionBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.questionboard.model.ReQuestionBoardDAO"%>
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
	//reply.jsp에서 post방식으로 submit
	//1
	request.setCharacterEncoding("utf-8");

	String QBoardContent=request.getParameter("QBoardContent");
	String QBoardGroupNo=request.getParameter("QBoardGroupNo");
	String QBoardStep=request.getParameter("QBoardStep");
		
	//2
	ReQuestionBoardDAO dao = new ReQuestionBoardDAO();
	ReQuestionBoardVO vo = new ReQuestionBoardVO();
	vo.getRigNo();
	vo.getQBoardGroupNo();
	vo.getQBoardContent();
	
	int cnt=0;
	try{
		cnt=dao.reply(vo);	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	if(vo.getRigNo()==2){ %>
		<script type="text/javascript">
			alert('답변달기 성공');
			location.href="list.jsp";
		</script>	
<%	}else{%>
		<script type="text/javascript">
			alert('답변달기 실패');
			history.back();
		</script>
<%	}%>
<jsp:forward page="../common/message.jsp" />
</body>
</html>