<%@page import="com.cpn.comments.model.CommentsVO"%>
<%@page import="com.cpn.common.util"%>
<%@page import="com.cpn.coupon.model.couponVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
<jsp:useBean id="ctgServ" class="com.cpn.coupCategory.model.CoupCategoryService"></jsp:useBean>
<jsp:useBean id="locServ" class="com.cpn.location.model.LocationService"></jsp:useBean>
<jsp:useBean id="vo" class="com.cpn.coupon.model.couponVO"></jsp:useBean>
<jsp:useBean id="likeVo" class="com.cpn.like.model.LikeVO"></jsp:useBean>
<jsp:useBean id="likeServ" class="com.cpn.like.model.LikeService"></jsp:useBean>
<style>
.commContent{
		border-left: 1px solid silver;
		border-right: 1px solid silver;
	}
</style>
<%
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}

	//[1] couponList에서 상품선택
	//필요파라미터 = coupNo
	
	int coupNo=Integer.parseInt(request.getParameter("coupNo"));
	String locName="";
	String ctgName="";
	try{
		vo=coupServ.selectByNo(coupNo);
		ctgName=ctgServ.selectLocByCtgNo(vo.getCtgNo());
		locName=locServ.selectLocByLocNum(vo.getLocNum());
	}catch(SQLException e){
		e.printStackTrace();
	}
	List<couponVO> list=null;
	try{
		list=coupServ.selectByCtg(vo.getCtgNo());
	}catch(SQLException e){
		e.printStackTrace();
	}

	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
	
	Date d = new Date();
	String s_today=sdf.format(d);
	Date today=null;
	today=sdf.parse(s_today);
	int bet = today.compareTo(vo.getCoupStartDate());
	System.out.print(bet);
	
	//[2] 관심등록한 상품인 경우 하트 이미지 출력
	int memNo=0;
	if(session.getAttribute("memNo")!=null){
		memNo=(int)session.getAttribute("memNo");
	}
	
	likeVo.setCoupNo(coupNo);
	likeVo.setMemNo(memNo);
%>
<script type="text/javascript"> 
	$(function(){
		var collapseElementList = [].slice.call(document.querySelectorAll('.collapse'))
		var collapseList = collapseElementList.map(function (collapseEl) {
		  return new bootstrap.Collapse(collapseEl)
		})
		
	});
	
</script>
<div id="map-canvas" style="width:25%;height: 150px"></div>

<%-- 사이드바1 --%>
<div class="col-md-3 YNside-bar" style="float: right;visibility: hidden" id="sidebar1">

	<!-- 패널 타이틀1 -->
	<div class="panel panel-info YNside" style="position: fixed;margin-left: 150px">
		
		<!-- 사이드바 메뉴목록1 -->
		<form action="<%=request.getContextPath()%>/reservation/reserveInsert.jsp" method="post" name="frmReserv">
			<div class="accordion" id="accordionExample" style="min-width: 320px">
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="headingOne">
			      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
			        	예약하기
			      </button>
			    </h2>
			    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
			      <div class="accordion-body"><!-- 아코디언 시작 -->
					<div class="com-sm-12">
						<div class="form-group">
							<div class="counter-item">
								<div class="counter-row">
									<div class="counter" style="margin: 0px">
										<div class="col-sm-12 mb-4">
											<label style="font-size:1.3em;float:left;">Quantity</label><input type="number" class="counter-num" name="coupPurchase" id="coupPurchase" style="width: 60px;margin-left:50px" value="1">
										</div>
										<div class="row g-2" style="height:80px">
											<div class="col-sm-4" style="text-align: end;height:70px">
												<img alt="" src="<%=request.getContextPath()%>/imgs/money.png">
											</div>
											<div class="col-sm-8" style="text-align: center;height:70px">
												<p class="fs-3" id="priceTag"><%=vo.getCoupPrice()%></p><p class="fs-4">&nbsp;&nbsp;</p>
											</div>
										</div>
										 <script type="text/javascript">
                                 $('form[name=frmReserv]').submit(function(){
                                    // reserveInfo로 넘길 쿠폰수량 정보 읽어오기 
                                    var reservePer = $('input[type=number][name=coupPurchase]').val();
                                      $("#reservePer").val(reservePer);
                                    
                                  });      
                              </script>
                              
                              <!-- 예약하기 누를 때 reserveInsert.jsp로 가져갈 파라미터 -->
                              
                              <input type="hidden" title="쿠폰번호" name="coupNo" id="coupNo" value="<%=coupNo%>">
                              <input type="hidden" title="입력수량" name="reservePer" id="reservePer" value="">
                           		
                              <input type="hidden" title="쿠폰명"  name="coupName" id="coupName" value="<%=vo.getCoupName()%>">
                              <input type="hidden" title="쿠폰단가" name="coupPrice" id="coupPrice" value="<%=vo.getCoupPrice()%>">
                              
                              <input type="hidden" title="사용기한시작일"  name="coupStartDate" id="coupStartDate" value="<%=vo.getCoupStartDate()%>">
							  <input type="hidden" title="사용기한종료일" name="coupEndDate" id="coupEndDate" value="<%=vo.getCoupEndDate()%>">
                              
								<button type="submit" class="btn btn-lg btn-outline-success">이대로 주문하기</button>
									</div>
									<script type="text/javascript">
										$("#coupPurchase").change(function(){
											if($(this).val()<1){
												alert("수량은 1보다 적을 수 없습니다");
												event.preventDefault();
												$(this).val('1');
											}
											
											var i=<%=vo.getCoupPrice()%>;
											$("#priceTag").text(i*($(this).val()));
										});
									</script>
								</div>
							</div>
						</div>
						<span>
						
						</span>
					</div>
			      </div><!-- 아코디언 끝 -->
			    </div>
			  </div>
			</div>
		</form>
	</div>
</div>



<div class="container mx-auto" style="width:70%;">
		
	<h2>쿠폰 상세정보</h2>
	<p class="lead">Coupon Detail</p>
	<div id="map-canvas" style="height: 100px"></div>
	
	<div class="row g-0">
	
	<%-- 쿠폰 정보(썸네일,쿠폰 이름,가격 / 예약버튼,관심등록버튼 / 지도 ) --%>
	
			<!-- 썸네일 사진 -->
			<div class="col-lg-5">
				<%if(vo.getCoupFileName()==null || vo.getCoupFileName().isEmpty()){ %>
				<img src="https://cdn.kkday.com/pc-web/assets/img/empty_state/product_list.svg" class="img-fluid mx-auto" alt="..." style="min-width:280px;display: block;height:380px;">
				<%}else{ %>
				<img src="<%=request.getContextPath()%>/thumbnails/<%=vo.getCoupFileName() %>" class="img-fluid mx-auto" alt="..." style="min-width:280px;display: block;height: 380px;">
	    		<%} %>
	    	</div>
	    	
			<div class="col-lg-1"></div>
			
			<!-- 쿠폰 이름,가격,예약버튼,관심등록버튼 -->
			<div class="col-sm-6 pl-10 mx-auto" style="width:550px; ">
					
				<!-- 이름 -->
				<div class="col-md-8 pt-3 pb-4 mx-auto">
					<p class="fw-bold fs-5 text-end"><%=vo.getCoupName() %></p>
					<%if(!likeServ.isLike(likeVo)){ %>
						<div>
							<img role="button" alt="" src="<%=request.getContextPath()%>/imgs/heart.png" style="float: right" id="like">
						</div>
					<%}else if(memNo==0){ %>
						<br>
					<%}else{%>
						<div>
							<img role="button" src="<%=request.getContextPath()%>/imgs/emptyHeart.png" style="float: right" id="like">
						</div>
					<%} %>						
					<p class="read font-monospace text-end" style="clear: both;line-height: 40px">
					<a href="couponList.jsp?locNum=<%=vo.getLocNum()%>" target="_blanc" class="text-decoration-none" style="color:gray"><i>#<%=locName%></i></a> 
					<a href="couponList.jsp?ctgNo=<%=vo.getCtgNo()%>" target="_blanc" class="text-decoration-none" style="color:gray"><i>#<%=ctgName%></i></a></p>
				</div>
				
				<!-- 가격 -->
				<div class="col-md-8 pb-4 mx-auto">
					<p class="fw-bold fs-4 text-end"><%=vo.getCoupPrice()%>원&nbsp;(ea)</p>
				</div>
				
				<!-- 예약버튼 관심버튼 -->
				<%if(rigNo!=2){ %>
				<div class="d-grid gap-2 col-sm-8 mx-auto pb-4">
					<button type="button" class="btn btn-primary" id="reserve">예약하기</button>
					
					<script type="text/javascript">
						$("#reserve").click(function(){
						<%if(util.chkRig(rigNo)){%>
									$("#sidebar1").css("visibility","");
								})
						<%}else{%>
									alert("비회원은 예약할 수 없습니다.");
									event.preventDefault();
									return false;
								})
						<%}%>
						$("#like").click(function(){
							location.href="<%=request.getContextPath()%>/like/likeCheck.jsp?coupNo=<%=coupNo%>";
						})
					</script>
				</div>
				<%}else if(rigNo==2){%>
				<div class="d-grid gap-2 col-sm-8 mx-auto pb-4">
					<button type="button" class="btn btn-warning" id="btEdit">쿠폰수정</button>
					<button type="button" class="btn btn-danger" id="btDelete">쿠폰삭제</button>
					<script type="text/javascript">
						
						$("#btEdit").click(function(){
							location.href="couponEdit.jsp?coupNo=<%=coupNo%>";
						})
						
						$("#btDelete").click(function(){
							<%if(vo.getCoupEndDate().compareTo(today)<0){%>
								if(confirm("만료된 쿠폰입니다. 해당쿠폰을 삭제하시겠습니까?")){
									location.href="couponDelete.jsp?coupNo="+coupNo;
								}
							<%}else{%>
								if(confirm("아직 만료되지 않은 쿠폰입니다. 정말 해당쿠폰을 삭제하시겠습니까?")){
									location.href="couponDelete.jsp?coupNo="+coupNo;
								}
							<%}%>
						})
				</script>
				</div>
				<%} %>
			</div>
			
			<div style="height:50px"></div>
			
			<hr>
			<%-- 쿠폰 상세정보 --%>
			<div class="col-md-12" style="min-height:500px;padding:20px;" >
				<div class="col-md-12" style="text-align: center">
					<p class="font-monospace fs-2 bold">상세설명</p>
				</div>
				<div class="col-md-12" style="height:85%;padding:20px;background-color:#f8f9fa;color:#212529;text-align: center">
					<p class="lh-lg"><%=vo.getCoupContent()%></p>
				</div> 
			</div>
			<%-- 쿠폰 상세정보 끝!!--%>
			
			<hr>
			
			<%-- 위치 --%>
			<div class="col-md-3 col-md-offset-1 mx-auto" style="height:400px;">
				<h2>주소</h2>
				<br>
				<p><%=vo.getAddress() %></p>
			</div>
			<!-- 지도 -->
			<div class="col-md-8 mx-auto">
				<div id="map" style="width:100%;height:400px;"></div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2dd180fbfd043e9b8037e9c7430f7950"></script>
				<script>
					var mapContainer = document.getElementById('map');
					var mapOption = {
						center: new kakao.maps.LatLng(<%=vo.getLatitude()%>,<%=vo.getLongitude()%>),
						level: 3
					};
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
					// 마커가 표시될 위치입니다 
					var markerPosition  = new kakao.maps.LatLng(<%=vo.getLatitude()%>,<%=vo.getLongitude()%>); 
					
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
					    position: markerPosition
					});
					
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					
					var iwContent 
					= '<div style="padding:2px;"><br>&nbsp;<a href="https://map.kakao.com/link/map/<%=vo.getAddress()%>,<%=vo.getLatitude()%>,<%=vo.getLongitude()%>" style="color:blue" target="_blank"><span class="badge rounded-pill bg-primary">큰지도보기</span></a> <a href="https://map.kakao.com/link/to/<%=vo.getAddress()%>,<%=vo.getLatitude()%>,<%=vo.getLongitude()%>" style="color:blue" target="_blank"><span class="badge rounded-pill bg-secondary">길찾기</span></a><br><br></div>',
					// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				    iwPosition = new kakao.maps.LatLng(<%=vo.getLatitude()%>,<%=vo.getLongitude()%>); //인포윈도우 표시 위치입니다
			
					// 인포윈도우를 생성합니다
					var infowindow = new kakao.maps.InfoWindow({
					    position : iwPosition, 
					    content : iwContent 
					});
					  
					// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
					infowindow.open(map, marker); 
				</script>
			</div>
			<%--지도 끝!! --%>
	</div>
	<%-- 쿠폰 정보 끝!!--%>
	
	<%-- 리뷰 --%>
	<div class="col-md-12 mt-5">
		<jsp:useBean id="commVo" class="com.cpn.comments.model.CommentsVO" />
		<jsp:useBean id="commService" class="com.cpn.comments.model.CommentsService"/>
		<%
			List<CommentsVO> cList=null;
			try{
				cList=commService.selectByCoupNo(coupNo);
			}catch(SQLException e){
				e.printStackTrace();
			}
		%>
		<h2>Review <%if(commService.selectCommentsCnt(coupNo)!=0){ %>[<%=commService.selectCommentsCnt(coupNo)%>]<%} %></h2> 
		<div class="table table-hover">    
			<table style="width: 100%">
				<colgroup>
					<col style="width:15%;" />
					<col style="width:55%;" />
					<col style="width:25%;" />	
				</colgroup>
				<thead>
				  <tr>
				    <th scope="col">번호</th>
				    <th scope="col">내용</th>
				    <th scope="col">작성자</th>
				  </tr>
				</thead> 	
				<%if(cList==null || cList.isEmpty()){ %>
					<tr>
						<td colspan="3" style="text-align: center">등록된 댓글이 없습니다.</td>
					</tr>
				<%}else{ 
					for(int i=0; i<cList.size(); i++){
						commVo=cList.get(i);%>
						<tr>
							<td>
								<%=commVo.getReNo()%>
							</td>
							<td>
								<%=commVo.getReContents()%>
							</td>
							<td>
								<%=commVo.getMemId()%>
							</td>
						</tr>
					<%}//for 
				}//if %>
			</table>
		</div>
			<div class="form-floating">
				<form name="frmCommWrite" method="post" action="commentsWrite_ok.jsp">
					<input type="hidden" name="c_coupNo" value="<%=coupNo%>">
				  	<div>
					 	<textarea class="form-control" placeholder="리뷰를 남겨보세요." id="floatingTextarea2" style="height: 100px;resize: none" name="reContents"></textarea>
						<!-- <label for="floatingTextarea2">Comments</label> -->
					</div>
					<div style="text-align: right">
						<input type="submit" value="등록" />
					</div>
				</form>	
			</div>
	</div>
	<%-- 리뷰 끝!! --%>
	
	<%-- 추천상품 --%>
	<hr>
	<div class="col-md-12 mt-5">
		<!-- carousel -->
		<h2>관련상품</h2>
	   <div class="">
	     <div id="carouselExampleInterval" class="carousel slide justify-content-center" data-bs-ride="carousel">
	       <div class="carousel-inner">
	         <div class="carousel-item active justify-content-center" data-bs-interval="3000">
	           <!-- card group -->
		       <div class="card-group justify-content-center">
	           <%
	           if(list.size()!=0){
	           for(int i=0;i<3;i++){
	        	   if(i>=list.size()){
	        		   break;
	        	   }else if(list.get(i).getCoupEndDate().compareTo(today)<0){
	   					list.remove(i);
	   					i--;
	   					continue;
	   				}
	           		couponVO cVo=list.get(i);
	           	%>
				<a href="couponDetail.jsp?coupNo=<%=cVo.getCoupNo()%>" style="text-decoration: none;color:gray">
		             <div class="col-md-4 p-0 mb-4 mx-2" style="border-radius: 20px">
						<div class="card" style="width: 18rem;border-radius: 15px;">
							<%if(cVo.getCoupFileName()==null || cVo.getCoupFileName().isEmpty()){%>
							<img src="https://cdn.kkday.com/pc-web/assets/img/empty_state/product_list.svg" class="card-img-top" alt="..." style="height:230px">
							<%}else{%>
							<img src="<%=request.getContextPath()%>/thumbnails/<%=cVo.getCoupFileName()%>" class="card-img-top" alt="..." style="height:230px">
							<%} %>	
							<div class="card-body">
						  	<div class="col-sm-12 mb-1" style="text-align: right">
							    <h5 class="card-title"><%=util.cutContent(cVo.getCoupName())%></h5>
						  	</div>
						  	<div class="col-sm-12 mb-2" style="text-align:right;">
							    <p class="card-text h6"><span style="color:#F9C8C8">PRICE</span>&nbsp;&nbsp;<%=cVo.getCoupPrice()%></p>
						  	</div>
						  	<div class="col-sm-12 mb-2" style="text-align:right;">
							    <p class="card-text h6"><%=sdf.format(cVo.getCoupStartDate())%>&nbsp;&nbsp;<span style="color:#F9C8C8">부터 사용가능</span></p>
						  	</div>
						  </div>
						</div>
					</div>
				</a>
				<%} %>
	           </div>
	           <!-- card group end-->
	
	         </div>
	         <%if(list.size()>3){ %>
		         <div class="carousel-item justify-content-center" data-bs-interval="4000">
		
		           <!-- card group -->
		           <div class="card-group justify-content-center">
		           <%for(int i=3;i<6;i++){
		        	   if(i>=list.size()){
		        		   break;
		        	   }else if(list.get(i).getCoupEndDate().compareTo(today)<0){
		   					list.remove(i);
		   					i--;
		   					continue;
		   				}
		           		couponVO cVo=list.get(i);
		           	%>
					<a href="couponDetail.jsp?coupNo=<%=cVo.getCoupNo()%>" style="text-decoration: none;color:gray">
			             <div class="col-md-4 p-0 mb-4 mx-2" style="border-radius: 20px">
							<div class="card" style="width: 18rem;border-radius: 15px;">
								<%if(cVo.getCoupFileName()==null || cVo.getCoupFileName().isEmpty()){%>
								<img src="https://cdn.kkday.com/pc-web/assets/img/empty_state/product_list.svg" class="card-img-top" alt="..." style="height:230px">
								<%}else{%>
								<img src="<%=request.getContextPath()%>/thumbnails/<%=cVo.getCoupFileName()%>" class="card-img-top" alt="..." style="height:230px">
								<%} %>	
								<div class="card-body">
								  	<div class="col-sm-12 mb-1" style="text-align: right">
									    <h5 class="card-title"><%=util.cutContent(cVo.getCoupName())%></h5>
								  	</div>
								  	<div class="col-sm-12 mb-2" style="text-align:right;">
									    <p class="card-text h6"><span style="color:#F9C8C8">PRICE</span>&nbsp;&nbsp;<%=cVo.getCoupPrice()%></p>
								  	</div>
								  	<div class="col-sm-12 mb-2" style="text-align:right;">
									    <p class="card-text h6"><%=sdf.format(cVo.getCoupStartDate())%>&nbsp;&nbsp;<span style="color:#F9C8C8">부터 사용가능</span></p>
								  	</div>
							  </div>
							</div>
						</div>
					</a>
					<%} %>
		           <!-- card group end-->
		
		         </div>
		       </div>
		       <%}
	         }%>
	     </div>
	   </div>
		<%--추천상품 끝!! --%>
	</div>
</div>
</div>
<%@include file="../inc/bottom.jsp" %>