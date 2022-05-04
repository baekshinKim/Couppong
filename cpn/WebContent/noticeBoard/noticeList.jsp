<%@page import="java.util.Date"%>
<%@page import="com.cpn.common.util"%>
<%@page import="com.cpn.admin.model.adminService"%>
<%@page import="com.cpn.common.PagingVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.noticeBoard.model.noticeVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cpn.noticeBoard.model.noticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<jsp:useBean id="adServ" class="com.cpn.admin.model.adminService"></jsp:useBean>
<%
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	
	request.setCharacterEncoding("utf-8");
	
	String condition=request.getParameter("searchCondition"); 
	String keyword=request.getParameter("searchKeyword");
	if(keyword==null || keyword.isEmpty()){
		keyword="";
	}
	//2
	noticeService noServ=new noticeService();
	
	List<noticeVO> list=null;
	try{
		list=noServ.selectAll(condition,keyword);		
	}catch (SQLException e){
		e.printStackTrace();
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	int currentPage=1; //현재 페이지
	
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int totalRecord=0;	
	if(list!=null && !list.isEmpty()){
		totalRecord=list.size();	
	}
	
	int pageSize=5;	
	
	int blockSize=10; 
	
	PagingVO pVo=new PagingVO(currentPage,totalRecord,pageSize,blockSize);
	
	
	
    Date today = new Date();
	 
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
<div class="container mx-auto">
	<div class="row">
	
		<div class="col-md-1 p-0 m-0"></div>
		<div class="col-md-11">
			<div class="col-md-12">
				<h2>공지사항</h2>
				<br>
				<table class="table table-hover">
					<colgroup>
						<col style="width:10%;" />
						<col style="width:50%;text-align: center;" />
						<col style="width:15%;" />
						<col style="width:15%;" />
						<col style="width:10%;" />		
					</colgroup>
					<thead>
					  <tr>
					    <th scope="col">번호</th>
					    <th scope="col">제목</th>
					    <th scope="col">작성자</th>
					    <th scope="col">작성일</th>
					    <th scope="col">조회수</th>
					  </tr>
					</thead> 
					<tbody>  
					<%
						if(list==null || list.isEmpty()){ //데이터가 없을 때의 처리%>
							<tr>
								<td colspan="5" style="text-align: center">공지사항이 없습니다.</td>
							</tr>
					<% }else{%>
					  <!--게시판 내용 반복문 시작  -->
					  	<%
					  	int num=pVo.getNum();
					  	int curPos=pVo.getCurPos();
					  	for(int i=0;i<pageSize;i++) {
					  		if(num<1) break;
					  		
					  		noticeVO vo=list.get(curPos++); //시작 index 변수 curPos
					  		num--; //글번호 --, 1보다 작아지면 break
					  	%>		
						<tr  style="text-align:center">
							<td><%=num+1%></td>
							<td style="text-align:left">
								<a href="noticeCount.jsp?noticeNo=<%=vo.getNoticeNo()%>" style="text-decoration: none;color:gray"><%=vo.getNoticeTitle() %></a>
								<%if((today.getTime()-vo.getNoticeRegdate().getTime())/1000/(60*60)<24){%>
									<span class="badge bg-warning">New</span>
								<%}%>
							</td>
							<td><%=adServ.selectNameByNo(vo.getAdminNo())%></td>
							<td><%=sdf.format(vo.getNoticeRegdate())%></td>
							<td><%=vo.getNoticeReadcount() %></td>		
						</tr> 
						<%}//for
					  	}//else%>
					  <!--반복처리 끝  -->
					  </tbody>
				</table>	   
			</div>
			
			<div id="map-canvas" style="width:25%;height: 30px"></div>   
			<div class="col-md-12">
				<ul class="pagination justify-content-center">
				<!-- 페이지 번호 추가 -->
						
				<!-- 이전 블럭으로 이동 -->
				<%if(pVo.getFirstPage()>1){%>
					<li class="page-item"><a class="page-link" href="noticeList.jsp?currentPage=<%=pVo.getFirstPage()-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
						이전
					</a>
					</li>					
				<%}else{%>
					<li class="page-item disabled">
			      		<a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전</a>
			    	</li>
				
				<!-- [1][2][3][4][5][6][7][8][9][10] -->
				<%}
					for(int i=pVo.getFirstPage();i<=pVo.getLastPage();i++){
						if(i>pVo.getTotalPage()) break;
						
						if(i==currentPage){ %>
						<li class="page-item active" aria-current="page">
					      <a class="page-link" href="#"><%=i %></a>
					    </li>
					<%}else{%>
						<li>
						<a class="page-link" href="noticeList.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
							<%=i %></a>
						</li>		
					<%}//if
				} //for%>
				
				<!-- 다음 블럭으로 이동 -->
				<%if(pVo.getLastPage()<pVo.getTotalPage()){%>
					<li class="page-item">
					<a class="page-link" href="noticeList.jsp?currentPage=<%=pVo.getLastPage()+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
						다음
					</a>
					</li>					
				<%}else{ %>
					<li class="page-item disabled">
				      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">다음</a>
				    </li>
				<%} %>
				<!--  페이지 번호 끝 -->
				</ul>
			</div>
			
			<div id="map-canvas" style="width:25%;height: 30px"></div>   
				   	<form name="frmSearch" method="post" action='noticeList.jsp'>
						<div class="row justify-content-center">
							<div class="col-sm-2 mr-0">
						        <select class="form-select" name="searchCondition"  style="width:130px;float:right;">
						            <option value="noticeTitle" 
						            <%if("noticeTitle".equals(condition)){
						            //if(condition.equals("title") : condition이 null인경우 error%>
						            	selected="selected"
						            <%}%>
						            >제목</option>
						            <option value="noticeContent"
						            <%if("noticeContent".equals(condition)){%>
						            	selected="selected"
						            <%}%>
						            >내용</option>
						        </select>
						   	</div>
						   	<div class="col-sm-4">
						       	<div class="input-group">
								  <input type="text" class="form-control" placeholder="검색어 입력" name="searchKeyword" value="<%=keyword%>" >
								  <button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
								</div>
						     </div>  
					   	</div>
				    </form>
				<%if(rigNo==2){%>
					<a href='noticeWrite.jsp' style="float:right">
						<button type="button" class="btn btn-primary">
						공지작성
						</button>
					</a>
				<%} %>
			</div>
		<div id="map-canvas" style="width:25%;height: 150px"></div>
		</div>
	</div>
<%@ include file="../inc/bottom.jsp"%>