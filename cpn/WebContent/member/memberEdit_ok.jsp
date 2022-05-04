<%@page import="com.cpn.member.model.MemberService"%>
<%@page import="com.cpn.member.model.MemberVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../login/login_check.jsp" %>
    
    <jsp:useBean id="memService" class="com.cpn.member.model.MemberService"
    scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberEdit_ok.jsp</title>
</head>
<body>
<%
	//1
	request.setCharacterEncoding("utf-8");
	String memid = (String)session.getAttribute("memid");
	String memName = (String)session.getAttribute("memName");
	
	String memPwd = request.getParameter("memPwd");
	String memAddress = request.getParameter("memAddress");
	
	//memTel
	String hp1 = request.getParameter("hp1");
	String hp2 = request.getParameter("hp2");
	String hp3 = request.getParameter("hp3");

	//memEmail
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email3 = request.getParameter("email3");

	String memTel="", memEmail="";
	if(hp2!=null && !hp2.isEmpty() && hp3!=null && !hp3.isEmpty()){
		memTel = hp1+"-"+hp2+"-"+hp3;
	}

	if(email1!=null && !email1.isEmpty()){
		if(email2.equals("etc")){
			if(email3!=null && !email3.isEmpty()){
				memEmail = email1 + "@" + email3;
			}//email3이있을 때만 
		}else{
			memEmail = email1 + "@" + email2;
		}
	}
	
	//DB작업
	
	String msg="비번체크실패", url="/member/memberEdit.jsp";
	try{
		//비밀번호 체크 여기서
		int result = memService.loginCheck(memid, memPwd);

	
		if(result==MemberService.LOGIN_OK){
			MemberVO vo = new MemberVO();//수정된 정보를 담을 새로운 VO
			vo.setMemId(memid);

			vo.setMemTel(memTel);
			vo.setMemAddress(memAddress);
			vo.setMemEmail(memEmail);
			
			int cnt = memService.updateMember(vo);
			
			if(cnt>0){
				msg="회원정보 수정되었습니다";
				
			}else{
				msg="회원정보 수정 실패!";
				
			}
			
		}else if(result==MemberService.PWD_DISAGREE){
			msg="비밀번호가 일치하지 않습니다, 다시 확인해주세요";
		}
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>

</body>
</html>