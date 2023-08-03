<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<%@ page import="java.time.*" %>

<section class="probootstrap_section">
<div class="container">
	<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
		<div class="col-md-12">
		<h2 class="border-bottom probootstrap-section-heading">시간표 조회</h2>
		</div>
	</div>
	
	<div class="col-md-8 probootstrap-animate fadeInUp probootstrap-animated m-auto">
	<form name="frmScheduleInfo" action="sTicketingStep02"  method="post" class="probootstrap-form">
		<div class="form-group">
			<div class="col-md">
				<div class="form-check custom">
					<input class="form-check-input" type="radio" name="busType" id="highBus" value="option1" checked>
						<label class="form-check-label" for="highBus">고속</label>
				</div>
				<div class="form-check custom">
					<input class="form-check-input" type="radio" name="busType" id="slowBus" value="option2">
						<label class="form-check-label" for="slowBus">시외</label>
				</div>
			</div>
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
			</div>

				<div class="row mb-3">
				<div class="col-md">
					<div class="form-group">
					<label for="btsname">출발지</label>
					<input type="text" class="form-control" id="sPoint" name="sPoint" data-toggle="modal" 
					data-target="#ViewModal" role="button" readonly onclick="openModal();">
					</div>
				</div>
				<div class="col-md">
					<div class="form-group">
					<label for="btename">도착지</label>
					<input type="text" class="form-control" id="ePoint" name="ePoint" readonly>
					</div>
				</div>
				</div>
             
				<div class="row mb-3">
				<div class="col-md">
					<input type="submit" id="schBtn" value="조회하기" class="btn btn-primary btn-block">	<!-- ID부여 -->
				</div>
				</div>
				<div class="row mb-3">
					<ul>
						<li>실시간 운행상태 조회를 위해서는 <span style="text-decoration : underline;">도착시간 안내 메뉴</span>를 이용하시기 바랍니다.</li>
					</ul>
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
function openModal(url) {
	$('#ViewModal .modal-content').load(url);
	$('#ViewModal').modal();
}

function clearStartAndEndLocations() {
	$("#sPoint").val(""); // 출발지 입력란 초기화
	$("#ePoint").val(""); // 도착지 입력란 초기화
}

function getToday(){
	const DATE = new Date();
    const YEAR = DATE.getFullYear();
    const MONTH = ("0" + (1 + DATE.getMonth())).slice(-2);
    const DAY = ("0" + DATE.getDate()).slice(-2);

    return YEAR + "." + MONTH + "." + DAY;
}

$(document).ready(function() {
	// 모달을 열 때 버튼 클릭 이벤트에 따라 다른 URL을 전달
	$("#sPoint").click(function() {
	    const isHighBusSelected = document.getElementById("highBus").checked;
	    const url = isHighBusSelected ? "/busj/pickSpotHigh" : "/busj/pickSpotSlow";
	    openModal(url);
	});
	
	// 라디오 버튼이 변경될 때 clearStartAndEndLocations 함수 호출
    $("#highBus, #slowBus").change(function() {
        clearStartAndEndLocations(); // 함수 호출하여 출발지와 도착지 초기화
    });
	
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
        $("#sday2").datepicker("setEndDate", new Date($("#sday3").datepicker("getDate")));	// 왕복 가는 날의 종료값을 왕복 오는 날 값으로 설정
        $("#ri_sday3").val($(this).val());
      });

	$("#schBtn").click(function() {
		if ($("#sPoint").val() == "" || $("#ePoint").val() == "") {
			alert("출발지와 도착지를 선택해주세요.");
			return false;
		}
		
		const sPoint = $("#sPoint").val();
		const ePoint = $("#ePoint").val();
		// 체크 선택여부를 통해 고속인지 시외인지 구분
		const isHighBusSelected = $("#highBus").prop("checked");
		const isSlowBusSelected = $("#slowBus").prop("checked");
		
		$.ajax({
			url: url,
			type: "POST",
            data: { startLocation: startLocation, endLocation: endLocation },
            dataType: "json",
            success: function(response) {
                // 서버로부터 받은 데이터를 이용하여 테이블 생성
                const timetableData = response.timetable;

                let tableHTML = "<table><thead><tr><th>출발시간</th><th>도착시간</th><th>버스 타입</th></tr></thead><tbody>";
                timetableData.forEach(function(data) {
                    tableHTML += `<tr><td>${data.departureTime}</td><td>${data.arrivalTime}</td><td>${data.busType}</td></tr>`;
                });
                tableHTML += "</tbody></table>";

                // 생성한 테이블을 timetable 요소에 추가하여 보여줌
                $("#timetable").html(tableHTML);
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", error);
                // 오류 처리 로직을 추가할 수도 있음
            }
        });
	}); 
});
</script>