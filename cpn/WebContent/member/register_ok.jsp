<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="memVo" class="com.cpn.member.model.MemberVO" 
	scope="page"></jsp:useBean>
	
<jsp:useBean id="memService" class="com.cpn.member.model.MemberService" 
	scope="session"></jsp:useBean>


<%
	//post
	//1
	request.setCharacterEncoding("utf-8");
	System.out.println("register_ok로넘어옴");
	
	String memid=request.getParameter("memid");
	String memName=request.getParameter("memName");
	String memPwd=request.getParameter("memPwd");
	
	String memAddress=request.getParameter("memAddress");

	//hp1 + hp2 + hp3 묶어서 memTel
	String hp1=request.getParameter("hp1");
	String hp2=request.getParameter("hp2");
	String hp3=request.getParameter("hp3");
	
	String email1=request.getParameter("email1");
	String email2=request.getParameter("email2");
	String email3=request.getParameter("email3");
	
	//2
	String msg="회원가입 실패!", url="/member/register.jsp";
	
	try{
		String memEmail="", memTel="";
		if(hp2!=null && !hp2.isEmpty() && hp3!=null && !hp3.isEmpty()){
			memTel =hp1+"-"+hp2+"-"+hp3;
		}
		
		if(email1!=null && !email1.isEmpty()){
			if(email2.equals("etc")){
				if(email3!=null && !email3.isEmpty()){
					memEmail =email1+"@"+email3;
				}
			}else{
				memEmail =email1+"@"+email2;
			}
		}

		//필수입력 : 이름, 아이디, 비밀번호
		memVo.setMemName(memName);
		memVo.setMemId(memid);
		memVo.setMemPwd(memPwd);
		
		//그외 : 연락처, 주소, 이메일
		memVo.setMemTel(memTel);
		memVo.setMemAddress(memAddress);
		memVo.setMemEmail(memEmail);
		
		
		int cnt=memService.insertMember(memVo);
		if(cnt>0){
			msg="회원가입되었습니다.";
			url="/index.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3	
	/*
		여기서 setAttribute 
	 	-> 공유하는 forward page="../common/message.jsp" 페이지에서
	 	getAttribute 
	 	==>> 같은 request 영역안에서 msg와 url을 공유할 수 있다 
	 */ 
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);	
%>

<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>