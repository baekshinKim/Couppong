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
<jsp:useBean id="likeServ" class="com.cpn.like.model.LikeService"></jsp:useBean>
<jsp:useBean id="vo" class="com.cpn.like.model.LikeVO"></jsp:useBean>
<jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
<%
	int memNo=0;
	int coupNo=0;
	if(session.getAttribute("memNo")==null){%>
		<script type="text/javascript">
			alert("먼저 로그인하세요");
			location.href="../login/login.jsp";
		</script>
	<%}else{
		memNo=(int)session.getAttribute("memNo");
	}
	
	if(request.getParameter("coupNo")==null){%>
		<script type="text/javascript">
			alert("잘못된 접근입니다");
			location.href="../index.jsp";
		</script>
	<%}else{
		coupNo=Integer.parseInt(request.getParameter("coupNo"));
	}
	vo.setCoupNo(coupNo);
	vo.setMemNo(memNo);
	int cnt=0;
	try{
		if(likeServ.isLike(vo)){
			cnt=likeServ.insertLike(vo);
			cnt+=coupServ.likeUp(coupNo);
		}else{
			cnt=likeServ.deleteLike(vo);
			coupServ.likeDown(coupNo);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	System.out.println("현재 페이지 : likeCheck.jsp, cnt가 2가아니면 반영 x  cnt=>"+cnt);
	if(cnt>1){%>
		<script type="text/javascript">
			alert("좋아요 반영되었습니다");
			location.href="../coupon/couponDetail.jsp?coupNo=<%=coupNo%>";
		</script>
	<%}else if(cnt==1){%>
		<script type="text/javascript">
			alert("좋아요 해제되었습니다");
			location.href="../coupon/couponDetail.jsp?coupNo=<%=coupNo%>";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert("에러났다!");
			location.href="../index.jsp";
		</script>
	<%}
%>
</body>
</html>