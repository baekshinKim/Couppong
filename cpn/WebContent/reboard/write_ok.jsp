<%@page import="com.cpn.questionboard.model.QuestionBoardService"%>
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
	//write.jsp에서 post방식으로 submit
	//1
	request.setCharacterEncoding("utf-8");

	String qBoardTitle=request.getParameter("rqtitle");	
	String qBoardContent=request.getParameter("rqcontent");
	String qBoardPrivateFlag=request.getParameter("qBoardPrivateFlag");
	String rigNo=request.getParameter("rigNo");
	String memNo=request.getParameter("memNo");
	//2
	
	QuestionBoardService qService = new QuestionBoardService();
	ReQuestionBoardVO vo = new ReQuestionBoardVO();
	vo.setQBoardTitle(qBoardTitle);
	vo.setQBoardContent(qBoardContent);
	vo.setQBoardPrivateFlag(qBoardPrivateFlag);
	vo.setRigNo(Integer.parseInt(rigNo));
	vo.setMemNo(Integer.parseInt(memNo));
	
	String msg="게시판 입력 실패",url="/reboard/write.jsp";
	try{
		int cnt=qService.insertReBoard(vo);
		
		if(cnt>0){
			msg="게시판 입력 성공";
			url="/reboard/list.jsp";
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