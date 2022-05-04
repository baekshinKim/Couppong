<%@page import="com.cpn.common.util"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.cpn.coupon.model.couponService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.reservation.model.ReservationVO"%>
<%@page import="com.cpn.reservation.model.ReservationService"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ include file="../inc/top.jsp"%>
 <%@ include file="../login/login_check.jsp" %><!-- 로그인해야만 예약목록 확인 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="myService" class="com.cpn.reservation.model.ReservationService"
 scope="page"></jsp:useBean>
<jsp:useBean id="reserveVO" class="com.cpn.reservation.model.ReservationVO"
 scope="page"></jsp:useBean>
<jsp:useBean id="coupVo" class="com.cpn.coupon.model.couponVO"
 scope="page"></jsp:useBean>
<jsp:useBean id="coupService" class="com.cpn.coupon.model.couponService"
 scope="page"></jsp:useBean>
<%

/************************
	세션에 꼭 저장된 회원정보
	1. 회원번호 memNo
	2. 아이디 memid
	3. 비번	memPwd
	4. 이름	memName
	5. 이메일	memEmail
	6. 권한번호 rigNo
*************************/
	request.setCharacterEncoding("utf-8");//일단인코딩
	
	//[1] index에서 로그인 안하고 들어오는 경우 -> (memNo==null)로그인하세요체크 include
	//[2] index에서 로그인 하고 들어오는 경우 -> memNo!=null인경우 : get
	//[3] couponDetail.jsp에서 예약하고 들어오는 경우 -> post 
	
	int memNo = (Integer)session.getAttribute("memNo");
   if(!(memNo != 0)){%>
      <script type="text/javascript">
         alert("마이페이지 이용은 회원만 가능합니다, 로그인해주세요");
         location.href="../login/login.jsp";
      </script>
   <%} 
   String memid = (String)session.getAttribute("memid");
	
	//Detail.jsp에서 가져온건 수량,쿠폰번호
	
	//1. 마이페이지 > 예약목록클릭 ===> [세션값가지고 get으로 넘어옴]회원번호로 전첸예약목록 가져와서 취소가능여부에 따라 표시하기 
	//selectMyReserve
	List<ReservationVO> list = null;
	try{
		list=myService.selectMyReserve(memNo);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//2. 쿠폰상세페이지 > 예약등록 ===> [입력+세션+쿠폰정보 가지고 post로 넘어옴]회원번호 , 쿠폰번호, 기외 정보들로 예약등록 후 다시 예약목록 보여주기   
	
	//사용자 입력값 + 인서트될 때 계산된 per값
	String reservePer = request.getParameter("reservePer");
	String coupPrice = request.getParameter("coupPrice");
	
	//세션정보는 위에 받아둠
	
	//쿠폰번호, 쿠폰명,시작일, 종료일

%> 
<link href="<%=request.getContextPath()%>/css/common.css" rel="stylesheet" type="text/css" ><!-- common.css추가함 -->

     <style TYPE="text/css"> 
/*      body { 
	        scrollbar-face-color: #F6F6F6; 
	        scrollbar-highlight-color: #bbbbbb; 
	        scrollbar-3dlight-color: #FFFFFF; 
	        scrollbar-shadow-color: #bbbbbb; 
	        scrollbar-darkshadow-color: #FFFFFF; 
	        scrollbar-track-color: #FFFFFF; 
	        scrollbar-arrow-color: #bbbbbb;
	        margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
        } */
        
        td {font-family: sans-serif; font-size: 14pt; color:#595959;}
        tr:hover{font-family: sans-serif; background-color:rgba(245, 200, 200,0.3);}
        tr a:hover{text-decoration:none; }
        th {font-family: sans-serif; font-size: 14pt; color:#000000;}
        select {font-family: sans-serif; font-size: 14pt; color:#595959;}
        
        
        .divDotText {
        overflow:hidden; 
        text-overflow:ellipsis;
        }
        
        A:link { font-size:12pt; color:#666; text-decoration:none; font-weight:normal;}
     /*    A:visited { font-size:14pt; font-family:sans-serif;color:#666; text-decoration:none; } */
        A:active { font-size:14pt; font-family:sans-serif;color:red; text-decoration:none; }
    /*     A:hover {  font-family:sans-serif;color:red;text-decoration:none;} */

		YNside-li:hover{
		background-color: #F9C8C8;
		color: #fff;
	} 

        
    </style>
<script type="text/javascript">	
$(function(){
	$('input[name=btnCancel]').click(function(){
			var reserveNo=$(this).attr('id');
			var calcelConfirm = confirm('예약취소 후 되돌릴 수 없습니다. 취소하시겠습니까?');
		if($(this).prop('disabled', false)){	// 활성화상태이면
			if(calcelConfirm){
				location.href="reserveCancel.jsp?reserveNo="+reserveNo+"&coupNo="+$(this).parent().next().find("#coupNo").val();
			}
		}

	});	
});

</script>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->

<div id="YNwrap">
 <!-- header 시작 -->
    <div id="header_mainsize"  style="height:50px;margin:20px"></div>
   <!--  <div id="header_mainsize"  style="height:50px;margin:20px">
         <div id="cur_loc">
                    <div id="cur_loc_align" style="font-size:14px">
                        <ul>
                            <li style="display:inline; float: left;margin:10px">HOME</li>
                            <li style="display:inline; float: left;margin:10px">&gt;</li>
                            <li style="display:inline; float: left;margin:10px">마이페이지</li>
                            <li style="display:inline; float: left;margin:10px">&gt;</li>
                            <li style="display:inline; float: left;margin:10px"><strong>내 예약목록</strong></li>
                        </ul>
                    </div>
          </div>
               
     </div>  -->
    <!-- //header 끝 --> 
       


    <!-- container 시작 -->
    <div id="YNcontainer">


        
	<!-- 사이드 바 메뉴-->
	<div class="col-md-3 YNside-bar" id="sideBar" style="float: left;">

		<!-- 	<!-- 사이드바 -->
		<div class="col-md-3 YNside-bar" id="YNside-bar" style="float: left;">
		
			<!-- 패널 타이틀1 -->
			<div class="panel panel-info">
				
				<!-- 사이드바 카테고리 -->
				<ul class="list-group" id="YNlist-group">
					<li class="list-group-item"><a href="<%=request.getContextPath() %>/member/memberEdit.jsp">내 정보 수정</a></li>
					<li class="list-group-item" style="background-color:#f5c8c8;"><a href="<%=request.getContextPath() %>/reservation/myReserveList.jsp">내 예약목록</a></li>
					<li class="list-group-item"><a href="<%=request.getContextPath() %>/like/myLike.jsp">내 관심목록</a></li>
					<li class="list-group-item"><a href="<%=request.getContextPath()%>/member/memberOut.jsp">회원탈퇴</a></li>
				</ul>
				
				
			</div>
		</div>
        
    </div>
    
    
    
        <!-- //좌측메뉴 끝 -->
             <div class="col-md-8" id="content" style="display:inline; float: left;width:1120px;">
                <!-- 
                <form name="deptSchdulManageVO" id="deptSchdulManageVO" action="" method="post"> -->
                <!--     <input type="submit" id="invisible" class="invisible"/> -->
        
		                <!-- table add start -->
		                <div class="default_tablestyle" id="content"  style="display:inline; float: left;">
	                  
 						<div style="color:red;font-size:1em;text-align:right;line-height:2;margin:0">
	                    *예약 취소는 사용기한 만료 1일 전 까지만 가능합니다.</div> 
	                    
	                                       
	                    <table style="border:1px solid #dddddd;margin-bottom:20px;">
		                    <caption>예약목록조회 테이블</caption>
		                    <colgroup>
    		                    <col width="10%" >
    		                    <col width="17%" >  
    		                    <col width="23%" >
    		                    <col width="15%" >
    		                    <col width="25%" >
    		                    <col width="15%" >
		                    </colgroup>
		                    <thead>
		                    <tr style="line-height:3">
		                        <th class="f_field" >예약번호</th>
		                        <th>예약일자</th>
		                        <th>쿠폰명</th>
		                        <th>총 금액</th>
		                        <th>사용기한</th>
		                        <th>취소가능여부</th>
		                    </tr>
		                    </thead>
		                    <tbody>                 
		 
						<!-- 리스트 null처리 -->
						<%if(list.isEmpty()|| list.size()==0) { %>
	                        <tr>  
	                            <td colspan="6" align="center">검색된 결과가 없습니다.</td>
	                        </tr>
                        <%}%> 

		                    <!-- loop 시작 -->                                
							<%
							String str_coupName;
							Timestamp ts_useStart, ts_useEnd;   
							if(list != null && list.size()>0){
							    for(int i=0;i < list.size(); i++){
								    System.out.println("예약목록List"+list.get(i));
								    reserveVO = list.get(i);
								    int reserveNo = reserveVO.getReserveNo();
	
								    //예약테이블에 없는 쿠폰정보 가져오기
								    coupVo=coupService.selectByNo(reserveVO.getCoupNo());
									str_coupName = coupVo.getCoupName();
									ts_useStart = coupVo.getCoupStartDate();
									ts_useEnd = coupVo.getCoupEndDate();
								    
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
									DecimalFormat df = new DecimalFormat("###,###,###");
							%> 
                            
    					   <tr>  
							    <td id="reserveNo"><%=reserveNo%></td>
							    <td><%=sdf.format(reserveVO.getReserveRegdate()) %></td>
							    <td style="text-align: left;">
							    <a href="<%=request.getContextPath()%>/reservation/reserveInfo.jsp?reserveNo=<%=reserveVO.getReserveNo()%>"><%=util.cutTitle(str_coupName) %></a>
<%-- 							    <a href="<%=request.getContextPath()%>/coupon/couponDetail.jsp?coupNo=<%=reserveVO.getCoupNo()%>"><%=str_coupName %></a> --%>
							    </td> 
							    <td><%=df.format(reserveVO.getReservePrice())%></td>
							    <td><%=sdf.format(ts_useStart)%> ~ <%=sdf.format(ts_useEnd)%></td> 
							    <td><input type="button" name="btnCancel" id="<%= reserveNo %>"
							  <%												
							    Timestamp curTime = new Timestamp(System.currentTimeMillis());
							    if(ts_useEnd.before(curTime)){%>
								    disabled="disabled"
								    value="취소불가"
								    class="btn btn-secondary" 
							  <%}else{ %> 
								    value="예약취소"
								    class="btn btn-warning" 
							  <%}%> 
							    ></td>
							    <td><input type="hidden" value="<%=reserveVO.getCoupNo()%>" id="coupNo"></td>
						  </tr>
						<%
						     } //for
						} //if:리스트사이즈 null 체크
						%> 
						
						</tbody>
				    </table>
                </DIV>
               <!-- </DIV> -->
            <!-- </form> -->
        </div>
        <!-- //페이지 네비게이션 끝 -->  
        <!-- //content 끝 -->    
    </div>  
    </div>   
    <!-- //container 끝 -->
    <div class="clearfix"></div>
  
  <%@ include file="../inc/bottom.jsp"%>