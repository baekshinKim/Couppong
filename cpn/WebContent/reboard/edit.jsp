<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.questionboard.model.ReQuestionBoardVO"%>
<%@page import="com.cpn.questionboard.model.ReQuestionBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>답변형 게시판 글 수정 - 쿠퐁</title>
<meta charset="utf-8">
<%@ include file="../inc/top.jsp"%>
<!-- 기본제이쿼리라이브러리 -->
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
  <!-- 아이디중복확인 / 유효성검사 js-->
<script type="text/javascript" src="../js/member.js"></script>
  <!-- top메뉴 간격 css-->
<link href="../css/top.css" rel="stylesheet" />

<script type="text/javascript">
$(function(){
	$('#title').focus();
	
	$('form[name=frmEdit]').find('input[type=button]').click(function(){
		location.href ='list.jsp';
	});
</script>
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }
	.divForm{
		width:650px;
		border:1px solid #ddd;		
	}
	.divForm div	{
		clear: both; 
		border:none;
		padding: 7px 0;
		margin: 0;
		overflow: auto;
	}	
</style>
</head>
<body>
<%
	//detail.jsp에서 [수정] 링크 클릭하면 get방식으로 이동
	//=> http://localhost:9090/mystudy/reBoard/edit.jsp?no=5
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
	

	String QBoardContent=vo.getQBoardContent();
	if(QBoardContent==null) QBoardContent="";
%>
<div class="divForm">
<form name="frmEdit" method="post" action="edit_ok.jsp"> 
	<!--  수정시 필요한 no를 hidden 필드에 넣는다-->
    <input type="hidden" name="no" value="<%=no%>"/>
	
    <fieldset>
	<legend>글수정</legend>
        <div class="firstDiv">
            <label for="rqtitle">제목</label>
            <input type="text" id="rqtitle" name="rqtitle" 
            	value="<%=vo.getQBoardTitle()%>"/>
        </div>
        <div>
            <label for="rqno">회원번호</label>
            <input type="hidden" id="rqno" name="rqno" 
           		value="<%=vo.getMemNo()%>"/>
        </div>
        <div>  
        	<label for="content">내용</label>        
 			<textarea id="content" name="content" rows="12" cols="40"><%=QBoardContent%></textarea>
        </div>
         <div>
            <label for="rqrigno">관리자번호</label>
            <input type="text" id="rqrigno" name="rqrigno" 
           		value="<%=vo.getRigNo()%>"/>
        </div>
        <div class="center">
        <input type="checkbox" name="open" value="공개">공개
        <input type="checkbox" name="close" value="비공개">비공개
            <input type = "submit" value="수정"/>
            <input type = "Button" value="글목록" onclick="location.href	='list.jsp'" />         
        </div>
	</fieldset>
</form>    
</div>
 <%@ include file="../inc/bottom.jsp"%>  
