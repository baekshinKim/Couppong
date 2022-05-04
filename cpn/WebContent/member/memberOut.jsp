<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 탈퇴도 로그인된경우에만 되야하니까 -->
<%@ include file="../login/login_check.jsp" %>
<%@ include file="../inc/top.jsp"%>
<script type="text/javascript">
   $(function(){
      $('#memPwd').focus();
      
      $('#btn_coupon').click(function(){
    	  location.href="<%=request.getContextPath()%>/coupon/couponList.jsp";
      });
      
      
      $('.simpleForm form[name=frmOut]').submit(function(){
         if($('#memPwd').val().length<1){
            alert('비밀번호를 입력하세요');
            $('#memPwd').focus();
            event.preventDefault();
         }else{
            if(!confirm('탈퇴하시겠습니까?')){
               event.preventDefault();
               //return false;
            }
         }
      });
   });
</script>
<article class="simpleForm">
<div class="container" style="width:100%; height:500px;text-align: center;vertical-align: center;margin-top:100px;">
	
		<div class="YNcontainer" style="width:100%;text-align: center;vertical-align: center;">
			<h3 class="YNh3" style="margin-top:20px;">회원 탈퇴</h3>
<!-- 			<legend>회원 탈퇴</legend> -->
	<form name="frmOut" method="post" action="memberOut_ok.jsp" style="width:600px;margin: 0 auto;">
		<fieldset> 
			<%
			String memid=(String)session.getAttribute("memid");
			
			%>
			<div style="width:600px;border:1px solid #efefef; padding:20px; ">
			<p>회원탈퇴 시 쿠퐁에서 예약하신 예약건을 조회하실 수 없습니다.</p>
			<p class="p"><b><%=memid %>님</b> 회원탈퇴하시겠습니까?</p>
			</div>
			<!-- 첫번째 Form 그룹: 아이디 -->
				<div class="form-group" style="width:600px ; margin-top:60px; margin-bottom: 20px">
					<!-- <label for="memPwd" class="YNcontent-head label" >비밀번호를 입력하세요</label>  -->
					<input
						type="password" placeholder="비밀번호를 입력하세요" id="memPwd" name="memPwd"
						class="form-control infobox"> 
				</div>
	
			<div>
			<span><!-- 예약입력 완료 버튼 -->
				<input type=submit class="btn btn-secondary"
					style="width:40%; height:50px; margin-top: 10px; font-size:1.1em;" value="네, 탈퇴하겠습니다.">
				<input type=button name="btnCancel" id="btn_coupon" class="btn btn-primary"
					style="width:40%; height:50px; margin-top: 10px; font-size:1.1em;" value="쿠폰 보러 가기">
			</span>
		</div>
		
		
		</fieldset>
	</form>
		</div>
</div>
</article>

<%@ include file="../inc/bottom.jsp"%>