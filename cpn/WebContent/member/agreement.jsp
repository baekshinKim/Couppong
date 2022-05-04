<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>

  <!-- 기본제이쿼리라이브러리 -->
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>

  <!-- top메뉴 간격 css-->
<link href="../css/top.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">
<script type="text/javascript">
	$(function(){
		/* 동의에 체크여야 submit 진행 */
		$('#submit').click(function(){
			if(!$('#chkAgree').is(":checked")){
				alert('약관에 동의하셔야 합니다.');
				$('#chkAgree').focus();
				event.preventDefault();
			}
		});
	});
</script>
<style>
.divAgreement{
	margin: 40px; text-align:center; !important;
	
}
#agreeBox{
	display:block; text-align:center;
	
}

#formAgree{
	display:block; margin: 10px; text-align:center;

}

span{
	font-family: 'Montserrat', sans-serif; font-size: 1.3em;
}
</style>

<div class="divAgreement">
<h2><span><b>coupongg</b></span> 회원약관</h2><br>
<br><br>

<iframe src="provision.html" width="960px" height="300px"></iframe>
<div style="width:100%; text-align:center;">
	<form  id="formAgree"  name="frmAgree" method="post" action="register.jsp">
		<fieldset>
		   
	   <!--    <legend style="visibility:hidden;">회원 약관</legend>  -->
		<input type="checkbox" name="chkAgree" id="chkAgree">
		<label for="chkAgree">약관에 동의합니다.</label>
		
		</fieldset>
	 <div class="position-relative divAgreement">
	
			<input type="submit" id="submit" value="확인"
			 class="btn btn-outline-primary">			
			<input type="reset" value="취소" class="btn btn-outline-secondary">

	 </div>

	</form>

</div>	

</div>
<%@ include file="../inc/bottom.jsp" %>
