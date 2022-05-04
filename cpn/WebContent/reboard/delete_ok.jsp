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
	//delete.jsp에서 post방식으로 submit
	//1
	request.setCharacterEncoding("utf-8");
	int rigNo=Integer.parseInt(request.getParameter("rigNo"));
	int QBoardNo=Integer.parseInt(request.getParameter("QBoardNo"));
	String MemNo=request.getParameter("MemNo");
	
	//2
	ReQuestionBoardDAO dao = new ReQuestionBoardDAO();
	
	try{
		if(dao.checkPwd(rigNo, pwd)){
			ReQuestionBoardVO vo = new ReQuestionBoardVO();;
			vo.setMemNo(Integer.parseInt(MemNo));
			//vo.setQBoardStep(Integer.parseInt(QBoardStep));
			
			
			dao.deleteReBoard(QBoardNo); %>
			<script type="text/javascript">
				alert('글 삭제되었습니다.');
				location.href='list.jsp';
			</script>
	<%	}
	}catch(SQLException e){
		e.printStackTrace(); %>
		<script type="text/javascript">
			alert('글 삭제 실패!');
			history.back();
		</script>	
<%	}	%>


 <%@ include file="../inc/bottom.jsp"%> 	
</body>
</html>