<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.cpn.coupon.model.couponVO"%>
<%@page import="com.cpn.common.util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<jsp:useBean id="coupServ" class="com.cpn.coupon.model.couponService"></jsp:useBean>
<jsp:useBean id="vo" class="com.cpn.coupon.model.couponVO"></jsp:useBean>
<%
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	
	if(rigNo!=util.STAFF){%>
		<script type="text/javascript">
			alert("접근권한이 없습니다.");
			history.back();
		</script>
	<%}
	//쿠ㅡ폰 수정처리
	
	request.setCharacterEncoding("utf-8");
	int coupNo=0;
	if(request.getParameter("coupNo")!=null&&!request.getParameter("coupNo").isEmpty()){
		coupNo=Integer.parseInt(request.getParameter("coupNo"));
	}else{
		request.setAttribute("msg", "잘못된 접근입니다 (coupNo is Null !!)");
		request.setAttribute("url", "/couponList.jsp");
		%>
		<jsp:forward page="../common/message.jsp" />
		<%
	}
	try{
		vo=coupServ.selectByNo(coupNo);		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	
%>
<script type="text/javascript">
	$(function() {
		$('#coupName').focus();

		$('form[name=frmEdit]').find('#listGo').click(function() {
			location.href = 'couponList.jsp';
		});

		$('form[name=frmEdit]').submit(function() {

			if ($('#ctgNo option:selected').val() =="") {
				alert('카테고리를 선택하세요');
				event.preventDefault();
				return false;
			}else if ($('#locNum option:selected').val() == "") {
				alert('지역을 선택하세요');
				event.preventDefault();
				return false;
			} else if (!validate_tude($("#latitude").val())) {
				alert('위도는 소수만 입력하세요')
				$(this).focus();
				event.preventDefault();
				return false;
			} else if (!validate_tude($("#longitude").val())) {
				alert('경도는 소수만 입력하세요')
				$(this).focus();
				event.preventDefault();
				return false;
			} else if (!validate_price($("#coupPrice").val())) {
				alert('가격은 숫자만 입력하세요')
				$(this).focus();
				event.preventDefault();
				return false;
			}
			
			$('input[type=text]').each(function() {
				if ($(this).val().length < 1) {
					alert("모든 항목을 입력하세요 (썸네일 제외)");
					$(this).focus();
					event.preventDefault();
					return false;
				};
			});

		});
	});
		
	function validate_tude(tude) {
		var pattern = new RegExp(/^[0-9.]+$/g);
		return pattern.test(tude);
	}

	function validate_price(price) {
		var pattern = new RegExp(/^[0-9]+$/g);
		return pattern.test(price);
	}
</script>
<div class="container" style="text-align: -webkit-center">
	<div class="content" style="width: 80%">
		<h1 style="margin : 30px">쿠폰 수정</h1>
		<br>
		<form action="couponEdit_ok.jsp" id="frmEdit" method="post" name="frmEdit"
			enctype="multipart/form-data">
			<div class="row justify-content-md-center">
			
				<!-- 쿠폰명 -->
				<div class="col-sm-12" style="width: 100%; margin-bottom:15px">
					<div class="form-floating mb-12">
						<input type="text" class="form-control" id="coupName" name="coupName"
							 value="<%=vo.getCoupName()%>"> <label
							for="floatingInput">쿠폰명</label>
					</div>
				</div>
				
				<!-- 가격 -->
				<div class="col-lg-4">
					<div class="input-group mb-4">
					  <span class="input-group-text">가격</span>
					  <span class="input-group-text">(원)</span>
					  <input type="text" class="form-control" aria-label="금액입력" id="coupPrice"
					  	name="coupPrice" value="<%=vo.getCoupPrice()%>">
					</div>
				</div>
				
				<!-- 카테고리 -->
				<div class="col-lg-4">
					<div class="input-group mb-4">
						<select class="form-select" name="ctgNo" id="ctgNo">
							<option value="">카테고리</option>
							<option value="1" <%if(vo.getCtgNo()==1){%>selected<%}%>>액티비티</option>
							<option value="2" <%if(vo.getCtgNo()==2){%>selected<%}%>>어트랙션</option>
							<option value="3" <%if(vo.getCtgNo()==3){%>selected<%}%>>티켓</option>
							<option value="4" <%if(vo.getCtgNo()==4){%>selected<%}%>>체험</option>
							<option value="5" <%if(vo.getCtgNo()==5){%>selected<%}%>>투어</option>
						</select>
					</div>
				</div>
				
				<!-- 지역 선택 -->
				<div class="col-lg-4">
					<div class="input-group mb-4">
						<select class="form-select" id="locNum" name="locNum">
							<option value="">지역</option>
							<option value="1"<%if(vo.getLocNum()==1){%>selected<%}%>>강원도</option>
							<option value="2"<%if(vo.getLocNum()==2){%>selected<%}%>>경기도</option>
							<option value="3"<%if(vo.getLocNum()==3){%>selected<%}%>>경상도</option>
							<option value="4"<%if(vo.getLocNum()==4){%>selected<%}%>>서울</option>
							<option value="5"<%if(vo.getLocNum()==5){%>selected<%}%>>전라도</option>
							<option value="6"<%if(vo.getLocNum()==6){%>selected<%}%>>충청도</option>
							<option value="7"<%if(vo.getLocNum()==7){%>selected<%}%>>제주도</option>
						</select>
					</div>
				</div>
			</div>

			<hr>
			
			<%--달력--%>
			<div class="col-md-12">
				<div id="calendar" style="margin-bottom: 50px">
					<div class="input-daterange input-group" data-provide="datepicker">
						<span class="input-group-text" id="basic-addon1">시작일</span>
						<input type="text" class="input-sm form-control" name="coupStartDate"
							placeholder="날짜 선택..." value="<%=sdf.format(vo.getCoupStartDate())%>" /> 
						<span class="input-group-text" id="basic-addon1">마감일</span> 
						<input type="text" class="input-sm form-control" name="coupEndDate"
							placeholder="날짜 선택..." value="<%=sdf.format(vo.getCoupEndDate())%>"/>
					</div>
				</div>
			</div>
			
			<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datepicker.ko.min.js"></script>
			<script type="text/javascript">
				$('#calendar .input-daterange').datepicker({
					format : "yyyy-mm-dd",
					startDate : '-1',
					language : "ko",
					autoclose : true,
					todayHighlight : true
				});
			</script>
			
			<!-- ckEditor -->
			<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
			<script type="text/javascript">
				CKEDITOR.config.width = '1000px';
				CKEDITOR.config.height = '400px';
			</script>
			<div class="justify-content-md-center">
				<div class="col_c" style="margin-bottom: 30px">
					<div class="input-group container">
						<textarea class="form-control" id="p_content" name="coupContent"><%=vo.getCoupContent()%></textarea>
						<script type="text/javascript">
							CKEDITOR.replace('p_content');
						</script>
					</div>
				</div>
			</div>

			<!-- 썸네일 선택 -->
			<div class="justify-content-md-center">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="inputGroupFileAddon01">썸네일</span>
					</div>
					<div class="custom-file">
						&nbsp;<input type="file" class="form-control form-control-sm"
							id="exampleFormControlFile1" name="coupFileName">
					</div>
				</div>
			</div>
			<div class="justify-content-md-center">
				<span class="input-group-text">현재 썸네일 : <%=vo.getCoupFileName()%></span>
			</div>
			<hr>
			
			<!-- 주소 -->
			<div class="row m-0">
				<div class="col-xxl-4 m-0">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">주소</span>
						</div>
						<input type="text" class="form-control" name="address" value="<%=vo.getAddress()%>">
					</div>
				</div>
				
				<!-- 위도 경도 -->
				<div class="col-xxl-6 m-0">
					<div class="input-group mb-3">
					  <span class="input-group-text">위도,경도 입력</span>
					  <input type="text" aria-label="위도" class="form-control" id="latitude" name="latitude" value="<%=vo.getLatitude()%>">
					  <input type="text" aria-label="경도" class="form-control" id="longitude" name="longitude" value="<%=vo.getLongitude()%>">
					</div>
				</div>
				
				<!-- 주소링크 버튼 -->			
				<div class="col-xxl-2">
					<button type="button" class="btn btn-outline-success" id="searchBt">위도경도 검색!</button>
				</div>
				<script type="text/javascript">
					$("#searchBt").click(function(){
						window.open("http://www.geocoding.co.kr/");
					});
				</script>	
			</div>
			
			<hr>
			<!-- 버튼 -->
			<div class="row m-0">
				<div class="d-grid gap-1 col-sm-4 mx-auto">
					<button type="submit" class="btn btn-outline-success"
						style="font-weight: bold">Edit</button>
				</div>
				<div class="d-grid gap-1 col-sm-4 mx-auto">
					<button type="button" class="btn btn-outline-danger"
						style="font-weight: bold" id="listGo">List</button>
				</div>
				<div id="map-canvas" style="height: 100px"></div> 
			</div>
			<input type="hidden" name="coupNo" value="<%=coupNo%>"/>
			<input type="hidden" name="oldFileName" value="<%=vo.getCoupFileName()%>"/>			
		</form>
	</div>
</div>
<%@ include file="../inc/bottom.jsp"%>