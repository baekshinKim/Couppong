<%@page import="com.cpn.common.util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<%
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	if(rigNo!=util.STAFF){%>
		<script type="text/javascript">
			alert("접근권한이 없습니다.");
			history.back();
		</script>
<%}%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#noticeTitle').focus();
		
		$('form[name=noticeWrite]').find('#list')
			.click(function(){
				location.href='noticeList.jsp';
			});
		
		$('form[name=noticeWrite]').submit(function(){
			if($('#noticeTitle').val().length<1){
				alert('제목을 입력하시오');
				$('#noticeTitle').focus();
				event.preventDefault();
			}else if($('#adminNo').val().length<1){
				alert('관리자 번호를 입력하시오');
				$('#adminNo').focus();
				event.preventDefault();
			}else if($('#noticeContent').val().length<1){
				alert('내용을 입력하시오');
				$('#noticeContent').focus();
				event.preventDefault();
			}
		});
	});
</script>
<div id="map-canvas" style="width:25%;height: 100px"></div>
<div class="container" style="width:50%;">
	<div class="row g-2">
		<form name="noticeWrite" method="post" action="noticeWrite_ok.jsp" >
			<input type="hidden" id="adminNo" name="adminNo" value="<%=(Integer)session.getAttribute("adminNo")%>"/>
			<fieldset>
			<p class="fs-3 lh-sm" style="text-align: center;margin-bottom: 40px">공지작성</p>
	        <div class="input-group input-group-lg mb-5">
	        	<span class="input-group-text" id="inputGroup-sizing-sm">공지제목</span>
	            <input type="text" class="form-control" id="noticeTitle" name="noticeTitle"  />
	        </div>
		        <div class="form-floating mb-5">  
		 			<textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" name="noticeContent" style="height: 500px;resize: none"></textarea>
		 			<label for="floatingTextarea2">내용 입력</label>
		        </div>
		        
		        <div class="d-grid gap-2 col-6 mx-auto">
				  <button class="btn btn-outline-primary btn-lg" type="submit">공지등록</button>
				  <button class="btn btn-outline-warning btn-lg" type="button" id="list">글목록</button>
				</div>      
		    </fieldset>
		</form>
	</div>
</div>   
<div id="map-canvas" style="width:25%;height: 50px"></div>
 <%@ include file="../inc/bottom.jsp"%>