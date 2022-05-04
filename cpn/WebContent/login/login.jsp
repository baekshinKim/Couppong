<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%><!-- top에 yncss.css추가함 -->
<!-- 기본제이쿼리라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.5.1.min.js"></script>
<!-- 아이디중복확인 / 유효성검사 js-->
<script type="text/javascript" src="<%=request.getContextPath() %>/js/member.js"></script>

<script type="text/javascript">
   $(function(){
      $('#memid').focus();
      
      $('form[name=frmLogin]').submit(function(){
         $('.infobox').each(function(idx, item){
            if($(this).val().length<1){
               alert($(this).prev().text()+"를 입력하세요");
               $(this).focus();
               event.preventDefault();
               return false;
            }            
         });
      });      
   });
</script>
<%
   //쿠키 읽어오기
   String ckValue="";
   Cookie[] ckArr=request.getCookies();
   if(ckArr!=null){
      for(int i=0; i<ckArr.length; i++){
         if(ckArr[i].getName().equals("ck_memid")){
            ckValue=ckArr[i].getValue();
            break;
         }
      }//for
   }
%>
<div class="container" style="width:100%; ">
	<div style="width: 900px;  padding: 100px;">
		<h3 class="YNalign-center YNh3" >LOG IN</h3>
		<!-- style="font-weight: 600;text-align: center; font-size: 3em; -->
		<article class="simpleForm"
			style="width: 100%; background-color: #ffffff; padding: 100px;">
	
	
			<form name="frmLogin" method="post" action="login_ok.jsp">
				<fieldset>
					<legend></legend>
					<!-- 첫번째 Form 그룹: 아이디 -->
					<div class="form-group">
						<label for="memid" class="YNcontent-head label">아이디</label> <input
							type="text" placeholder="Enter ID" id="memid" name="memid"
							class="form-control infobox" 
							<%if(ckValue!=null){ %>
							value="<%=ckValue%>">
							<%}%>
						<!-- 쿠키읽어보고 값이 있으면 아이디저장 -->
					</div>
	
	
					<!-- 두번째 Form 그룹: 비밀번호 -->
					<div class="form-group YNmargin-top">
						<label for="memPwd" class="YNcontent-head label">비밀번호</label> <input
							type="password" placeholder="Enter Password" id="pwd"
							name="memPwd" class="form-control infobox">
					</div>
	
					<div class="YNlogin-chk YNmargin-top align_center"
						style="align-content: center">
	
						<!-- 아이디저장체크 (체크 박스) -->
						<div class="form-check" style="width: 50%; float: left">
							<input type="checkbox" class="form-check-input" id="chkSave"
								name="chkSave" <%if(ckValue!=null && !ckValue.isEmpty()){%>
								checked="checked" <%}%>> <label
								class="form-check-label" for="chkSave">아이디저장</label>
						</div>
	
						<!-- 관리자로그인 (체크 박스) -->
						<div class="form-check" style="width: 50%; float: left;">
							<input type="checkbox" class="form-check-input" id="chkAdmin"
								name="chkAdmin" value="yyy"> <label
								class="form-check-label" for="chkAdmin">관리자</label> <small
								id="emailHelp" class="YNsmall-info">&nbsp;관리자 계정만 체크</small>
						</div>
	
					</div>
	
					<!-- Submit 버튼 -->
					<div class="form YNalign-center YNmargin-top YNfull-btn"
						style="clear: both">
						<button type="submit" class="btn btn-primary YNfull-btn">로그인</button>
					</div>
	
				</fieldset>
			</form>
		</article>
	</div>
</div>
<%@ include file="../inc/bottom.jsp"%>