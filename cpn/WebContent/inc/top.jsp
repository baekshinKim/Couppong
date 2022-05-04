<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%
	boolean t_isLogin=false;
	String t_userid = (String)session.getAttribute("memid");
	if(t_userid!=null && !t_userid.isEmpty()){
		t_isLogin=true;  //로그인 된 경우
	}

   boolean a_isLogin=false;
   String a_userid = (String)session.getAttribute("adminId");
   if(a_userid!=null && !a_userid.isEmpty()){
   a_isLogin=true;  //관리자 로그인 된 경우
   }
%>
      
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>coupongg</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath()%>/css/bs_top.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath()%>/css/yncss.css" rel="stylesheet" type="text/css"/>

        <!-- 부트스트랩css -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
       <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
       	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
   		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
 		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-datepicker3.css">
 <!-- ** -->   
    <script
   src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
   integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU"
   crossorigin="anonymous"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"
   integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj"
   crossorigin="anonymous"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
   crossorigin="anonymous">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
   crossorigin="anonymous">

  
        <!--제이쿼리-->
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.5.1.min.js"></script>
        
    <style type="text/css">
             
       .navbar{
          position:static;
       }
       
       .fixed-top{
          position:static;
       }
       
       #mainNav{
        background-color: #F9C8C8 !important; 
       }
       
       
       .footer{
       
           background-color: #1a252f !important;  
       }
       
    </style>   

</head>
   
    
     <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav" style="height: 80px">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="<%=request.getContextPath()%>/index.jsp">
               <img alt="쿠퐁~~" src="<%=request.getContextPath()%>/imgs/logo.png" style="width: 160px">
            </a>
            
            <ul class="header-nav" style="height: 20px">
            <!-- bar -->
            <ul class="nav justify-content-end" id="topMenu-ul">
                
                <!-- 드롭다운-->

               <div class="dropdown topdrop">
                  <a class="btn dropdown-toggle" href="#"
                     role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
                     aria-expanded="false"> COUPPONG </a>

                  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					<%if(a_isLogin){%>
						<li><a class="dropdown-item" href="<%=request.getContextPath()%>/coupon/couponInsert.jsp">쿠폰등록</a></li>					
					<% }%>
                    <li><a class="dropdown-item" href="<%=request.getContextPath()%>/coupon/couponList.jsp?ctgNo=1">액티비티</a></li>
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/coupon/couponList.jsp?ctgNo=2">어트랙션</a></li>
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/coupon/couponList.jsp?ctgNo=3">티켓</a></li>
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/coupon/couponList.jsp?ctgNo=4">체험</a></li>
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/coupon/couponList.jsp?ctgNo=5">투어</a></li>
                  </ul>
               </div>
               <%if(t_isLogin){ %>
   <div class="dropdown">
  <a class="btn  dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
   MY PAGE
  </a>

  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
    <li><a class="dropdown-item" href="<%=request.getContextPath()%>/member/memberEdit.jsp">회원정보 수정</a></li>
    <li><a class="dropdown-item" href="<%=request.getContextPath()%>/like/myLike.jsp">내 관심 목록</a></li>
    <li><a class="dropdown-item" href="<%=request.getContextPath()%>/reservation/myReserveList.jsp">내 예약 목록</a></li>
  </ul>
</div>
<%} %>
<div class="dropdown">
  <a class="btn  dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
    COUMMUNITY
  </a>

  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
    <li><a class="dropdown-item" href="<%=request.getContextPath()%>/noticeBoard/noticeList.jsp">공지사항</a></li>
    <li><a class="dropdown-item" href="<%=request.getContextPath()%>/reboard/list.jsp">1:1문의</a></li>
  </ul>
</div>

<%if(!(t_isLogin||a_isLogin)){%>
    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/login/login.jsp" >LOGIN</a></li>
     <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/member/agreement.jsp" >JOIN US</a></li> 
<%} else {%>
    <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/login/logout.jsp" >LOGOUT</a></li>
<% }%>
            </ul>
         </ul>
      </div>
   </div>
 </div>
        </nav>
        
        <!-- 이미지 -->
   <div class="overlap"></div>