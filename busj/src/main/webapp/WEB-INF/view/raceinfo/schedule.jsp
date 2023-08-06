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
	<form name="frmScheduleInfo" method="post" class="probootstrap-form">
		<div class="form-group">
			<div class="col-md">
				<div class="form-check custom">
					<input class="form-check-input" type="radio" name="busType" id="highBus" value="고속" checked>
						<label class="form-check-label" for="highBus">고속</label>
				</div>
				<div class="form-check custom">
					<input class="form-check-input" type="radio" name="busType" id="slowBus" value="시외">
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
						<input type="text" id="risday" class="form-control" value="" readonly>
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
					<input type="button" id="schBtn" value="조회하기" class="btn btn-primary btn-block">	<!-- ID부여 -->
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
	<div class="row">
    	<div class="col-md-12 text-center mb-5" style="display: none;" id="timetable-container">
        	<div id="timetable">
        	</div>
    	</div>
	</div>	 
</div>
<div class="modal fade" id="ViewModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
<!-- 페이지네이션 영역 -->
<!-- 
<nav aria-label="Page navigation example" class="mt-4">
	<ul class="pagination justify-content-center">
		<li class="page-item">
			<a class="page-link" href="#" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
			</a>
		</li>
		<li class="page-item"><a class="page-link" href="#">1</a></li>
		<li class="page-item"><a class="page-link" href="#">2</a></li>
		<li class="page-item"><a class="page-link" href="#">3</a></li>
		<li class="page-item">
			<a class="page-link" href="#" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
		</li>
	</ul>
</nav>
 -->
<!-- 페이지네이션 영역 끝 -->
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

function number_format(num){
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
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
	
	$("#risday").val(getToday());

	$("#risday").datepicker({	// 편도 가는 날
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
        $("#risday").val($(this).val());
      });

	$("#schBtn").click(function() {
	    if ($("#sPoint").val() == "" || $("#ePoint").val() == "") {
	        alert("출발지와 도착지를 선택해주세요.");
	        return false;
	    }

	    const sPoint = $("#sPoint").val();
	    const ePoint = $("#ePoint").val();
	    const busType = $("input[name=busType]:checked").val();
	    const risday = $("#risday").val();

	    $.ajax({
	        type: "POST", 
	        url: "./getSchedule",
	        data: { sPoint: sPoint, ePoint: ePoint, busType: busType, risday: risday },
	        dataType: "json",
	        success: function(data) {

	            if (data.length > 0) {
	                let tableHTML = "<table class='table table-hover'>" + 
	               					"<colgroup><col width='10%'><col width='10%'><col width='15%'><col width='15%'>" +
									"<col width='15%'><col width='15%'><col width='10%'><col width='10%'></colgroup>" + 
		            				"<thead class='bg-primary'><tr>" + 
		            				"<th scope='col' class='text-center'>출발시간</th><th scope='col' class='text-center'>고속사</th>" + 
		            				"<th scope='col' class='text-center'>등급</th><th scope='col' class='text-center'>성인요금</th>" + 
		            				"<th scope='col' class='text-center'>청소년요금</th><th scope='col' class='text-center'>아동요금</th>" + 
		            				"<th scope='col' class='text-center'>전체좌석</th><th scope='col' class='text-center'>잔여좌석</th></tr></thead><tbody>";
	                data.forEach(function(table) {
	                    tableHTML += "<tr>";
	                    tableHTML += "<td>" + table.bs_stime + "</td>";
	                    tableHTML += "<td>" + table.bc_name + "</td>";
	                    tableHTML += "<td>" + table.bi_level + "</td>";
	                    tableHTML += "<td>" + number_format(table.bl_adult); + "</td>";
	                    tableHTML += "<td>" + number_format((table.bl_adult * 0.8)); + "</td>";
	                    tableHTML += "<td>" + number_format((table.bl_adult * 0.5)); + "</td>";
	                    tableHTML += "<td>" + table.total_seat + "</td>";
	                    tableHTML += "<td>" + table.left_seat + "</td>";
	                    tableHTML += "</tr>";
	                });
	                tableHTML += "</tbody></table>";

	                // 테이블을 보여줌
	                $("#timetable").html(tableHTML);
	                $("#timetable-container").show();
	            } else {
	                // 데이터가 없는 경우
	                alert("조회된 시간표가 없습니다.");
	                $("#timetable").empty();
	                $("#timetable-container").hide();
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX Error:", error);
	            // 오류 처리 로직을 추가할 수도 있음
	        }
	    });
	});
});
</script>