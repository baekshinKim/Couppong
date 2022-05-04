<%@page import="com.cpn.member.model.MemberService"%>
<%@page import="com.cpn.common.PagingVO"%>
<%@page import="com.cpn.common.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.cpn.questionboard.model.ReQuestionBoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.questionboard.model.ReQuestionBoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<%
	//1) write.jsp에서 [글목록]클릭하면 get방식으로 이동
	//또는 write_ok.jsp에서 글쓰기 성공하면 get방식으로 이동
	//2) list.jsp에서 검색 버튼 클릭하면 post방식으로 submit
	//3) list.jsp에서 페이지번호를 클릭하면 get방식으로 이동
	
	int memNo=0;
	
	if(session.getAttribute("memNo")!=null){
		memNo=(Integer)session.getAttribute("memNo");
	}

	//1	
	request.setCharacterEncoding("utf-8");
	String condition=request.getParameter("searchCondition");
	String keyword=request.getParameter("searchKeyword");
	//int memNo=Integer.parseInt(request.getParameter("memNo"));
	
	//2
	ReQuestionBoardDAO dao = new ReQuestionBoardDAO();
	
	List<ReQuestionBoardVO> list=null;
	try{
		list=dao.selectAll(condition, keyword);	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//페이징 처리
	int currentPage=1;  //현재 페이지
	
	//페이지번호를 클릭한 경우 처리
	if(request.getParameter("currentPage")!=null){
	  currentPage=Integer.parseInt(request.getParameter("currentPage"));		
	}
	
	//[1] 현재 페이지와 무관한 변수
	int totalRecord=0;  //총 레코드 수
	if(list!=null && !list.isEmpty()){
		totalRecord = list.size();  //예) 17
	}
	
	int pageSize=5;  //한 페이지에 보여줄 레코드(행) 수
	int blockSize=10; //한 블럭에 보여줄 페이지 수
		
	PagingVO pageVo = new PagingVO(currentPage, totalRecord, pageSize,blockSize);
	MemberService memServ=new MemberService();
%>


<link href="../css/top.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">	
$(function(){
	$('.divList table.box2 tbody tr').hover(function(){
		$(this).css('background','lightblue');
	}, function(){
		$(this).css('background','');		
	});	
});
</script>

<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }
	 
    tr{
          position:static;
       }
       
       .fixed-top{
          position:static;
       }
       
       #mainNav{
        background-color: #F9C8C8 !important; 
       }
</style>   	 		
<h2>1:1게시판</h2>
<%
	if(keyword !=null && !keyword.isEmpty()){ %>
		<p>검색어 : <%=keyword %>, <%=list.size() %>건 검색되었습니다.</p>
<%	}else{	
		keyword="";
	}%>
<div class="divList">
<table class="box2"
	 	summary="답변형 게시판에 관한 표로써, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보를 제공합니다." style="text-align: center">
	
	<colgroup>
		<col style="width:5%;" />
		<col style="width:25%; text-align: center;"  />
		<col style="width:45%; text-align: center;" />
		<col style="width:15%;" />
		<col style="width:10%;" />		
	</colgroup>
	<thead>
	  <tr>
	    <th scope="col">번호</th>
	    <th scope="col">회원아이디</th>
	    <th scope="col">제목</th>
	    <th scope="col">작성일</th>
	    <th scope="col">조회여부</th>
	    </tr>
	    
	</thead> 
	<tbody> 
		<%if(list==null || list.isEmpty()){ %>
			<tr>
				<td colspan="5" class="align_center">데이터가 존재하지 않습니다.</td>
			</tr>
		<%}else{ %>		 
		  	<!--게시판 내용 반복문 시작  -->		
			<%
			
			int num=pageVo.getNum();
			int curPos=pageVo.getCurPos();
			
			for(int i=0;i<pageVo.getPageSize();i++){
				if(num<1) break;
				
				ReQuestionBoardVO vo=list.get(curPos++);
				num--;
			%>
				<tr style="text-align:center">
					<td><%=num+1%></td>
					<td><%=memServ.selectNameByNo(vo.getMemNo())%></td>
					<td style="text-align:left">
						<%if(vo.getQBoardPrivateFlag().equals("Y") && vo.getMemNo()!=memNo){ %>
							<!-- 삭제된 글인 경우 -->
							<span style="color:gray">비공개된 글입니다.</span>
						<%}else{%>
							<!-- 답변글인 경우 단계별로 이미지 보여주기 -->
							<%=Utility.displayRe(vo.getQBoardStep()) %>
							<!-- 제목이 긴 경우 일부만 추출 -->
							<a href="detail.jsp?no=<%=vo.getQBoardNo() %>" style="text-decoration: none;color: black">
								<%=Utility.cutString(vo.getQBoardTitle(), 24) %>
							</a>
							
							<!-- 24시간 이내의 글인 경우 new이미지 보여주기 -->
							<%=Utility.displayNew(vo.getQBoardRegdate())%>
						<%}//if %>	
					</td>
					<td><%=sdf.format(vo.getQBoardRegdate()) %></td>
					<td><%=vo.getQBoardRigReadFlag() %></td>		
				</tr>
			<%}//for 
		  }//if%>
	  <!--반복처리 끝  -->
	  </tbody>
</table>	   
</div>
<div class="divPage">
	<!-- 페이지 번호 추가 -->		
	<!-- 이전 블럭으로 이동 -->
	<%if(pageVo.getFirstPage()>1){ %>
		<a href="list.jsp?currentPage=<%=pageVo.getFirstPage()-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
			<img src="../images/first.JPG" alt="이전블럭으로 이동">
		</a>
	<%}//if %>
						
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%
		for(int i=pageVo.getFirstPage();i<=pageVo.getLastPage();i++){
			if(i>pageVo.getTotalPage()) break; 
			
			if(i==currentPage){	%>
				<span style="color:blue;font-weight: bold">
					<%=i %></span>
			<%}else{ %>
				<a href
="list.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
					[<%=i %>]</a>
			<%}//if %>
	<%	}//for	%>
	
	<!-- 다음 블럭으로 이동 -->
	<%if(pageVo.getLastPage() < pageVo.getTotalPage()){ %>
		<a href="list.jsp?currentPage=<%=pageVo.getLastPage()+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
			<img src="../images/last.JPG" alt="다음 블럭으로 이동">
		</a>
	<%}//if %>
	
	<!--  페이지 번호 끝 -->
</div>
<div class="divSearch">
   	<form name="frmSearch" method="post" action='list.jsp'>
        <select name="searchCondition">
            <option value="title" 
            	<%if("rqtitle".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >제목</option>        
            <option value="rqno" 
            	<%if("rqno".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >회원번호</option>
            <option value="content"
            	<%if("rqcontent".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >내용</option>
        </select>   
        <input type="text" name="searchKeyword" title="검색어 입력"
        	value="<%=keyword%>">   
		<input type="submit" value="검색">
    </form>
</div>

<div class="divBtn">
    <a href='write.jsp' >글쓰기</a>
</div>
 <%@ include file="../inc/bottom.jsp"%>  


