<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- top 인클루드 -->
 <%@ include file="../inc/top.jsp"%>
 
<!-- 아이디중복확인 / 유효성검사 js-->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/member.js"></script>


<!--부트css-->
<!--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous"> -->
<!--이나css-->




<script type="text/javascript">
	$(function() {
		$('#wr_submit').click(
				function() {
					//이름 필수입력
					if ($('#memName').val().length < 1) {
						alert('이름을 입력하세요');
						$('#memName').focus();
						event.preventDefault();

					//아이디유효성검사 : validate_userid
					} else if (!validate_userid($('#memid').val())) {
						alert('아이디는 영문,숫자,_만 가능합니다.');
						$('#memid').focus();
						event.preventDefault();
						
						
					//비번일치 검사
					} else if ($('#memPwd').val().length < 1) {
						alert('비밀번호를 입력하세요');
						$('#memPwd').focus();
						event.preventDefault();
					} else if ($('#memPwd').val() != $('#memPwd2').val()) {
						alert('비밀번호가 일치하지 않습니다.');
						$('#memPwd2').focus();
						event.preventDefault();
					} else if (!validate_phone($('#hp2').val())
							|| !validate_phone($('#hp3').val())) {
						alert('전화번호는 숫자만 가능합니다.');
						$('#hp2').focus();
						event.preventDefault();
					} else if ($('#chkId').val() != 'Y') {
						alert('아이디 중복확인하세요');
						$('#btnChkId').focus();
						event.preventDefault();
					}
				});

	});

	
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

	<div style="height:50px;"></div>
	<div class="container" style="margin: 0 auto;width: 1120px;">
 

	<div id="YNcenter-box" style="padding: 0; float: left; width: 900px;">
		<h3 class="YNalign-center YNh3">SIGN IN</h3>
		<form name="frm1" method="post" action="register_ok.jsp">


			<table class="YNtable"
				style="font-weight: bold; color: #666; margin: 0 auto">
				<tbody>
					<!--이름-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">이름</td>
						<td class="YNinput-text"><span><input type="text"
								 name="memName" id="memName" class="YNinput-none"></span></td>
					</tr>
					<!--아이디-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">회원 아이디</td>
						<td class="YNinput-text"><span><input type="text"
								name="memid" id="memid" class="YNinput-none"></span> 
								<span><input
								type="button" name="idcheck" id="btnChkId" class="YNinput-btn"
								value="중복확인" title="새창열림"></span></td>								
					</tr>

					<!--비밀번호-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">비밀번호</td>
						<td class="YNinput-text"><span><input type="password"
								name="memPwd" id="memPwd" class="YNinput-none"></span></td>
					</tr>

					<!--비밀번호 확인-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">비밀번호 확인</td>
						<td class="YNinput-text"><span><input type="password"
								name="memPwd2" id="memPwd2" class="YNinput-none"></span></td>
					</tr>


					<!--주소-->
					<tr class="YNborder-bottom" style="padding-top: 5px;">
						<td class="YNtext-label YNalign-right YNborder-left">주소</td>
						<td class="YNinput-text"><span><input type="text"
								name="memAddress" id="memAddress" class="YNinput-none width_350"
								title="주소"></span></td>
					</tr>

					<!--연락처-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">연락처</td>
						<td class="YNinput-text" style="color: #666; font-weight: normal">
							<span> <select class="YNinput-tel" name="hp1" id="hp1"
								title="휴대폰 앞자리">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
							</select>
						</span> - <span><input type="text" name="hp2" id="hp2"
								maxlength="4" title="휴대폰 가운데자리" class="YNinput-tel width_80"></span>
							- <span><input type="text" name="hp3" id="hp3"
								maxlength="4" title="휴대폰 끝자리" class="YNinput-tel width_80"></span>

						</td>
					</tr>

					<!--이메일-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">이메일</td>
						<td class="YNinput-text" style="color: #666; font-weight: normal">
							<span><input type="text" name="email1" id="email1"
								title="이메일주소 앞자리" class="YNinput-tel"></span>@<span> <select
								class="YNinput-tel" name="email2" id="email2" title="이메일주소 뒷자리">
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="nate.com">nate.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="etc">직접입력</option>
							</select>
						</span> <span>&nbsp;<input type="text" name="email3" id="email3"
								title="직접입력인 경우 이메일주소 뒷자리" style="visibility: hidden"
								class="YNinput-tel"></span> <br>
						</td>
					</tr>
			</table>
			<!-- 입력끝 -->
			

			<!-- Submit 버튼 -->
			<div style="text-align: center">
				<button type="submit" class="btn btn-primary" id="wr_submit"
					style="width: 55%; height:50px; margin-top: 50px; font-size:1.1em;">회원가입</button>
			</div>
			<input type ="hidden" name="chkId" id="chkId">
			<!-- 중복확인용, 최종테스트 후 hidden으로 바꿀예정 -->
		</form>

	</div><!-- container-->
	</div><!-- 전체 박스 -->
</article>

<div style="height:100px;clear:both;"></div>
<%@ include file="../inc/bottom.jsp"%>
