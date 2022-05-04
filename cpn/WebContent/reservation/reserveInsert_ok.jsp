<%@page import="com.cpn.reservation.model.ReservationVO"%>
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
	<jsp:useBean id="reserveService"
		class="com.cpn.reservation.model.ReservationService" scope="page">
	</jsp:useBean>
	<jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
	
	<%
		//할일1 : 입력값 가져와서 DB작업 isnertReservation 하기

	//reserveInsert.jsp에서 form안에 있던 value파라미터
	/* String memid = request.getParameter("memid");
	String memNo = request.getParameter("memNo");//파라미터라서 String으로
	String memName = request.getParameter("memName"); */

	int memNo = (Integer) session.getAttribute("memNo");
	if(memNo<=0){%>
	<script type="text/javascript">
		alert("로그인 해주세요");		
		history.back();
		return false;
	</script>
	<%}

	String str_coupNo = request.getParameter("coupNo");
	int coupNo = Integer.parseInt(str_coupNo);
	if(coupNo==0){%>
		<script type="text/javascript">
		alert("잘못된 요청입니다.");
		location.href="<%=request.getContextPath()%>/coupon/couponList.jsp";
		return false;
		</script>
	<%}
	

	// 쿠폰상세에서 파라미터 넘겨받을 값은 -> 쿠폰번호, 수량, 총금액(reservePrice), 시작일(), 종료일()
	//String coupName = request.getParameter("coupName");

	//총금액 : reserveInsert.jsp에서 계산해서보냄 
	String reservePer = request.getParameter("reservePer");
	String reservePrice = request.getParameter("reservePrice");
	
	//////////////////DB작업
	String msg = "예약 실패, 다시 예약해주세요.", url = "/coupon/couponDetail.jsp?coupNo=" + coupNo;
	try {

		ReservationVO reserveVo = new ReservationVO();
		
		reserveVo.setCoupNo(coupNo);
		reserveVo.setMemNo(memNo);//16회원으로 테스트
		reserveVo.setReservePrice(Integer.parseInt(reservePrice));
		reserveVo.setReservePer(Integer.parseInt(reservePer));

		int cnt = reserveService.insertReservation(reserveVo);

		if (cnt > 0) {
			msg = "예약 되었습니다, 내 예약목록에서 확인할 수 있습니다";
			url = "/reservation/myReserveList.jsp";
			coupServ.purUp(coupNo);
		}

	} catch (SQLException e) {
		e.printStackTrace();
	}

	//3
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	%>
	<jsp:forward page="../common/message.jsp"></jsp:forward>

</body>
</html>