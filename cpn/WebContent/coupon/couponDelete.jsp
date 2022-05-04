<%@page import="java.io.File"%>
<%@page import="com.cpn.common.util"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.coupon.model.couponVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
<%
	//파리미터=coupNo GET방식
	request.setCharacterEncoding("utf-8");
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	
	if(rigNo!=util.STAFF){%>
		<script type="text/javascript">
			alert("접근 권한이 없습니다.");
			location.href="<%=request.getContextPath()%>/index.jsp";
		</script>
	<%}
	
	String coupNo=request.getParameter("coupNo");
	if(coupNo==null || coupNo.isEmpty()){%>
		<script type="text/javascript">
			alert("잘못된 접근입니다.");
			location.href="<%=request.getContextPath()%>/index.jsp";
		</script>
	<%
	}
	
	couponVO vo=new couponVO();
	int cnt=0;
	try{
		vo=coupServ.selectByNo(Integer.parseInt(coupNo));
		
		
		String coupFileName=vo.getCoupFileName();
		if(coupFileName!=null && !coupFileName.isEmpty()){
			String saveDir=util.SAVE_DIR;
			File file=new File(saveDir,coupFileName);
			if(file.exists()){
				boolean bool=file.delete();
			}
		}
		
		cnt=coupServ.deleteCoupon(Integer.parseInt(coupNo));
	}catch(SQLException e){
		e.printStackTrace();
	}
	if(cnt>0){%>
		<script type="text/javascript">
		alert("쿠폰삭제성공!");
		location.href="couponList.jsp";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert("쿠폰삭제실패ㅠㅠ");
			location.href="couponDetail.jsp?coupNo=<%=coupNo%>";
		</script>
	<%}
	
%>
</body>
</html>