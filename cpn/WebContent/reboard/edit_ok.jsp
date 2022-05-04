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
	//edit.jsp에서 post방식으로 submit
	//1
	request.setCharacterEncoding("utf-8");
	
	String qBoardTitle=request.getParameter("qBoardTitle");
	String qBoardContent=request.getParameter("Content");
	String qBoardMemNo=request.getParameter("qBoardMemNo");
	
	//2
	ReQuestionBoardDAO dao=new ReQuestionBoardDAO();
	ReQuestionBoardVO vo = new ReQuestionBoardVO();
	vo.setQBoardContent(qBoardContent);
	vo.setQBoardTitle(qBoardTitle);
	vo.setMemNo(Integer.parseInt(qBoardMemNo));
	
	
	int cnt=0;
	try{
		if(){ 
			cnt=dao.updateReBoard(vo); // 일치시 수정처리
			
			if(cnt>0){%>
				<script type="text/javascript">
					alert('글 수정되었습니다.');
					location.href="detail.jsp?no=<%=vo.getQBoardNo()%>";
				</script>
			<%}else{%>
				<script type="text/javascript">
					alert('글 수정 실패');
					history.go(-1);
				</script>		
			<%}
		}else{%>
			<script type="text/javascript">
				alert('번호가 일치하지 않습니다.');
				history.go(-1);
			</script>
	<%	}
	}catch(SQLException e){
		e.printStackTrace();
	}
	%>
	
</body>
</html>