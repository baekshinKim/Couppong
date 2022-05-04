<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../inc/top.jsp"%>
<!--   <link href="../inc/css/styles.css" rel="stylesheet" /> -->
  
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
	.divForm{
		width:650px;
		border:1px solid #ddd;		
	}
	.divForm div	{
		/* clear: both; */
		border:none;
		padding: 7px 0;
		margin: 0;
		overflow: auto;
	}	
	.sp{
		font-size:0.9em;
		color:#0056AC;			
	}
	.divForm fieldset	{
		border:0;
	}
</style>
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('form[name=frmDelete]').submit(function(){
			if($('#pwd').val().length<1){
				alert('비밀번호를 입력하세요');
				$('#pwd').focus();
				event.preventDefault();
			}else if(!confirm('삭제하시겠습니까?')){
				event.preventDefault();
			}
		});
	});	
</script>
</head>
<body>
<%
	
	//1
	String QBoardNo=request.getParameter("QBoardNo");
	if(QBoardNo==null || QBoardNo.isEmpty()){%>
		<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href='list.jsp';
		</script>
		
	<%	return;
	}
	
	String QBoardStep=request.getParameter("QBoardStep");
	String QBoardGroupNo=request.getParameter("QBoardGroupNo");
	
	//2	
	//3
%>
<div class="divForm">
<form name="frmDelete" method="post" action="delete_ok.jsp" >
		<input type="hidden" name="no" value="<%=QBoardNo%>">
		<input type="text" name="step" value="<%=QBoardStep%>">
		<input type="text" name="groupNo" value="<%=QBoardGroupNo%>">
		
		<fieldset>
		<legend>글 삭제</legend>
	        <div>           
	        	<span class="sp"><%=QBoardNo %>번 글을 삭제하시겠습니까?</span>                        
	        </div>
	        <div>           
	            <label for="pwd">비밀번호</label>
	            <input type="password" id="pwd" name="pwd" />   
	        </div>
	        <div class="center">
	            <input type ="submit"  value="삭제" />
	            <input type = "Button" value="글목록" 
                	OnClick="location.href='list.jsp'" />
	        </div>
	    </fieldset>
    </form>
</div>
<%@ include file="../inc/bottom.jsp"%> 
