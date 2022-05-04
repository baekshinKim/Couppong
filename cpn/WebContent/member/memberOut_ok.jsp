<%@page import="com.cpn.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memService" class="com.cpn.member.model.MemberService"
 scope="session"></jsp:useBean>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOut_ok</title>
</head>
<body>
<%
	//memberOut에서 post
	//1
	request.setCharacterEncoding("utf-8");
	String memPwd = request.getParameter("memPwd");

	//탈퇴처리도 세션에서 아이디 읽어다가 where조건에 userid로 탈퇴처리
	String ck_userid = (String)session.getAttribute("memid");
	
	//2 DB작업 비번체크
	String msg = "회원탈퇴, 비밀번호를 확인해주세요" , url = "/member/memberOut.jsp";
	try{
		int result = memService.loginCheck(ck_userid, memPwd);	//로그인체크먼저하고
		
		if(result == MemberService.LOGIN_OK){
			int cnt=memService.withdrawMember(ck_userid);		// outdate를 sysdate로 넣는 탈퇴메서드 
			if(cnt>0){ //성공하면
				msg = "회원탈퇴 처리되었습니다.";
				url="/index.jsp";
				
				//[1] 탈퇴했으니까 세션값 없애기
				session.invalidate();
				
				//[2] 쿠키도 없애기 (아이디저장된 쿠키 없애기 -> 유효시간 0으로)
				Cookie ck = new Cookie("ck_memid",memPwd);
				ck.setMaxAge(0);	//쿠키삭제
				ck.setPath("/");
				response.addCookie(ck);
				
			} 
			
		}else if(result == MemberService.PWD_DISAGREE){
			msg = "비밀번호 불일치";
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