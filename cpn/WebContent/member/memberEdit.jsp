<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.member.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ include file="../inc/top.jsp"%>
 <%@ include file="../login/login_check.jsp" %>
<!-- 아이디중복확인 / 유효성검사 js-->
<script type="text/javascript" src="../js/member.js"></script>
 
<!-- 기본제이쿼리라이브러리 
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script> 


<!--부트css
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
이나css-->
<!-- <link a href="../css/yncss.css" rel="stylesheet" type="text/css"/>  --><!-- 빼지마세요 css안먹음 / 1226작성-->

<jsp:useBean id="memService" class="com.cpn.member.model.MemberService"
	scope="page"></jsp:useBean>										
										
<%
	/* userid세션에서 읽어오기 */
	String memid=(String)session.getAttribute("memid");	//로그인할 때 입력받는 값으로 set해둔 key값
	String memName=(String)session.getAttribute("memName");	//로그인할 때 입력받는 값으로 set해둔 key값
	String memEmail =(String)session.getAttribute("memEmail");	//로그인할 때 입력받는 값으로 set해둔 key값
	
	MemberVO vo = null;
	try{
		vo = memService.selectMember(memid);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String memAddress = vo.getMemAddress();
	//"null"들어가니까  null체크
	if(memAddress==null) memAddress="";
	
	//전화번호, 이메일 split	
	String hp = vo.getMemTel();
	
	String hp1="", hp2="", hp3=""; 
	String email1="", email2="", email3="";
	
	if(hp != null && !hp.isEmpty()){	//010-1000-1000
		String[] hpArr = hp.split("-");
		hp1 = hpArr[0];
		hp2 = hpArr[1];
		hp3 = hpArr[2];
	}

	
	String[] emailList = {"naver.com","hanmail.net","nate.com","gmail.com",};
	
	boolean isEtc = false; //직접입력아닌경우 false
	int count=0; 
	
	if(memEmail != null && !memEmail.isEmpty()){	// emailid@naver.com , 직접입력 / 있는거선택
		String[] emailArr = memEmail.split("@");
		email1 = emailArr[0];	//이메일아이디부분
		email2 = emailArr[1];	//이메일 도메인부분
		
		//emailList안에 없으면 'etc'인것 
		for(int i=0; i<emailList.length;i++  ){
			String s_email = emailList[i];
			if(email2.equals(emailList[i])){
				count++;	//있으면 ++하고 빠짐
				break;
			}
		}//for
		
		//count가 
		if(count==0){	//++안된경우는 
			isEtc = true;	//직접입력값인경우
		}
	}
	
	
%>


<script type="text/javascript" src="../js/member.js"></script>
<script type="text/javascript">
	$(function(){
		$('#wr_submit').click(function(){
					
			if($('#memPwd').val().length<1){
				alert('비밀번호를 입력하세요');
				$('#memPwd').focus();
				event.preventDefault();
			}else if((!validate_phone($('#hp2').val()))||(!validate_phone($('#hp3').val()))){
				alert('전화번호는 숫자만 가능합니다.');
				$('#hp2').focus();
				event.preventDefault();		
			}
		
		});
		
		
	});//1212js지움

	//숫자일때 true
	function validate_phone(tel){
		var pattern = new RegExp(/^[0-9]*$/g);
		return pattern.test(tel);
		/*
			0 에서 9사이의 숫자로 시작하거나 끝나야 한다는 의미 (^는 시작, $는 끝을 의미)
			닫기 대괄호(]) 뒤의 * 기호는 0번 이상 반복
		*/
	}
</script>

<style type="text/css">
	.width_80{
		width:80px;
	}
	.width_350{
		width:350px;
	}	


</style>

<article>
	<div style="height:100px;"></div>
	<div class="container" style="height:100px;">

	<!-- 사이드 바 메뉴-->
	<div class="col-md-3 YNside-bar" id="sideBar" style="float: left;">


		<!-- 	<!-- 사이드바 -->
		<div class="col-md-3 YNside-bar" id="YNside-bar" style="float: left;">
		
			<!-- 패널 타이틀1 -->
			<div class="panel panel-info">
				
				<!-- 사이드바 카테고리 -->
				<ul class="list-group" id="YNlist-group">
					<li class="list-group-item" style="background-color:#f5c8c8;"><a href="#">내 정보 수정</a></li>
					<li class="list-group-item"><a href="<%=request.getContextPath() %>/reservation/myReserveList.jsp">내 예약목록</a></li>
					<li class="list-group-item"><a href="#">내 관심목록</a></li>
					<li class="list-group-item"><a href="memberOut.jsp">회원탈퇴</a></li>
				</ul>
				
				
			</div>
		</div>
	




	</div>



	<div id="YNcenter-box" style="padding: 0; float: left; width: 900px;">
		<h3 class="YNalign-center YNh3">회원 정보 수정</h3>
		<div class="divForm" style="height:100%;">
		<form name="frm1" method="post" action="memberEdit_ok.jsp">
<fieldset>

<!--  
		수정할때는 이름이랑 아이디는 수정안되게 span으로 바꾸고 ,
		비번은 빈칸 , 
		나머지정보는 수정되게 value 셋팅
	-->
	
	<!--  
		userid세션에서 읽어오고 
		핸드폰이메일 제외한 나머지 넣기
	-->

			<table class="YNtable"
				style="font-weight: bold; color: #666; margin: 0 auto">
				<tbody>
					<!--이름-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">이름</td>
						<td class="YNinput-text"><span><input type="text"
								name="memName" id="memName" class="YNinput-none" readOnly="readOnly"
								value="<%=memName%>"></span></td>
					</tr>
					<!--아이디-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">회원 아이디</td>
						<td class="YNinput-text">
						<span><input type="text" name="memid" id="memid" class="YNinput-none"
						readOnly="readOnly" value="<%=memid%>"></span> 
					</tr>

					<!--비밀번호-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">비밀번호</td>
						<td class="YNinput-text"><span><input type="password"
								name="memPwd" id="memPwd" class="YNinput-none"></span></td>
					</tr>

					<!--주소-->
					<tr class="YNborder-bottom" style="padding-top: 5px;">
						<td class="YNtext-label YNalign-right YNborder-left">주소</td>
						<td class="YNinput-text"><span><input type="text"
								name="memAddress" id="memAddress" class="YNinput-none width_350"
								title="주소" value="<%=memAddress%>"></span></td>
					</tr>

					<!--연락처-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">연락처</td>
						<td class="YNinput-text" style="color: #666; font-weight: normal">
							<span> <select class="YNinput-tel" name="hp1" id="hp1"
								title="휴대폰 앞자리">
									<option value="010"
					            	<%if(hp1.equals("010")){ %>
					            		selected=""
					            	<%} %>
					            	>010</option>
					            <option value="011"
					            	<%if(hp1.equals("011")){ %>
					            		selected="selected"
					            	<%} %>>011</option>
					            <option value="016"
					            	<%if(hp1.equals("016")){ %>
					            		selected="selected"
					            	<%} %>
					            >016</option>
					            <option value="017"
					            	<%if(hp1.equals("017")){ %>
					            		selected="selected"
					            	<%} %>
					            >017</option>
					            <option value="018"
					            	<%if(hp1.equals("018")){ %>
					            		selected="selected"
					            	<%} %>
					            >018</option>
					            <option value="019"
					            	<%if(hp1.equals("019")){ %>
					            		selected="selected"
					            	<%} %>
					            >019</option>
					       	</select></span>
					       	- <span><input type="text" name="hp2" id="hp2" value="<%=hp2 %>"
								maxlength="4" title="휴대폰 가운데자리" class="YNinput-tel width_80"></span>
							- <span><input type="text" name="hp3" id="hp3" value="<%=hp3 %>"
								maxlength="4" title="휴대폰 가운데자리" class="YNinput-tel width_80"></span>
						</td>
					</tr>

					<!--이메일-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">이메일</td>
						<td class="YNinput-text" style="color: #666; font-weight: normal">
							<span><input type="text" name="email1" id="email1" value="<%=email1%>"
								title="이메일주소 앞자리" class="YNinput-tel" >
							</span>@<span>
							<select	class="YNinput-tel" name="email2" id="email2" title="이메일주소 뒷자리">
									<option value="naver.com"
					            	<%if(email2.equals("naver.com")){ %>
					            		selected="selected"
					            	<%} %>
					            >naver.com</option>
					            <option value="hanmail.net"
					            	<%if(email2.equals("hanmail.net")){ %>
					            		selected="selected"
					            	<%} %>
					            >hanmail.net</option>
					            <option value="nate.com"
					               <%if(email2.equals("nate.com")){ %>
					            		selected="selected"
					            	<%} %>
					            >nate.com</option>
					            <option value="gmail.com"
					               <%if(email2.equals("gmail.com")){ %>
					            		selected="selected"
					            	<%} %>
					            >gmail.com</option>
					            <option value="etc"
					               <%if(isEtc){ %>
					            		selected="selected"
					            	<%} %>
					            >직접입력</option>
					        </select>
						</span> <span>&nbsp; <input type="text" name="email3" id="email3" 
						class="YNinput-tel" title="직접입력인 경우 이메일주소 뒷자리"
				                <%if(isEtc){ %>
									style="visibility:visible;"
									value="<%=email2 %>"
				            	<%}else{ %>
									style="visibility:hidden"
				            	<%}%>
				        	></span>
				        	<br>
						</td>
					</tr>
			</table>
			<!-- 입력끝 -->
</fieldset>

	    <!-- Submit 버튼 : 회원정보 수정-->
    <div class="center" style="text-align: center;">
		<button type="submit" class="btn btn-primary"  id="wr_submit" 
			style="width: 55%; height:50px; margin-top: 50px; font-size:1.1em;">수정 완료</button>
	</div>
    
        
</form><!-- frm1 -->
</div><!-- divForm -->
</div><!-- YNcenterBox -->
</div><!-- container-->
</article>
<div style="height:100px;clear:both;"></div>

<%@ include file="../inc/bottom.jsp"%>
