<%@page import="com.cpn.admin.model.adminVO"%>
<%@page import="com.cpn.admin.model.adminService"%>
<%@page import="com.cpn.member.model.MemberVO"%>
<%@page import="com.cpn.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memService" class="com.cpn.member.model.MemberService"	
scope="page"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 OK</title>
</head>
<body>
<%
	//login.jsp에서 [로그인]클릭해서 post로 이동
	request.setCharacterEncoding("utf-8");
	String memid = request.getParameter("memid");
	String memPwd= request.getParameter("memPwd");
	String chkSave= request.getParameter("chkSave");
	
	//submit이 mem_submit인지 / admin_submit인지
	String chkAdmin = request.getParameter("chkAdmin");

	
	String msg="";
	String url="";
	
	//관리자로그인에 체크한 경우
	if(chkAdmin != null){
		adminService adminService = new adminService();
		int adminCheck = adminService.adminLoginCheck(memid, memPwd);	//입력값 받아서 admin인지 체크
		//member와 admin테이블이 분리되어있기 때문에 admin로그인체크로 admin여부 판별
		// adminCheck결과
		// 0 관리자아님 | 1 관리자로그인 성공 | 2 아이디없음 | 3 관리자 비번확인
		 if(adminCheck==1){
			msg="관리자로 로그인되었습니다";
			url="/index.jsp";
			
			try{
				adminVO vo=adminService.selectAdminByAdminId(memid);// 아이디 입력값으로 정보 가져옴
				
				//세션에 저장
				session.setAttribute("adminNo", vo.getAdminNo());
				session.setAttribute("adminName", vo.getAdminName());
				
				session.setAttribute("adminId", memid);//입력값을 관리자아이디로 세션에 저장
				session.setAttribute("adminPwd", memPwd);//입력값을 관리자비번으로 세션에 저장
				session.setAttribute("rigNo", vo.getRigNo());//관리자의 권한번호 
				
				//디버깅
				String adminVo = vo.toString();
				System.out.println("[저장된 관리자 정보] adminNo="+vo.getAdminNo()
				+"\tadminName"+vo.getAdminName()
				+"\tadminId"+memid +"adminName"+memPwd
				+"\tadminRigNo"+vo.getRigNo());
			}catch(SQLException e){
			System.out.println("관리자확인중 SQL익셉션");
				
				e.printStackTrace();
			}
		}else if(adminCheck==2){
			msg="관리자 아이디를 확인하세요";
			url="/login/login.jsp";
			
		}else if(adminCheck==3){
			msg="관리자 비밀번호를 확인하세요";
			url="/login/login.jsp";
		}else if(adminCheck==0){
			msg="관리자로그인 권한이 없습니다";
			url="/login/login.jsp";
			
		}
		
		
	}else{//if:관리자로그인에 체크한 경우
		
		//관리자로그인에 체크 안한 경우
		//DB작업
		msg="로그인처리 실패";
		url="/login/login.jsp";
						//메세지jsp에있으니까 ->ContextPath제외하고 작성
		try{
			int result = memService.loginCheck(memid, memPwd);
			
			//결과msg
			if(result==MemberService.LOGIN_OK){	//성공한 경우
				//1) 로그인 정보 세션에 저장 -> 필수★	
				
				//selectMember해서 정보 불러온 후 
				MemberVO vo = memService.selectMember(memid);
	
				//vo에서 필요한정보만 get하고
				int memNo = vo.getMemNo();
				String memName = vo.getMemName();
				String memEmail = vo.getMemEmail();
				int rigNo = vo.getRigNo();
				
				// 입력받아서 가져온 아이디, 비번 setAttribute하기
				session.setAttribute("memNo", memNo);
	
				session.setAttribute("memid", memid);
				session.setAttribute("memPwd", memPwd);
	
				//아이디비번으로 vo에서 get해온 정보를 setAttribute하기
				session.setAttribute("memName", memName);
				session.setAttribute("memEmail", memEmail);
				session.setAttribute("rigNo", rigNo);
				
				/************************
					세션에 꼭 저장할 것들 
					1. 회원번호 memNo
					2. 아이디 memid
					3. 비번	memPwd
					4. 이름	memName
					5. 이메일	memEmail
					6. 권한번호 rigNo
				
				*************************/
	
				//2) [아이디저장 체크한경우만] 쿠키에 저장
					Cookie ck = new Cookie("ck_memid",memid);
					ck.setPath("/");	
				
				if(chkSave != null ){	//체크한 경우
					ck.setMaxAge(1000*24*60*60);												
					response.addCookie(ck);
					
				}else{	//체크안한경우
					ck.setMaxAge(0);	//쿠키삭제
					response.addCookie(ck);
					
				}
				msg = vo.getMemName() +"님 로그인되었습니다";
				url="/index.jsp";
				
			}else if(result==MemberService.PWD_DISAGREE){
				msg=" 비번 불일치";
			}else if(result==MemberService.ID_NONE){
				msg=" 아이디없음";
				
			}
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}
	}//if:관리자로그인에 체크한 경우
	//3
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>

<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>