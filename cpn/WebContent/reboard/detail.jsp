<%@page import="com.cpn.questionboard.model.ReQuestionBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.questionboard.model.ReQuestionBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>답변형 게시판 - 쿠퐁</title>
<%@ include file="../inc/top.jsp"%>
  
  <!-- 기본제이쿼리라이브러리 -->
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
  <!-- 아이디중복확인 / 유효성검사 js-->
<script type="text/javascript" src="../js/member.js"></script>
  <!-- top메뉴 간격 css-->
<link href="../css/top.css" rel="stylesheet" />
  
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }
	.divForm {
		width: 500px;
		}
</style>  
</head>
<body>
<%
	//list.jsp에서 제목 링크 클릭하면 get방식으로 이동
	//1
	String no=request.getParameter("no");
	if(no==null || no.isEmpty()){%>
		<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href='list.jsp';
		</script>
		
	<%	return;
	}
	
	//2
	ReQuestionBoardDAO dao=new ReQuestionBoardDAO();
	ReQuestionBoardVO vo=new ReQuestionBoardVO();
	try{
		vo=dao.selectByNo(Integer.parseInt(no));	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	String QBoardContent=vo.getQBoardContent();
	if(QBoardContent!=null){
		QBoardContent=QBoardContent.replace("\r\n", "<br>");
	}else{
		QBoardContent="";
	}
%>
	<h2>글 상세보기</h2>
	<div class="divForm">
		<div class="firstDiv">
			<span class="sp1">제목</span> <span><%=vo.getQBoardTitle() %></span>
		</div>
		<div>
			<span class="sp1">회원번호</span> <span><%=vo.getMemNo() %></span>
		</div>
		<div>
			<span class="sp1">등록일</span> <span><%=vo.getQBoardRegdate() %></span>
		</div>
		<div class="lastDiv">			
			<p class="content"><%=vo.getQBoardContent() %></p>
		</div>
		<div class="center">
			<a href='edit.jsp?no=<%=no%>'>수정</a> |
        	<a href='delete.jsp?no=<%=no%>&step=<%=vo.getQBoardStep()%>&groupNo=<%=vo.getQBoardGroupNo()%>'>삭제</a> |
        	<a href='reply.jsp?no=<%=no%>'>답변</a> |        	
        	<a href='list.jsp'>목록</a>			
		</div>
	</div>

 <%@ include file="../inc/bottom.jsp"%>  	
