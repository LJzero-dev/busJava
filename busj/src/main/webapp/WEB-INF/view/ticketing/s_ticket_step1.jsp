<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<%@ page import="java.time.*" %>

<section class="probootstrap_section">
<div class="container">
	<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
		<div class="col-md-12">
		<h2 class="border-bottom probootstrap-section-heading">시외버스 예매</h2>
		</div>
		<div class="col-md-12">
			<div class="col-md-8 m-auto">
			<div class="progress-bar-custom 1">
               	<div class="progress-step  is-active">
                 	<div class="step-count"></div>
                 	<div class="step-description">정보 입력</div>
               	</div>
				<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">배차 조회</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">좌석 선택</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">확인/결제</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">예매 결과</div>
               	</div>
			</div>
           	</div>
             
			<div class="col-md-12 m-auto">
			<div class="progress-bar-custom 2">
				<div class="progress-step is-active">
                 	<div class="step-count"></div>
                 	<div class="step-description">정보 입력</div>
               	</div>
               	<div class="progress-step">
                 	<div class="step-count"></div>
                 	<div class="step-description">가는 날 배차 조회</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">가는 날 좌석 선택</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">오는 날 배차 조회</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">오는 날 좌석 선택</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">확인/결제</div>
               	</div>
               	<div class="progress-step">
                  	<div class="step-count"></div>
                  	<div class="step-description">예매 결과</div>
               	</div>
			</div>
           	</div>
		</div>
	</div>
	
	<div class="col-md-8 probootstrap-animate fadeInUp probootstrap-animated m-auto">
	<form name="frmLineInfo" action="sTicketingStep02"  method="post" class="probootstrap-form">
	<input type="hidden" name="mode" id="mode" value="p" />	<!-- 편도: p / 왕복: w -->
	<input type="hidden" name="ri_sday1" id="ri_sday1" value="" />	<!-- 편도 가는 날 왕복 가는 날-->
	<input type="hidden" name="ri_sday2" id="ri_sday2" value="" />	<!-- 편도 가는 날 왕복 가는 날 -->
	<input type="hidden" name="ri_sday3" id="ri_sday3" value="" />	<!-- 왕복 오는 날 -->
		<div class="form-group">
		<ul class="nav nav-pills nav-justified mb-3" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link w-100 active" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" 
				type="button" role="tab" aria-controls="pills-home" aria-selected="true" aria-expanded="false">편도</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link w-100" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" 
				type="button" role="tab" aria-controls="pills-profile" aria-selected="false" aria-expanded="true">왕복</button>
			</li>
		</ul>
			<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" aria-expanded="false">
				<div class="row mb-3">
				<div class="col-md">
					<div class="form-group">
					<label for="sday1">가는날</label>
					<div class="probootstrap-date-wrap">
						<span class="icon ion-calendar"></span> 
						<input type="text" id="sday1" class="form-control" value="" readonly>
					</div>
					</div>
				</div>
				</div>
			</div>
			<div class="tab-pane" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" aria-expanded="true">
				<div class="row mb-3">
				<div class="col-md">
					<div class="form-group">
					<label for="sday2">가는날</label>
					<div class="probootstrap-date-wrap">
						<span class="icon ion-calendar"></span> 
						<input type="text" id="sday2" class="form-control" value="" readonly>
					</div>
					</div>
				</div>
				<div class="col-md">
					<div class="form-group">
					<label for="sday3">오는날</label>
					<div class="probootstrap-date-wrap">
						<span class="icon ion-calendar"></span> 
						<input type="text" id="sday3" name="sday3" class="form-control" value="" readonly>
					</div>
					</div>
				</div>
				</div>
			</div>
			</div>

				<div class="row mb-3">
				<div class="col-md">
					<div class="form-group">
					<label for="btsname">출발지</label>
					<input type="text" class="form-control" id="btsname" name="btsname" data-toggle="modal" data-target="#ViewModal" role="button" readonly onclick="openModal();">
					</div>
				</div>
				<div class="col-md">
					<div class="form-group">
					<label for="btename">도착지</label>
					<input type="text" class="form-control" id="btename" name="btename" readonly>
					</div>
				</div>
				</div>
             
				<div class="row mb-3">
				<div class="col-md">
					<input type="submit" id="schBtn" value="조회하기" class="btn btn-primary btn-block">	<!-- ID부여 -->
				</div>
				</div>
		</div>
	</form>
	</div>  
</div>
<div class="modal fade" id="ViewModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
</section>
<!-- END section -->

<%@ include file="../_inc/foot.jsp" %>
<script>

function openModal() {
	$('#ViewModal .modal-content').load("/busj/pickSpotSlow");	// 시외버스 출/도착지 선택 팝업
	$('#ViewModal').modal()
}

function getToday(){
	const DATE = new Date();
    const YEAR = DATE.getFullYear();
    const MONTH = ("0" + (1 + DATE.getMonth())).slice(-2);
    const DAY = ("0" + DATE.getDate()).slice(-2);

    return YEAR + "." + MONTH + "." + DAY;
}

$(document).ready(function() {
	$("#ri_sday1").val(getToday());
	$("#ri_sday2").val(getToday());
	
	$(".progress-bar-custom.2").hide();
	$(".nav-item").click(function() {
		let navLink = $(this).find(".nav-link");
		let tabIndex = $(this).index();
      
		// active 상태에서 클릭시 아무런 변화없음
		if (navLink.hasClass("active"))	return;

		navLink.toggleClass("show");
		let progressBarCustom = $(".progress-bar-custom." + (tabIndex + 1));
		if (navLink.hasClass("show")) {
			if (tabIndex === 0) {	// 편도 클릭 시
				$("#mode").val("p");
				$(".progress-bar-custom.1").css("display","");
				$(".progress-bar-custom.2").css("display","none");
			} else if (tabIndex === 1) {	 // 왕복 클릭 시
				$("#mode").val("w");
				$(".progress-bar-custom.1").css("display","none");
				$(".progress-bar-custom.2").css("display","");
			}
		} 

		$(".nav-item").not(this).find(".nav-link").removeClass("show");
	});
    
    $("#sday1").datepicker({	// 편도 가는 날
      format: "yyyy.mm.dd"
      , autoclose: true
      , startDate: "0d"	// 오늘 이후의 날짜만 선택할 수 있도록 시작 날짜를 오늘로 설정
      , endDate: "+30d"	// 30일 이후의 날짜는 선택하지 못하도록 설정
      , language: "kr"
      , showMonthAfterYear: true	// 월, 년순의 셀렉트 박스를 년,월 순으로 변경
      , weekStart: 1				// 주의 시작 요일을 월요일로 설정
      , })
      .datepicker("setDate",'now')		// 날짜 선택기를 현재 날짜로 설정
      .on('changeDate', function(e) {	
        $("#ri_sday1").val($(this).val());	// 왕복 가는 날, 오는 날 값 설정
        $("#sday2").val($(this).val());
      });

      $("#sday2").datepicker({	// 왕복 가는 날
      format: "yyyy.mm.dd"
      , autoclose: true
      , startDate: "0d"
      , endDate: "+30d"
      , language: "kr"
      , showMonthAfterYear: true
      , weekStart: 1
      , })
      .datepicker("setDate",'now')
      .on('changeDate', function(e) {
//        $("#ri_sday2").val($( "#sday2" ).datepicker("getDate"));	// 왕복 가는 날 날짜 설정
        $("#ri_sday1").val($(this).val());
        $("#sday1").val($(this).val());
        $("#ri_sday2").val($(this).val());
        $("#sday3").datepicker("setStartDate", new Date($( "#sday2" ).datepicker("getDate")));	// 왕복 오는 날의 시작값을 왕복 가는 날 값으로 설정
      });

    $("#sday3").datepicker({	// 왕복 오는 날
      format: "yyyy.mm.dd"
      , autoclose: true
      , startDate: "0d"
      , endDate: "+30d"
      , language: "kr"
      , showMonthAfterYear: true
      , weekStart: 1
      , })
      .datepicker("setDate",'now')
      .on('changeDate', function(e) {
//        $("#ri_sday1").val($( "#sday1" ).datepicker("getDate"));	// 편도 가는 날 날짜 설정
/* 		$("#ri_sday1").val($(this).val()); */
        $("#sday2").datepicker("setEndDate", new Date($("#sday3").datepicker("getDate")));	// 왕복 가는 날의 종료값을 왕복 오는 날 값으로 설정
        $("#ri_sday3").val($(this).val());
      });

	$("#schBtn").click(function() {
		if ($("#btsname").val() == "" || $("#btename").val() == "") {
			alert("출발지와 도착지를 선택해주세요.");
			return false;
		}
		
		if ($("#mode").val() == 'w' ) {	// 왕복인경우
			if (!($("#ri_sday1").val() == "") || !($("#sday3").val() == "")) {	// 편도 가는날이 비어있지 않고 왕복 오는날이 비어있지 않으면
				// 통과 로직
			} else {
				alert("오는날을 선택해주세요.");
				return false;
			}
		}
	
		document.frmLineInfo.submit();
	}); 
	
});
</script>