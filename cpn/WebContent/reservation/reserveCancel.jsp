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
<jsp:useBean id="myService" class="com.cpn.reservation.model.ReservationService"
 scope="page"></jsp:useBean>
 <jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
<%

//세션에서 가져올 사용자 아이디, 이름 ,회원번호
	String reserveNo = (String)request.getParameter("reserveNo");
	int coupNo=Integer.parseInt(request.getParameter("coupNo"));
	//취소 DB작업
	String msg="예약 취소에 실패하였습니다.",url="/reservation/myReserveList.jsp";
	try{
		
		int cnt=myService.deleteReserve(Integer.parseInt(reserveNo));
		if(cnt>0){
			System.out.println("예약건 취소 성공");
		    msg="예약번호 : ["+reserveNo+"번 예약건]이 취소되었습니다";
		    url="/reservation//myReserveList.jsp";
		    coupServ.purDown(coupNo);
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