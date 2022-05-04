<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.cpn.reservation.model.ReservationService"%>
<%@page import="com.cpn.reservation.model.ReservationVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- top 인클루드 -->
<%@ include file="../inc/top.jsp"%>
<jsp:useBean id="myService" class="com.cpn.reservation.model.ReservationService"
 scope="page"></jsp:useBean>
<jsp:useBean id="reserveVo" class="com.cpn.reservation.model.ReservationVO"
 scope="page"></jsp:useBean>
<jsp:useBean id="coupVo" class="com.cpn.coupon.model.couponVO"
 scope="page"></jsp:useBean>
<jsp:useBean id="coupService" class="com.cpn.coupon.model.couponService"
 scope="page"></jsp:useBean>
<%
	int reserveNo = Integer.parseInt(request.getParameter("reserveNo"));
	int memNo = (Integer)session.getAttribute("memNo");
	
	try{
		reserveVo = myService.selectReserveByMemNo(memNo, reserveNo);
		int coupNo = reserveVo.getCoupNo();
		try{
			coupVo = coupService.selectByNo(coupNo);
		}catch(SQLException e){
			e.printStackTrace();
		}	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//세션에서 가져올 사용자 아이디, 이름 ,회원번호
	 	String memid = (String)session.getAttribute("memid");
		String memName = (String)session.getAttribute("memName");
// 참고1 : 상세화면에서 입력받는 값은 수량(reservePer), 수량*price로 계산된 총금액(reservePrice=reservePer*coupPrice) 

	//금액, 날짜 이쁘게
	SimpleDateFormat  sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("###,###,###");


%>
<script type="text/javascript">
   $(function(){
      
      $('#btn_backPage').click(function(){
       location.href= "<%=request.getContextPath()%>/reservation/myReserveList.jsp";
       
      });  
      
      $('input[name=btnCancel]').click(function(){
			var reserveNo=$(this).attr('id');
			var calcelConfirm = confirm('예약취소 후 되돌릴 수 없습니다. 취소하시겠습니까?');
		if($(this).prop('disabled', false)){	// 활성화상태이면
			if(calcelConfirm){
				location.href="reserveCancel.jsp?reserveNo="+reserveNo+"&coupNo=<%=reserveVo.getCoupNo()%>;
			}
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
<div id="YNwrap">
    <!-- header 시작 -->
    <div id="header_mainsize"  style="height:50px;margin:20px">
   <!--       <div id="cur_loc">
                    <div id="cur_loc_align" style="font-size:12px">
                        <ul>
                            <li style="display:inline; float: left;margin:10px">HOME</li>
                            <li style="display:inline; float: left;margin:10px">&gt;</li>
                            <li style="display:inline; float: left;margin:10px">마이페이지</li>
                            <li style="display:inline; float: left;margin:10px">&gt;</li>
                            <li style="display:inline; float: left;margin:10px">내 예약목록</li>
                            <li style="display:inline; float: left;margin:10px">&gt;</li>
                            <li style="display:inline; float: left;margin:10px"><strong>예약 상세정보</strong></li>
                        </ul>
                    </div>
                </div>
                -->
       </div> 
    <!-- //header 끝 --> 
       
       
    <!-- container 시작 -->
    <div id="YNcontainer">


	<!--좌측 사이드 바 메뉴-->
	<div class="col-md-3 YNside-bar" id="sideBar" style="float: left;">


		<!-- 	<!-- 사이드바 -->
		<div class="col-md-3 YNside-bar" id="YNside-bar" style="float: left;">
		
			<!-- 패널 타이틀1 -->
			<div class="panel panel-info">
				
				<!-- 사이드바 카테고리 -->
				<ul class="list-group" id="YNlist-group">
					<li class="list-group-item"><a href="<%=request.getContextPath() %>/member/memberEdit.jsp">내 정보 수정</a></li>
					<li class="list-group-item" style="background-color:#f5c8c8;">
					<a href="<%=request.getContextPath() %>/reservation/myReserveList.jsp">내 예약목록</a></li>
					<li class="list-group-item"><a href="<%=request.getContextPath() %>/like/myLike.jsp">내 관심목록</a></li>
					<li class="list-group-item"><a href="<%=request.getContextPath()%>/member/memberOut.jsp">회원탈퇴</a></li>
				</ul>
				
				
			</div>
		</div>
	
        
        
    </div>
        <!-- //좌측메뉴 끝 -->
             <!-- 현재위치 네비게이션 시작 -->
            <div class="col-md-8" id="content" style="display:inline; float: left;">
              
                <!--     <DIV id="content2" style="width:712px;"> -->
<div class="clearfix"></div>

		<h4 class="YNalign-center YNh4" style="clear:both; margin-bottom:30px;">예약 상세 정보</h4>

			<table class="YNtable"
				style="font-weight: bold; color: #666; margin: 0 auto">
				<tbody>
					<!--이름-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right YNborder-left">이름</td>
						<td class="YNinput-text"><span>
						<input type="text" name="memName" id="memName" class="YNinput-none" 
						readOnly="readOnly" disabled="disabled" value="<%=memName%>"></span></td>
					</tr>
					<!--아이디-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">회원 아이디</td>
						<td class="YNinput-text"><span>
						<input type="text" name="memid" id="memid" class="YNinput-none" 
						readOnly="readOnly" disabled="disabled" value="<%=memid%>"></span> 
						</td>
					</tr>

					<!--회원번호-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">회원 번호</td>
						<td class="YNinput-text"><span>
						<input type="text" name="memNo" id="memNo" class="YNinput-none" 
						readOnly="readOnly" disabled="disabled" value="<%=memNo%>"></span>
								<!--  value="memNo" --> 
						</td>
					</tr>

					<!--쿠폰번호-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">쿠폰번호</td>
						<td class="YNinput-text"><span>
						<input type="text" name="memid" id="memid" class="YNinput-none" 
						readOnly="readOnly" disabled="disabled" value="<%=reserveVo.getCoupNo()%>"></span> 
								<!--  value="coupName -->
						</td>
					</tr>

					<!--쿠폰명-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">쿠폰명</td>
						<td class="YNinput-text"><span>
						<input type="text" name="coupName" id="coupName" class="YNinput-none" 
						readOnly="readOnly" disabled="disabled" value="<%=coupVo.getCoupName()%>"></span> 
							 <!-- value="coupName" -->
						</td>
					</tr>

					<!--예약수량-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">예약수량</td>
						<td class="YNinput-text"><span><input type="text" readOnly="readOnly" disabled="disabled"
								name="reservePer" id="reservePer" class="YNinput-none" value="<%=reserveVo.getReservePer()%>"></span> 
							 <!-- value="reservePer" -->
						</td>
					</tr>

					<!--예약 총금액-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">총 예약 금액(원)</td>
						<td class="YNinput-text"><span><input type="text" readOnly="readOnly" disabled="disabled"
								name="reservePrice" id="reservePrice" class="YNinput-none" value="<%=df.format(reserveVo.getReservePrice()) %>"></span> 
							 <!-- value="reservePrice" -->
						</td>
					</tr>
					

					<!--사용기한 시작일-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">사용기한 시작일</td>
						<td class="YNinput-text"><span><input type="text"
								name="memid" id="memid" class="YNinput-none"  readOnly="readOnly" disabled="disabled"
								readOnly value="<%=sdf.format(coupVo.getCoupStartDate())%>"></span>
								<!--  value="coupStartDate" --> 
						</td>
					</tr>
					
					<!--사용 종료일-->
					<tr class="YNborder-bottom">
						<td class="YNtext-label YNalign-right  YNborder-left">사용기한 종료일</td>
						<td class="YNinput-text"><span><input type="text"
								name="memid" id="memid" class="YNinput-none" readOnly="readOnly" disabled="disabled"
								readOnly value="<%=sdf.format(coupVo.getCoupEndDate())%>"></span> 
								<!--  value="coupEndDate" --> 
						</td>
					</tr>
					
					
			</table>
			<!-- 예약정보 값 세팅 끝 -->
			
			<!-- Submit 버튼 -->

			<div style="text-align: center">
<div style="color:red;font-size:0.9em;text-align:center;line-height:2">*예약 취소는 사용기한 만료 1일 전 까지만 가능합니다.</div> 
			<span><!-- 예약입력 완료 버튼 -->
				<a href="<%=request.getContextPath()%>/coupon/couponList.jsp">
				<input type=button class="btn btn-primary" id="btn_backPage"
					style="width:35%; height:50px; margin-top: 50px; font-size:1.1em;" value="목록으로">
				</a>
				<input type=button name="btnCancel" id="<%= reserveNo %>"
				 <%	 Timestamp curTime = new Timestamp(System.currentTimeMillis());
							    if((coupVo.getCoupEndDate()).before(curTime)){%>
								    disabled="disabled"
								    value="취소불가"
								    class="btn btn-secondary" 
							  <%}else{ %> 
								    value="예약취소"
								    class="btn btn-warning" 
							  <%}%> 
					style="width:35%; height:50px; margin-top: 50px; font-size:1.1em;" value="목록으로">
			</span>
			
	
			

			</div>
			</div>


	</div><!-- 전체 박스 -->
	</div><!-- YNwrap -->
</article>

<div style="height:100px;clear:both;"></div>
<%@ include file="../inc/bottom.jsp"%>
