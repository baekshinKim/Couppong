<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.cpn.reservation.model.ReservationVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- top 인클루드 -->
 <%@ include file="../inc/top.jsp"%>
<jsp:useBean id="reserveService" class="com.cpn.reservation.model.ReservationService" scope="page">
</jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");

//할일1 : 입력값 가져와서 DB작업 isnertReservation 하기


// 참고1 : 상세화면에서 입력받는 값은 수량(reservePer), 수량*price로 계산된 총금액(reservePrice=reservePer*coupPrice) 
// 참고2: 예약등록에서 넘겨받을 값은 -> 사용자 아이디, 이름, 회원번호, 쿠폰번호, 수량, 총금액(reservePrice), 시작일(), 종료일()

//세션에서 가져올 사용자 아이디, 이름 ,회원번호
 	String memid = (String)session.getAttribute("memid");
	String memName = (String)session.getAttribute("memName");
	int memNo = (Integer)session.getAttribute("memNo");
	
// 쿠폰상세에서 파라미터 넘겨받을 값은 -> 쿠폰번호, 수량, 총금액(reservePrice), 시작일(), 종료일()
 	String coupName = request.getParameter("coupName");
	String coupNo = request.getParameter("coupNo");
	
//총금액은 계산할 값 <- 예약 총금액 = 수량*쿠폰가격 
	String reservePer = request.getParameter("reservePer");	//수량
	String coupPrice = request.getParameter("coupPrice");	//쿠폰가격
	int reservePrice =Integer.parseInt(reservePer)*Integer.parseInt(coupPrice);	// 예약 총금액 = 수량*쿠폰가격 
	//reservePrice =50000
	
//사용기한 : 시작일~종료일
	String str_coupStartDate = request.getParameter("coupStartDate");
	String str_coupEndDate = request.getParameter("coupEndDate");
	
	//금액, 날짜 이쁘게
	SimpleDateFormat  sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("###,###,###");

 	Date coupStartDate = sdf.parse(str_coupStartDate);
 	Date coupEndDate = sdf.parse(str_coupEndDate);
	
%>
<script type="text/javascript">
   $(function(){
	
      $('#btn_backPage').click(function(){
    	  alert("예약취소되었습니다, 예약정보를 다시 선택해주세요");
	      history.back();
	      return false;
      });   
      
      /* 동의에 체크여야 submit 진행 */
	$('#reserve_submit').click(function(){
			if(!$('#chkAgree').is(":checked")){
				alert('예약정보를 확인 후 체크하시면 예약할 수 있습니다.');
				$('#chkAgree').focus();
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
<div class="container" style="margin-top:50px;">


	<div style="padding: 0; float: left; width: 1080px;margin: 0 auto">
		<h3 class="YNalign-center YNh4">예약 정보 확인</h3>
		<form name="reserveFrm" method="post" action="reserveInsert_ok.jsp">


			<table class="YNtable2" 
				style="font-weight: bold; color: #666; margin: 0 auto; ">
				<tbody style="width: 1080px;">
					<!--이름-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">이름</td>
						<td class="YNinput-text"><span>
						<input type="text" name="memName" id="memName" class="YNinput-none" 
						readOnly value="<%=memName%>"></span></td>
					</tr>
					<!--아이디-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">회원 아이디</td>
						<td class="YNinput-text"><span>
						<input type="text" name="memid" id="memid" class="YNinput-none" 
						readOnly value="<%=memid%>"></span> 
						</td>
					</tr>

					<!--회원번호-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">회원 번호</td>
						<td class="YNinput-text"><span>
						<input type="text" name="memNo" id="memNo" class="YNinput-none" 
						readOnly value="<%=memNo%>"></span>
								<!--  value="memNo" --> 
						</td>
					</tr>

					<!--쿠폰번호-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">쿠폰번호</td>
						<td class="YNinput-text"><span>
						<input type="text" name="coupNo" id="coupNo" class="YNinput-none" 
						readOnly  value="<%=coupNo%>"></span> 
								<!--  value="coupName -->
						</td>
					</tr>

					<!--쿠폰명-->
					<tr class="YNborder-bottom ">
						<td class="YNtext-label YNalign-right  YNborder-left">쿠폰명</td>
						<td class="YNinput-text"><span>
						<input type="text" name="coupName" id="coupName" class="YNinput-none" 
						readOnly value="<%=coupName%>"></span> 
							 <!-- value="coupName" -->
						</td>
					</tr>

					<!--예약수량-->
					<tr class="YNborder-bottom ">
						<td class="YNtext-label YNalign-right  YNborder-left">예약수량(장)</td>
						<td class="YNinput-text"><span><input type="text"  readonly="readonly"
								name="reservePer" id="reservePer" class="YNinput-none" value="<%=reservePer%>"></span> 
							 <!-- value="reservePer" -->
						</td>
					</tr>

					<!--예약 총금액-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">총 예약금액(원)</td>
						<td class="YNinput-text"><span><input type="text" readonly="readonly"
								name="reservePrice" id="reservePrice" class="YNinput-none" value="<%=reservePrice%>"></span> 
							 <!-- value="reservePrice" -->
						</td>
					</tr>
					

					<!--사용기한 시작일-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">사용기한 시작일</td>
						<td class="YNinput-text"><span><input type="text" readonly="readonly"
								name="coupStartDate" id="coupStartDate" class="YNinput-none" 
								value="<%=sdf.format(coupStartDate) %>"></span>
								<!--  value="coupStartDate" --> 
						</td>
					</tr>
					
					<!--사용 종료일-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">사용기한 종료일</td>
						<td class="YNinput-text"><span><input type="text" readonly="readonly"
								name="coupEndDate" id="coupEndDate" class="YNinput-none" 
								readOnly value="<%=sdf.format(coupEndDate)%> "></span> 
								<!--  value="coupEndDate" --> 
						</td>
					</tr>
					
					
			</table>
			<!-- 예약정보 값 세팅 끝 -->

			
			<!-- Submit 버튼 -->
<div style="color:red;font-size:1em;text-align:center;line-height:2;margin:0">
	                    *예약 취소는 사용기한 만료 1일 전 까지만 가능합니다.</div>
	                     
			<div style="text-align: center">
	        <div>
			<input type="checkbox" name="chkAgree" id="chkAgree" style="zoom:1.5;">
			<label for="chkAgree" style="margin-top: 10px; font-size:1.1em;line-height: 1.5">예약정보를 확인하였습니다.</label>
			 </div>    
			<span><!-- 예약안하기 -->
				<input type=submit class="btn btn-secondary" id="btn_backPage"
					style="width: 25%; height:50px; margin-top: 30px; font-size:1.1em;" value="이전 단계로">
			</span>
			<span><!-- 예약하기 -->
				<input type="submit" class="btn btn-primary" id="reserve_submit" 
					style="width: 25%; height:50px; margin-top: 30px; font-size:1.1em;" value="예약하기">
			</span>
			</div>

		</form>



	</div><!-- container-->
	</div><!-- 전체 박스 -->
</article>

<div style="height:100px;clear:both;"></div>
<%@ include file="../inc/bottom.jsp"%>
