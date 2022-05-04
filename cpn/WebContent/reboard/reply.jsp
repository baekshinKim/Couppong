<%@page import="com.cpn.questionboard.model.ReQuestionBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.questionboard.model.ReQuestionBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <%@ include file="../inc/top.jsp"%>
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="../js/member.js"></script>
<link href="../css/top.css" rel="stylesheet" />
  
<title>답변형 게시판 답변하기 - 쿠퐁</title>
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#title').focus();
		
		$('form[name=frmWrite]').find('input[type=button]').click(function(){
			location.href ='list.jsp';
		});
		
		$('form[name=frmWrite]').submit(function(){
			if($('#title').val().length<1){
				alert('제목을 입력하세요');
				$('#title').focus();
				event.preventDefault();
			}else if($('#name').val().length<1){
				alert('이름을 입력하세요');
				$('#name').focus();
				event.preventDefault();
			}else if($('#pwd').val().length<1){
				alert('비밀번호를 입력하세요');
				$('#pwd').focus();
				event.preventDefault();
			}			
		});
		
	});
</script>

</head>
<body>
<%
	
	String no=request.getParameter("no");
	if(no==null || no.isEmpty()){%>
		<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href='list.jsp';
		</script>
		
	<%	return;
	}
	
	//2
	ReQuestionBoardDAO dao = new ReQuestionBoardDAO();
	ReQuestionBoardVO vo=null;
	try{
		vo=dao.selectByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();	
	}
	
	//3
	
%>
<div class="divForm">
<form name="frmWrite" method="post" action="reply_ok.jsp" >
	<input type="hidden" name="QBoardGroupNo" 
		value="<%=vo.getQBoardGroupNo()%>" />
	<input type="hidden" name="rigNo" 
		value="<%=vo.getRigNo()%>" />
	<input type="hidden" name="sortNo" 
		value="<%=vo.getQBoardPrivateFlag()%>" />
	
 <fieldset>
	<legend>답변하기</legend>
        <div class="firstDiv">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" 
            	value="Re: <%=vo.getQBoardTitle() %>" />
        </div>
        <div>
            <label for="name">권한번호</label>
            <input type="text" id="name" name="name" />
        </div>
        <div>  
        	<label for="content">내용</label>        
 			<textarea id="content" name="QBoardContent" rows="12" cols="40"></textarea>
        </div>
        <div class="center">
            <input type = "submit" value="답변"/>
            <input type = "Button" value="글목록" />         
        </div>
    </fieldset>
</form>
</div>   

<%@ include file="../inc/bottom.jsp"%> 