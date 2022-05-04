<%@page import="com.cpn.questionboard.model.ReQuestionBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../inc/top.jsp"%>
  
<title>1:1 문의사항</title>
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#rqtitle').focus();
		
		$('form[name=frmWrite]').find('input[type=button]').click(function(){
			location.href ='list.jsp';
		});
		
		$('form[name=frmWrite]').submit(function(){
			if($('#rqtitle').val().length<1){
				alert('제목을 입력하세요');
				$('#rqtitle').focus();
				event.preventDefault();
			}else if($('#memNo').val().length<1){
				alert('회원번호를 입력하세요');
				$('#memNo').focus();
				event.preventDefault();
			}		
			
			if($("#visibleChk").is(":checked")){
	    		$("#qBoardPrivateFlag").val("Y");
	    	}else{
	    		$("#qBoardPrivateFlag").val("N");
	    	}  			
		});
		
		
	});
</script>

<% 
	ReQuestionBoardVO vo=new ReQuestionBoardVO();
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	
	int memNo=0;
	if(session.getAttribute("memNo")!=null){
		memNo=(Integer)session.getAttribute("memNo");
	}
	
	if(rigNo<1){%>
		<script type="text/javascript">
			alert("권한이 없습니다");
			history.back();
		</script>	
	<%}
%>
<body>

<div class="divForm">
<div style="width:100%; height: 600px;">
<form name="frmWrite" method="post" action="write_ok.jsp" >
<input type="hidden" name="rigNo" value="<%=rigNo%>">
 <fieldset>
	<legend>1:1 게시판</legend>
        <div class="firstDiv">
            <label for="rqtitle">제목</label>
            <input type="text" id="rqtitle" name="rqtitle"  />
        </div>
        <div>
            <label for="memNo">회원번호</label>
            <input type="hidden" id="memNo" name="memNo" 
            value="<%=memNo %>" />
        </div> 
        <div>  
        	<label for="rqcontent">내용</label>        
 			<textarea id="rqcontent" name="rqcontent" rows="12" cols="40"></textarea>
        </div>
        <div class="secret">
        <input type="checkbox"  name="secret" id="visibleChk" checked="checked">비공개 체크
        <input type="hidden" name="qBoardPrivateFlag" id="qBoardPrivateFlag">
        <script type="text/javascript">
      
        </script>
        </div>
        <div class="center">
            <input type = "submit" value="등록"/>
            <input type = "Button" value="글목록" />         
        </div>
    </fieldset>
</form>

</div>   
 </div>
 <%@ include file="../inc/bottom.jsp"%>  

