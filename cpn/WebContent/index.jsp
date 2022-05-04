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
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>coupongg</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" type="text/css"/>
        <link href="css/bs_top.css" rel="stylesheet" type="text/css"/>
      <link href="css/yncss.css" rel="stylesheet" type="text/css"/>
      <link href="css/hycss.css" rel="stylesheet" type="text/css"/>
      <%--<link href="<%=request.getContextPath() %>/css/styles.css" rel="stylesheet" type="text/css"/> --%>
        <!-- <link href="CSS 파일 경로" rel="stylesheet" type="text/css"> -->

        <!-- 부트스트랩css -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
       <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
       <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
       <link rel="stylesheet" href="css/bootstrap-datepicker3.css">
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
   <script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
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
   
   <body>   
<!-- 공지 -->
   <ul class="nav justify-content-center">
      <li class="nav-item"><a class="nav-link active"
         aria-current="page" href="noticeBoard/noticeDetail.jsp?noticeNo=20">코로나 19 관련 공지</a>
   </ul>
<!-- Navigation-->
      <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav" style="height: 80px">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="index.jsp">
               <img alt="쿠퐁~~" src="imgs/logo.png" style="width: 160px">
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
				<%}%>
               <li><a class="dropdown-item" href="coupon/couponList.jsp?ctgNo=1">액티비티</a></li>
               <li><a class="dropdown-item" href="coupon/couponList.jsp?ctgNo=2">어트랙션</a></li>
               <li><a class="dropdown-item" href="coupon/couponList.jsp?ctgNo=3">티켓</a></li>
               <li><a class="dropdown-item" href="coupon/couponList.jsp?ctgNo=4">체험</a></li>
               <li><a class="dropdown-item" href="coupon/couponList.jsp?ctgNo=5">투어</a></li>
                  </ul>
               </div>
               <%if(t_isLogin){ %>
				   <div class="dropdown">
					  <a class="btn  dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
					   MY PAGE
					  </a>
					
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
					    <li><a class="dropdown-item" href="member/memberEdit.jsp">회원정보 수정</a></li>
					    <li><a class="dropdown-item" href="like/myLike.jsp">내 관심 목록</a></li>
					    <li><a class="dropdown-item" href="reservation/myReserveList.jsp">내 예약 목록</a></li>
					  </ul>
					</div>
				<%} %>
<div class="dropdown">
  <a class="btn  dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
    COMMUNITY
  </a>

  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
     <li><a class="dropdown-item" href="noticeBoard/noticeList.jsp">공지사항</a></li>
    <li><a class="dropdown-item" href="reboard/list.jsp">1:1문의</a></li>
  </ul>
</div>

<%if(!(t_isLogin||a_isLogin)){%>
    <li class="nav-item"><a class="nav-link" href="login/login.jsp" >LOGIN</a></li>
     <li class="nav-item"><a class="nav-link" href="member/agreement.jsp" >JOIN US</a></li> 
<%} else {%>
    <li class="nav-item"><a class="nav-link" href="login/logout.jsp" >LOGOUT</a></li>
<% }%>

            </ul>
         </ul>
      </div>
</nav>
        
<!-- 이미지 -->
   <div class="overlap"></div>

   <section class="home-banner"
      style="background-image: url(&quot;https://images.unsplash.com/photo-1535189043414-47a3c49a0bed?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1189&q=80/1.jpg&quot); background-height: 400px;">
   <div class="overlap"></div>
   <div class="home-search">
      <div class="container">
         <div class="row">
            <div class="col-md-6">
               <div class="kksearch">
                  <h1 class="title">어디로 갈까요?</h1>
                  <h5 class="sub-title">현지패스와 입장권을 공식판매가, 얼리버드보다 저렴하게!</h5>
                  <div class="search-block">
                     <div class="input-group">
                     	<form action="<%=request.getContextPath()%>/coupon/couponList.jsp" method="post" style="width: 640px">
                         <input id="search_experience_value" placeholder="검색 도시, 여행지, 투어 혹은 액티비티를 입력하세요." type="text" aria-autocomplete="both" aria-haspopup="false"
                            autocapitalize="off" autocomplete="off" spellcheck="false" maxlength="50" class="form-control" name="searchTxt" style="width: 570px;float: left">
                          <span class="clear-input" style="display: none;">
                          	<i class="fa fa-times-circle fa-lg"></i>
                          </span> 
                          <span class="input-group-btn">
                           <button class="btn btn-primary" id="btSearch" type="submit">
                       		<i class="fa fa-search fa-lg"></i>
                       	</button>
                      	</span>
                     	</form>
                     </div>
                     <div class="search-dropdown" style="display: none;">
                     </div>
                  </div>
                  <!---->
               </div>
            </div>
         </div>
      </div>
   </div>
</section>
   <section class="theme-section">
      <div class="container">
         <div class="theme-lists">
            <a href="coupon/couponList.jsp?ctgNo=0">
               <div class="theme-block">
                  <div class="theme-type">
                     <i class="icon theme-icon theme-icon-covid19"></i>
                  </div>
                  <p class="theme-p">쿠폰</p>
               </div>
            </a>
                     
            <a href="coupon/couponList.jsp?ctgNo=1">
               <div class="theme-block">
                  <div class="theme-type">
                     <i class="icon theme-icon theme-icon-outdoor2"></i>
                  </div>
                  <p class="theme-p">액티비티</p>
               </div>
            </a>

            <!-- 편집 -->
            <a href="coupon/couponList.jsp?ctgNo=2">
               <div class="theme-block">
                  <div class="theme-type">
                     <i class="icon theme-icon theme-icon-park"></i>
                  </div>
                  <p class="theme-p">어트랙션</p>
               </div>
            </a> 
            <a href="coupon/couponList.jsp?ctgNo=3">
               <div class="theme-block">
                  <div class="theme-type">
                     <i class="icon theme-icon theme-icon-attraction"></i>
                  </div>
                  <p class="theme-p">티켓</p>
               </div>
            </a> 
            <a href="coupon/couponList.jsp?ctgNo=4">
               <div class="theme-block">
                  <div class="theme-type">
                     <i class="icon theme-icon theme-icon-family"></i>
                  </div>
                  <p class="theme-p">체험</p>
               </div>
            </a> 
            <a href="coupon/couponList.jsp?ctgNo=5">
               <div class="theme-block">
                  <div class="theme-type">
                     <i class="icon theme-icon theme-icon-rent"></i>
                  </div>
                  <p class="theme-p">투어</p>
               </div>
            </a>
         </div>
      </div>
   </section>

<%@include file="inc/bottom.jsp" %>
        
        