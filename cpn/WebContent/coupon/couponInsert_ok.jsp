<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.coupon.model.couponService"%>
<%@page import="com.cpn.coupon.model.couponVO"%>
<%@page import="com.cpn.coupon.model.couponDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.cpn.common.util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	try{
		//파일 업로드 처리
		String saveDir=util.SAVE_DIR;
		
		int maxSize=2*1024*1024;
		
		MultipartRequest mr= new MultipartRequest(request,saveDir,maxSize,"UTF-8",
				new DefaultFileRenamePolicy());
		System.out.println("업로드 완료");
		
		//업로드한 파일의 정보 구하기 (업로드파일명,원본파일명,파일크기)
		String coupFileName=mr.getFilesystemName("coupFileName");
		String coupOriginalFileName="";
		long coupFileSize=0;
		if(coupFileName!=null && !coupFileName.isEmpty()){ //파일을 첨부한 경우(업로드 한 경우)에만 처리
			coupOriginalFileName=mr.getOriginalFileName("coupFileName");
		
			File file=mr.getFile("coupFileName");
			coupFileSize=file.length();
		}else{
			coupFileName="";
		}%>
<jsp:useBean id="vo" class="com.cpn.coupon.model.couponVO"></jsp:useBean>
<%
		
		//쿠폰 데이터입력 처리
		//1
		//Multipart에서 인코딩처리를 하였으므로 인코딩처리 불필요함
		System.out.println(mr.getParameter("coupPrice"));
		String ctgNo=mr.getParameter("ctgNo");
		vo.setCoupName(mr.getParameter("coupName"));
		vo.setCtgNo(Integer.parseInt(ctgNo));
		vo.setCoupPrice(Integer.parseInt(mr.getParameter("coupPrice")));
		String coupStartDate=mr.getParameter("coupStartDate");
		String coupEndDate=mr.getParameter("coupEndDate");
		
		Date d1 = Date.valueOf(coupStartDate);
		Date d2 = Date.valueOf(coupEndDate);
		Timestamp t1 = new Timestamp(d1.getTime());
		Timestamp t2 = new Timestamp(d2.getTime());
		vo.setCoupStartDate(t1);
		vo.setCoupEndDate(t2);
		vo.setCoupContent(mr.getParameter("coupContent"));
		vo.setLocNum(Integer.parseInt(mr.getParameter("locNum")));
		vo.setLatitude(Double.parseDouble(mr.getParameter("latitude")));
		vo.setLongitude(Double.parseDouble(mr.getParameter("longitude")));
		vo.setAddress(mr.getParameter("address"));
		vo.setCoupFileName(coupFileName);
		vo.setCoupOriginalFileName(coupOriginalFileName);
		vo.setCoupFileSize(coupFileSize);
		//2
		System.out.println(vo);
		couponService serv=new couponService();
		int cnt=serv.insertCoup(vo);
		if(cnt>0){%>
		<script type="text/javascript">
			alert('쿠폰 입력 처리되었습니다');
			location.href="couponInsert.jsp";
		</script>	
	<%}else{%>
		<script type="text/javascript">
			alert('쿠폰입력실패!');
			history.back();
		</script>		
	<%}
	}catch(SQLException e){
		e.printStackTrace();
	}catch(IOException e){
		e.printStackTrace();%>
		<script type="text/javascript">
			alert('2M 이상은 첨부할 수 없습니다!');
			history.back();
		</script>		
	<%}
	
	//3
%>
</body>
</html>