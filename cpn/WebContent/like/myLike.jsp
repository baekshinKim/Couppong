<%@page import="com.cpn.common.PagingVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.like.model.LikeDAO"%>
<%@page import="com.cpn.like.model.LikeVO"%>
<%@page import="com.cpn.coupon.model.couponVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
  <%@ include file="../inc/top.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

    <style TYPE="text/css"> 
        body { 
        scrollbar-face-color: #F6F6F6; 
        scrollbar-highlight-color: #bbbbbb; 
        scrollbar-3dlight-color: #FFFFFF; 
        scrollbar-shadow-color: #bbbbbb; 
        scrollbar-darkshadow-color: #FFFFFF; 
        scrollbar-track-color: #FFFFFF; 
        scrollbar-arrow-color: #bbbbbb;
        margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";
        }
        
        td {font-family: sans-serif; font-size: 14pt; color:#595959;}
        th {font-family: sans-serif; font-size: 14pt; color:#000000;}
        select {font-family: sans-serif; font-size: 14pt; color:#595959;}
        
        
        .divDotText {
        overflow:hidden; 
        text-overflow:ellipsis;
        }
        
        A:link { font-size:14pt; font-family:sans-serif;color:#666; text-decoration:none; font-weight:normal;}
        A:visited { font-size:14pt; font-family:sans-serif;color:#666; text-decoration:none; }
        A:active { font-size:14pt; font-family:sans-serif;color:red; text-decoration:none; }
        A:hover { font-size:14pt; font-family:sans-serif;color:red;text-decoration:none;}

		YNside-li:hover{
		background-color: #F9C8C8;
		color: #fff;
	}

        
    </style>

<%
	int memNo=0;
	if(session.getAttribute("memNo")!=null){
		memNo=(Integer)session.getAttribute("memNo");
	}
	
	if(memNo<1){%>
		<script type="text/javascript">
			alert("로그인이 필요합니다.");
			location.href="<%=request.getContextPath()%>/login/login.jsp";
		</script>	
	<%}
%>
<div id="map-canvas" style="width:25%;height: 50px"></div>
<div id="YNwrap">
    <!-- header 시작 -->
    <div id="header_mainsize"></div>


    <!-- //header 끝 --> 
    <!-- container 시작 -->
    <div id="YNcontainer">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu">
        
<!--         <div style="height:100px;"></div> -->


	<!-- 사이드 바 메뉴-->
	<div class="YNside-bar" style="float: left;">

		<!-- 패널 타이틀1 -->
		<div class="panel panel-info YNside">
			
			<!-- 사이드바 메뉴목록1 -->
			<ul class="list-group YNside-ul">
				<li class="list-group-item YNside-li" style="height:50px;background-color:#ffffff;"><a href="<%=request.getContextPath() %>/member/memberEdit.jsp">내 정보 수정</a></li>
				<li class="list-group-item YNside-li" style="height:50px;background-color:#ffffff;" ><a href="<%=request.getContextPath() %>/reservation/myReserveList.jsp">내 예약목록</a></li>
				<li class="list-group-item YNside-li" style="height:50px;background-color:#f5c8c8;"><a href="#">내 관심목록</a></li>
				<li class="list-group-item YNside-li" style="height:50px;background-color:#ffffff;"><a href="<%=request.getContextPath()%>/member/memberOut.jsp">회원탈퇴</a></li>
			</ul>
		</div>
	</div>
               
      </div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content" style="width:80%">
                <h2>관심목록</h2>
                <form name="deptSchdulManageVO" id="deptSchdulManageVO" 
                								action="" method="post">
                    <input type="submit" id="invisible" class="invisible"/>
                    <DIV id="content2" style="width:712px;">
                        

	                    <div id="page_info" ></div>                    
		                <!-- table add start -->
		                <div class="default_tablestyle">
	                    <table>
		                    <colgroup>
    		                    <col width="10%" >  
    		                    <col width="90%" >  
		                    </colgroup>
		                    <thead>
		                    <tr>
		                        <th>관심번호</th>
		                        <th>쿠폰명</th>
		                    </tr>
		                    </thead>	                                 
		 <tbody>                 
		 <jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
		 	<!--좋아요 내용 데이터 뿌리기 -테이블 불러오기  -->
	  	 <%
	  		//PagingVO pageVo = new PagingVO();
	  	 	
			
			LikeDAO likeDao = new LikeDAO();
			List<LikeVO> list=likeDao.selectByMemNo(memNo);
			for(int i=0;i<list.size();i++){
							
				LikeVO vo=new LikeVO();
				couponVO cVo=new couponVO();
				vo=list.get(i);
				cVo=coupServ.selectByNo(vo.getCoupNo());
				
			%>
			 	<tr style="text-align:center;">
				<td style="line-height: 3"><%=i+1%></td>
				<td style="line-height: 3"><a href="<%=request.getContextPath()%>/coupon/couponDetail.jsp?coupNo=<%=vo.getCoupNo()%>" style="decoration:none">
					 <%=cVo.getCoupName()%>
					</a>
				 </td>		
				</tr>
					
				<%} %>
				
	  <!--끝끝끝끝 끝  --> 
						</tbody>
				    </table>
                </div>
               </div>
            </form>
        </div>
        <!-- //페이지 네비게이션 끝 -->  
        <!-- //content 끝 -->    
    </div>  
    </div>  
    <!-- //container 끝 -->
    <div class="clearfix"></div>
  <div id="map-canvas" style="width:25%;height: 50px"></div>
  <%@ include file="../inc/bottom.jsp"%>