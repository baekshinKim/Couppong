<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.cpn.location.model.LocationVO"%>
<%@page import="com.cpn.coupCategory.model.CoupCategoryVO"%>
<%@page import="com.cpn.common.util"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.coupon.model.couponVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cpn.coupon.model.couponDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
<jsp:useBean id="ctgServ" class="com.cpn.coupCategory.model.CoupCategoryService"></jsp:useBean>
<jsp:useBean id="locServ" class="com.cpn.location.model.LocationService"></jsp:useBean>
<%
		
	//쿠폰전체조회 가능 V
	
	//세션에서 권한번호 받아와서 관리자면 만료쿠폰 조회 가능
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	
	//메인에서 검색바에 입력하여 이동 POST - 파라미터 - 검색어 V
	request.setCharacterEncoding("utf-8");
	//메인에서 카테고리종류 클릭하여 이동 GET - 파라미터 카테고리번호
	//리스트에서 좌측 사이드바의 카테고리,지역명 클릭시 이동 GET - 파라미터 여러개, split으로 찢어서 배열
	//상세정보에서 해시태그카테고리 클릭하여이동 GET
	
	//[5]정렬기준 
	String s_sort=request.getParameter("sort");
	int sort=0;
	if(s_sort!=null && !s_sort.isEmpty()){
		sort=Integer.parseInt(s_sort);
	}
	
	//[1]메인에서 버튼클릭
	//메인에서 버튼마다 name=ctgNo value=카테고리 번호 인 버튼필요
	
	//[2]메인에서 검색어 입력
	String searchTxt=request.getParameter("searchTxt");
	if(searchTxt==null || searchTxt.isEmpty()){
		searchTxt="";
	}
	
	String s_ctgNo=request.getParameter("ctgNo");
	String s_locNum=request.getParameter("locNum");
	int ctgNo=0;
	int locNum=0;
	if(s_ctgNo!=null && !s_ctgNo.isEmpty()){
		ctgNo=Integer.parseInt(request.getParameter("ctgNo"));		
	}
	if(s_locNum!=null && !s_locNum.isEmpty()){
		locNum=Integer.parseInt(request.getParameter("locNum"));
	}
	String locName="";
	String ctgName="";
	if(locNum>0){
		locName=locServ.selectLocByLocNum(locNum);
	}
	if(ctgNo>0){
		ctgName=ctgServ.selectLocByCtgNo(ctgNo);
	}
	
	//searchTxt="검색결과없음테스트";
	List<couponVO> list=null;
	try{
		list=coupServ.selectCoupon(searchTxt,locNum,ctgNo,sort);		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//[3]카테고리 번호, 지역번호 선택하여 이동 / 검색어유지
	List<CoupCategoryVO> ctgList=null;
	List<LocationVO> locList=null;
	try{
		ctgList=ctgServ.selectAll();
		locList=locServ.selectAll();
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//[4]더보기 버튼 클릭시
	int pageVal=1;
	if(request.getParameter("pageVal")!=null && !request.getParameter("pageVal").isEmpty()){
		pageVal=Integer.parseInt(request.getParameter("pageVal"));
	}
	int pageMax=pageVal*6;
	
	
	//현재일자 체크용 today
	Date d = new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String s_today=sdf.format(d);
	Date today=null;
	today=sdf.parse(s_today);
	if(rigNo!=2){
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				if(list.get(i).getCoupEndDate().compareTo(today)<0){
					System.out.println("삭제된 리스트는 "+i+"번째이고 값은 "+list.get(i).getCoupEndDate().compareTo(today));
					list.remove(i);
				}
			}		
		}
	}	
%>
<script type="text/javascript">
	$(function(){
		if(<%=pageVal%>>1){
			$(".card").eq(<%=pageMax%>).focus();
		}
		$(".list-group-item").each(function(){
			if($(this).find($("input[type=radio]")).is(":checked")){
				$(this).css({
					"backgroundColor" : "#F9C8C8"
					
				});
				$(this).children().css({
					"color":"#fff"
				})
			}
		})
		
	})
</script>
<section class="home-banner"
      style="background-image: url(&quot;https://images.unsplash.com/photo-1535189043414-47a3c49a0bed?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1189&q=80/1.jpg&quot); background-height: 400px;">
   <div class="overlap"></div>
   <div class="home-search">
      <div class="container">
         <div class="row">
            <div class="col-md-6">
               <div class="kksearch">
                  <h1 class="title">어디로 갈까요?</h1>
                  <h5 class="sub-title">현지패스와 입장권을 공식판매가, 얼리버드보다 저렴하게!</h5>
                  <div class="search-block">
                     <div class="input-group">
                     	<form action="<%=request.getContextPath()%>/coupon/couponList.jsp" method="post" style="width: 640px">
                         <input id="search_experience_value" placeholder="검색 도시, 여행지, 투어 혹은 액티비티를 입력하세요." type="text" aria-autocomplete="both" aria-haspopup="false"
                            autocapitalize="off" autocomplete="off" spellcheck="false" maxlength="50" class="form-control" name="searchTxt" style="width: 570px;float: left">
                          <span class="clear-input" style="display: none;">
                          	<i class="fa fa-times-circle fa-lg"></i>
                          </span> 
                          <span class="input-group-btn">
                           <button class="btn btn-primary" id="btSearch" type="submit">
                       		<i class="fa fa-search fa-lg"></i>
                       	</button>
                      	</span>
                     	</form>
                     </div>
                     <div class="search-dropdown" style="display: none;">
                     </div>
                  </div>
                  <!---->
               </div>
            </div>
         </div>
      </div>
   </div>
</section>
   
<div id="map-canvas" style="width:25%;height: 100px"></div>
<div class="container mx-auto" style="width:80%;">
	<div class="row g-0">
	
		<!-- 사이드바 -->
		<div class="col-md-3 YNside-bar" id="sideBar"style="float: left;">
		
			<!-- 패널 타이틀1 -->
			<div class="panel panel-info">
				
				<!-- 사이드바 카테고리 -->
				<ul class="list-group">
					<li class="list-group-item">
					 	<a href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=0&locNum=<%=locNum%>&pageVal=1">
					   		<input class="form-check-input" type="radio" value="0" style="visibility: hidden"
					   		<%if(ctgNo==0){%>
					   		 checked="checked"
					   		 <%} %>
					   		 >전체보기
					 	</a>
					</li>
					<%for(int i=0;i<ctgList.size();i++){
						CoupCategoryVO ctgVo=ctgList.get(i);%>
						<li class="list-group-item">
					 	<a href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=<%=ctgVo.getCtgNo()%>&locNum=<%=locNum%>&pageVal=1">
					   		<input class="form-check-input" type="radio" value="<%=ctgVo.getCtgNo()%>" style="visibility: hidden" 
					   		<%if(ctgNo==ctgVo.getCtgNo()){ %>
					   			checked="checked"
					   		<%}%>
					   		>
								<%=ctgVo.getCtgName()%>
					 	 </a>
					 	</li>
					 <%} %>
				</ul>
				<br>
				<br>
				<ul class="list-group">
					<li class="list-group-item">
					 	<a href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=<%=ctgNo%>&locNum=0&pageVal=1">
					   		<input class="form-check-input" type="radio" value="0" style="visibility: hidden"
					   		<%if(locNum==0){%>
					   		 checked="checked"
					   		 <%} %>
					   		 >전체보기
					 	</a>
					</li>
					<%for(int i=0;i<locList.size();i++){
						LocationVO locVo=locList.get(i);%>
						<li class="list-group-item">
					 	<a href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=<%=ctgNo%>&locNum=<%=locVo.getLocNum()%>&pageVal=1" >
					   		<input class="form-check-input" type="radio" value="<%=locVo.getLocName()%>" style="visibility: hidden" 
					   		<%if(locNum==locVo.getLocNum()){ %>
					   			checked="checked"
					   		<%}%>
					   		>
								<%=locVo.getLocName()%>
					 	 </a>
					 	</li>
					 <%} %>
				</ul>
			</div>
		</div>
	
		
		<!-- 상품목록 -->
		<div class="col-md-9 g-2" id="productList">
			<div class="col-md-12 p-2 mb-4 badge text-wrap">
				<ul class="nav g-2">
				<%if(rigNo!=2){ %>
				  <li class="nav-item" style="border-radius:30px;border:groove;margin-inline-start: auto;">
				    <a class="nav-link active" style="text-decoration:none;<%if(sort==1){%>background-color:#F9C8C8;color:#fff;border-radius:30px;<%}%>" aria-current="page" href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=<%=ctgNo%>&locNum=<%=locNum%>&pageVal=1&sort=1">더 저렴한 쿠폰</a>
				  </li>
				  <li class="nav-item" style="border-radius:30px;border:groove;<%if(sort==2){%>background-color:#F9C8C8;color:#fff;<%}%>">
				    <a class="nav-link" style="text-decoration:none;<%if(sort==2){%>background-color:#F9C8C8;color:#fff;border-radius:30px;<%}%>" href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=<%=ctgNo%>&locNum=<%=locNum%>&pageVal=1&sort=2">더 많이팔린 쿠폰</a>
				  </li>
				  <li class="nav-item" style="border-radius:30px;border:groove;<%if(sort==3){%>background-color:#F9C8C8;color:#fff;<%}%>">
				    <a class="nav-link" style="text-decoration:none;<%if(sort==3){%>background-color:#F9C8C8;color:#fff;border-radius:30px;<%}%>" href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=<%=ctgNo%>&locNum=<%=locNum%>&pageVal=1&sort=3">더 관심받는 쿠폰</a>
				  </li>
				  <%}else if(rigNo==2){%>
					<li class="nav-item" style="border-radius:30px;border:groove;<%if(sort==4){%>background-color:#F9C8C8;color:#fff;<%}%>">
					    <a class="nav-link" style="text-decoration:none;<%if(sort==4){%>background-color:#F9C8C8;color:#fff;border-radius:30px;<%}%>" href="couponList.jsp?sort=4">만료된 쿠폰보기</a>
					 </li>
					<li class="nav-item" style="border-radius:30px;border:groove;float: right;text-decoration: none">
					    <a class="nav-link" href="couponInsert.jsp">쿠폰등록</a>
					 </li>
				  <%} %>
				</ul>
			</div>
			<!-- 검색결과갯수 div -->
			<div class="col-md-12 p-2 mb-4">
					<p class="h5">[검색결과]<br><%if(searchTxt!=null && !searchTxt.isEmpty()){%>"<span style="color:#F9C8C8"><%=searchTxt%></span>" 로 검색, <%} %><span style="color:#F9C8C8"><%=list.size()%></span> 개 검색됨  - 카테고리 : <span style="color:#F9C8C8">				
				<%if(ctgName!=null && !ctgName.isEmpty()){%>&nbsp;&nbsp;<%=ctgName%><%}if(locName!=null && !locName.isEmpty()){%>&nbsp;&nbsp;<%=locName%><%}%></span></p>
				<%if(!(searchTxt=="" && ctgNo==0 && locNum==0 && sort==0)){%>
					<span>
						<a href="<%=request.getContextPath()%>/coupon/couponList.jsp">
							<button type="button" class="btn btn-outline-dark btn-sm" style="float:left">처음부터 볼래요</button>
						</a>
					</span>
					<br>
				<%} %>
			</div>
			<div id="map-canvas" style="width:25%;height: 30px"></div>
			<!-- 리스트 출력 -->
			<%if(list==null||list.isEmpty()){ //조회결과가 없을때%>
			<div class="col-md-12 p-4" style="text-align: center;" >
				<img src="https://cdn.kkday.com/pc-web/assets/img/empty_state/product_list.svg" style="vertical-align: middle;width:150px;">
				<h2>검색결과가 없습니다</h2>
				<p class="lead">NullPointerException</p>
			</div>
			<%}else{%>
			<div class="row">
				<%for(int i=0;i<pageMax;i++){
					if(i>=list.size()) break;
					couponVO vo=list.get(i);%>
					<div class="col-md-4 p-0 mb-4" style="border-radius: 20px">
						<div class="card" style="width: 18rem;border-radius: 15px;">
							<input type="hidden" value="<%=vo.getCoupNo()%>" name="coupNo" id="coupNo">
							<%if(vo.getCoupFileName()==null || vo.getCoupFileName().isEmpty()){%>
							<img src="<%=request.getContextPath()%>/imgs/nonimg.png" class="card-img-top" alt="..." style="height:230px">
							<%}else{%>
							<img src="<%=request.getContextPath()%>/thumbnails/<%=vo.getCoupFileName()%>" class="card-img-top" alt="..." style="height:230px">
							<%} %>	
							<div class="card-body">
						  	<div class="col-sm-12 mb-1" style="text-align: right">
							    <h5 class="card-title"><%=util.cutContent(vo.getCoupName())%></h5>
						  	</div>
						  	<div class="col-sm-12 mb-2" style="text-align:right;">
							    <p class="card-text h6"><span style="color:#F9C8C8">PRICE</span>&nbsp;&nbsp;<%=vo.getCoupPrice()%></p>
						  	</div>
						  	<%if(rigNo!=2){ %>
							  	<div class="col-sm-12 mb-2" style="text-align:right;">
								    <p class="card-text h6"><%=sdf.format(vo.getCoupStartDate())%>&nbsp;&nbsp;<span style="color:#F9C8C8">부터 사용가능</span></p>
							  	</div>
						  	<%}else if(rigNo==2){ %>
							  	<div class="col-sm-12 mb-2" style="text-align:right;">
								    <p class="card-text h6"><%=sdf.format(vo.getCoupEndDate())%>&nbsp;&nbsp;<span style="color:#F9C8C8">까지 사용가능</span></p>
							  	</div>
						  	<%} %>
						  	<div class="col-sm-12 mb-2">
								<img alt="좋아요" src="<%=request.getContextPath()%>/imgs/like.png" style="float:left;margin-right:10px"><p style="font-size: 1.4em;float: left"><%=vo.getCoupLikecnt()%></p>
								<p style="font-size: 1.4em;float: right"><%=vo.getCoupPurchase()%></p><img alt="판매량" src="<%=request.getContextPath()%>/imgs/buy.png" style="float:right;margin-right:10px;height: 37px;">	  	
						  	</div>
						  	<div class="col-sm-12 justify-content-end" style="clear: both">
						  		<%if(rigNo==2){%>
						  		<div class="d-grid gap-2 col-12 mx-auto">
							  		<a href="couponDetail.jsp?coupNo=<%=vo.getCoupNo()%>" class="btn btn-outline-primary btn-sm">자세히보기</a>
							  		<a href="couponEdit.jsp?coupNo=<%=vo.getCoupNo()%>" class="btn btn-outline-warning btn-sm">수정</a>
							  		<a href="couponDelete.jsp?coupNo=<%=vo.getCoupNo()%>" class="btn btn-outline-danger btn-sm">삭제</a>
								</div>
								<%}else{ %>
							  	<div class="col-sm-8 p-0 mx-auto">
							    	<a href="couponDetail.jsp?coupNo=<%=vo.getCoupNo()%>" class="btn btn-outline-primary btn-lg">자세히보기</a>						  	
							  	</div>
							  	<%}//if%>
						  	</div>
						  </div>
						</div>
					</div>
				<%}//for%>
				<%if(pageMax<list.size()){ %>
				<div class="d-grid gap-2 col-8 mx-auto mb-4" style="text-align: center">
					<a href="couponList.jsp?searchTxt=<%=searchTxt%>&ctgNo=<%=ctgNo%>&locNum=<%=locNum%>&pageVal=<%=pageVal+1%>&sort=<%=sort%>" class="btn btn-dark" >더보기</a>				
				</div>
				<%} %>
			</div>
			<%} %>
		</div>
	</div>	
</div>
<div id="map-canvas" style="width:25%;height: 100px"></div>
<%@ include file="../inc/bottom.jsp"%>