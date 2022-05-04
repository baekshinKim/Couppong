<%@page import="com.cpn.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memService" class="com.cpn.member.model.MemberService" 
	scope="session"></jsp:useBean>    
<%-- <jsp:useBean id="memDao" class="com.mystudy.member.model.MemberDAO" 
	scope="session"></jsp:useBean>     --%>
<%
	//[1] register.jsp에서 open()에 의해 이동
	//=> http://localhost:9090/mystudy/member/checkId.jsp?memid=hong
	//[2] checkId.jsp에서 post방식으로  submit
	
	//1
	request.setCharacterEncoding("utf-8");
	String memid=request.getParameter("memid");
	
	//2
	int result=0;
	if(memid!=null && !memid.isEmpty()){
		try{
			result=memService.checkDup(memid);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	//3
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css"/>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btUse').click(function(){
			$(opener.document).find('#memid').val("<%=memid%>");
			$(opener.document).find('#chkId').val("Y");	
			self.close();
		});
		
		
	});
</script>
</head>
<body>
	<h2>아이디 중복 검사</h2><br>
	<form name="frmId" method="post" action="checkId.jsp">
		<input type="text" name="memid" id="memid" 
		 title="아이디입력" value="<%=memid%>">
		<input type="submit"  id="submit" value="아이디 확인">
		
		<%
		if(result==MemberService.EXIST_ID){%>
			<p>이미 등록된 아이디입니다. 다른 아이디를 입력하세요.</p>
	<%	}else if(result==MemberService.NON_EXIST_ID){%>
			<input type="button" value="사용하기" id="btUse">
			<p>사용가능한 아이디입니다.[사용하기]버튼을 클릭하세요</p>
	<%	}	%>
	</form>
	
</body>
</html>