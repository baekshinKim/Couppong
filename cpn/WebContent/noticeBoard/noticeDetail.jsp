<%@page import="com.cpn.common.util"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.noticeBoard.model.noticeVO"%>
<%@page import="com.cpn.noticeBoard.model.noticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<jsp:useBean id="adServ" class="com.cpn.admin.model.adminService"></jsp:useBean>
<%
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	//1
	String noticeNo=request.getParameter("noticeNo");
	if(noticeNo==null||noticeNo.isEmpty()){%>
		<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href='noticeList.jsp';
		</script>
	<%	return;
	}
	
	//2
	noticeService noServ=new noticeService();
	noticeVO noVo=new noticeVO();
	try{
		noVo=noServ.selectByNo(Integer.parseInt(noticeNo));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	String content=noVo.getNoticeContent();
	if(content!=null){
		content=content.replace("\r\n","<br>"); //\r\n을 <br>로 치환
												//replace는 string을 return해 주므로 반드시 값을 담아준다
	}else{
		content="";
	}
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	%>
<div id="map-canvas" style="width:25%;height: 150px"></div>

<div class="YNside-bar" id="sideBar" style="float: left;">


	<!-- 	<!-- 사이드바 -->
	<div class="col-md-3 YNside-bar" id="YNside-bar" style="float: left;">
	
		<!-- 패널 타이틀1 -->
		<div class="panel panel-info">
			
			<!-- 사이드바 카테고리 -->
			<ul class="list-group" id="YNlist-group">
				<li class="list-group-item"><a href="<%=request.getContextPath() %>/noticeBoard/noticeList.jsp">공지사항</a></li>
				<li class="list-group-item"><a href="<%=request.getContextPath() %>/reboard/list.jsp">1:1게시판</a></li>
			</ul>
		</div>
	</div>
</div>
<div class="container mx-auto" style="width: 60%;line-height: 70px">
	<div class="row">
	<h2 style="text-align: center"><%=noVo.getNoticeTitle()%></h2>
			<div id="map-canvas" style="width:25%;height: 30px"></div>
			<div class="bg-secondary" style="width:100%;height: 70px"></div>
			
			<div class="d-flex justify-content-between">
				<div>
					 <p class="fs-5">관리자 :  <%=adServ.selectNameByNo(noVo.getAdminNo()) %> </p>
				</div>
				<div>
					<p class="fs-5"><%=sdf.format(noVo.getNoticeRegdate())%> </p>
				</div>
				<div>
					<p class="fs-5">조회수 : <%=noVo.getNoticeReadcount() %> </p>
				</div>
			</div>
			<hr>
			<div class="col-md-12 bg-light text-dark mb-3" style="min-height: 500px">		
				<p><%=content%></p>
			</div>
			<hr>
			<%if(rigNo==util.STAFF) {%>
				<div class="btn-group btn-group-lg" role="group" aria-label="Basic mixed styles example">
				  <button type="button" class="btn btn-outline-success" id="btEdit">공지수정</button>
				  <button type="button" class="btn btn-outline-warning" id="btList">공지목록</button>
				  <button type="button" class="btn btn-outline-danger" id="btDel">공지삭제</button>
				</div>
			<%}else{%>
				<div style="text-align: center">
					<button type="button" class="btn btn-warning btn-lg" id="btList">공지목록</button>
				</div>
			<% }%>
			<div id="map-canvas" style="width:25%;height: 50px"></div>
			<script type="text/javascript">
				$("#btEdit").click(function(){
					location.href="noticeEdit.jsp?noticeNo=<%=noVo.getNoticeNo()%>";
				})
				$("#btList").click(function(){
					location.href="noticeList.jsp";
				})
				$("#btDel").click(function(){
					if(confirm("해당공지를 삭제하시겠습니까?")){
						location.href="noticeDelete.jsp?noticeNo=<%=noVo.getNoticeNo()%>";
					}
				})
			</script>
		</div>
	</div>
	
<%@include file="../inc/bottom.jsp" %>
