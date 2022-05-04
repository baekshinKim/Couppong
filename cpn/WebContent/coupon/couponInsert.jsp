<%@page import="com.cpn.common.util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<%
	int rigNo=0;
	if(session.getAttribute("rigNo")!=null){
		rigNo=(Integer)session.getAttribute("rigNo");
	}
	
	if(rigNo!=util.STAFF){%>
	<script type="text/javascript">
		alert("권한이 없습니다.");
		history.back();
	</script>
	
	<%}
%>
<script type="text/javascript">
	$(function() {
		$('#title').focus();

		$('form[name=frmInsert]').find('#list').click(function() {
			location.href = 'couponList.jsp';
		});

		$('form[name=frmInsert]').submit(function() {

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
		<h1 style="margin : 30px">쿠폰 입력</h1>
		<br>
		<form action="couponInsert_ok.jsp" id="frmInsert" method="post" name="frmInsert"
			enctype="multipart/form-data">
			<div class="row justify-content-md-center">
			
				<!-- 쿠폰명 -->
				<div class="col-sm-12" style="width: 100%; margin-bottom:15px">
					<div class="form-floating mb-12">
						<input type="text" class="form-control" id="coupName" name="coupName"
							placeholder="쿠폰명"> <label
							for="floatingInput">쿠폰명</label>
					</div>
				</div>
				
				<!-- 가격 -->
				<div class="col-lg-4">
					<div class="input-group mb-4">
					  <span class="input-group-text">가격</span>
					  <span class="input-group-text">(원)</span>
					  <input type="text" class="form-control" aria-label="금액입력" id="coupPrice"
					  	name="coupPrice">
					</div>
				</div>
				
				<!-- 카테고리 -->
				<div class="col-lg-4">
					<div class="input-group mb-4">
						<select class="form-select" name="ctgNo" id="ctgNo">
							<option value="" selected>카테고리</option>
							<option value="1">액티비티</option>
							<option value="2">어트랙션</option>
							<option value="3">티켓</option>
							<option value="4">체험</option>
							<option value="5">투어</option>
						</select>
					</div>
				</div>
				
				<!-- 지역 선택 -->
				<div class="col-lg-4">
					<div class="input-group mb-4">
						<select class="form-select" id="locNum" name="locNum">
							<option value="" selected>지역</option>
							<option value="1">강원도</option>
							<option value="2">경기도</option>
							<option value="3">경상도</option>
							<option value="4">서울</option>
							<option value="5">전라도</option>
							<option value="6">충청도</option>
							<option value="7">제주도</option>
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
							placeholder="날짜 선택..." /> 
						<span class="input-group-text" id="basic-addon1">마감일</span> 
						<input type="text" class="input-sm form-control" name="coupEndDate"
							placeholder="날짜 선택..." />
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
						<textarea class="form-control" id="p_content" name="coupContent"></textarea>
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
			<hr>
			
			<!-- 주소 -->
			<div class="row m-0">
				<div class="col-xxl-4 m-0">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">주소</span>
						</div>
						<input type="text" class="form-control" name="address">
					</div>
				</div>
				
				<!-- 위도 경도 -->
				<div class="col-xxl-6 m-0">
					<div class="input-group mb-3">
					  <span class="input-group-text">위도,경도 입력</span>
					  <input type="text" aria-label="위도" class="form-control" id="latitude" name="latitude" placeholder="위도">
					  <input type="text" aria-label="경도" class="form-control" id="longitude" name="longitude" placeholder="경도">
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
					<button type="submit" class="btn btn-outline-primary"
						style="font-weight: bold">Submit</button>
				</div>
				<div class="d-grid gap-1 col-sm-4 mx-auto">
					<button type="button" class="btn btn-outline-danger"
						style="font-weight: bold" id="list">List</button>
				</div>
				<div id="map-canvas" style="height: 100px"></div> 
			</div>
		</form>
	</div>
</div>
<%@ include file="../inc/bottom.jsp"%>