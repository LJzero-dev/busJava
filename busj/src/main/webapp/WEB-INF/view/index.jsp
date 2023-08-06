<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/head.jsp" %>
<!--  <script>
    function openModal() {
      $('#exampleModal .modal-content').load("ex_pop.html");
      $('#exampleModal').modal('show');
    }

</script> -->
    
<section class="probootstrap-cover overflow-hidden relative"  style="background-image: url('assets/images/bg_1.jpg');" data-stellar-background-ratio="0.5"  id="section-home">
<div class="overlay"></div>
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-md-8 probootstrap-animate">
			<form id="frmLineInfo" name="frmLineInfo" action="" method="POST" class="probootstrap-form">
				<input type="hidden" name="mode" id="mode" value="p" />
				<input type="hidden" name="sDate1-1" id="sDate1-1" value="" />
				<input type="hidden" name="sDate2-1" id="sDate2-1" value="" />
				<input type="hidden" name="eDate1-1" id="eDate1-1" value="" />
				<input type="hidden" name="sLineNum" id="sLineNum" value="" />
				<input type="hidden" name="eLineNum" id="eLineNum" value="" />
				
		<div class="form-group">
			<ul class="nav nav-pills nav-justified mb-3" id="pills-tab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active w-100" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">편도</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link w-100" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">왕복</button>
				</li>
			</ul>
		<div class="tab-content" id="pills-tabContent">
			<div class="row">
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
			</div>
			<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" aria-expanded="false">
              <div class="row mb-3">
                <div class="col-md">
                  <div class="form-group">
                    <label for="sDate1-2">가는날</label>
                    <div class="probootstrap-date-wrap">
                      <span class="icon ion-calendar"></span> 
                      <input type="text" id="sDate1-2" class="form-control" value="" readonly>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" aria-expanded="true">
              <div class="row mb-3">
                <div class="col-md">
                  <div class="form-group">
                    <label for="sDate2-2">가는날</label>
                    <div class="probootstrap-date-wrap">
                      <span class="icon ion-calendar"></span> 
                      <input type="text" id="sDate2-2" class="form-control" placeholder="" readonly>
                    </div>
                  </div>
                </div>
                <div class="col-md">
                  <div class="form-group">
                    <label for="eDate1-2">오는날</label>
                    <div class="probootstrap-date-wrap">
                      <span class="icon ion-calendar"></span> 
                      <input type="text" id="eDate1-2" class="form-control" placeholder="" readonly>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
		
		
		</div>
			<div class="row mb-3">
			<div class="col-md">
				<div class="form-group">
					<label for="sPoint">출발지</label>
						<input type="text" class="form-control" id="sPoint" name="sPoint" readonly data-toggle="modal" data-target="#ViewModal" role="button" onclick="openModal();">
				</div>
			</div>
			<div class="col-md">
				<div class="form-group">
					<label for="ePoint">도착지</label>
						<input type="text" class="form-control" id="ePoint" name="ePoint"  readonly>
				</div>
			</div>
			</div>
			<div class="row mb-3">
			<div class="col-md">
				<input type="button" id="schBtn" value="조회하기" class="btn btn-primary btn-block">
			</div>
			</div>
		</div>
			</form>	
			</div>  
		</div>
  <!-- Modal -->
<div class="modal fade" id="ViewModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
</section>


  <%@ include file="_inc/foot.jsp" %>
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
	
	$("#sDate1-1").val(getToday());
	$("#sDate2-1").val(getToday());
	
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
    
    $('input[type="radio"][name="busType"]').on('change', function() {
        let selectedValue = $(this).val();
        let newAction = ""; // 변경할 액션 URL을 담을 변수

        // 선택한 버튼의 값에 따라 액션 URL 설정
        if (selectedValue === "고속") {
          newAction = "hTicketingStep02"; // 고속 노선을 선택한 경우의 액션 URL
        } else if (selectedValue === "시외") {
          newAction = "sTicketingStep02"; // 시외 노선을 선택한 경우의 액션 URL
        }

        // form action 변경
        $("#frmLineInfo").attr("action", "");
      });
   
	$("#sDate1-2").datepicker({
		format: "yyyy.mm.dd",
		autoclose: true,
		startDate: "0d",
		
		endDate: "+30d",
		language: "kr",
		showMonthAfterYear: true,
		weekStart: 1,
		}).datepicker("setDate",'now')
		.on('changeDate', function(e) {
		$("#sDate1-1").val($(this).val());
		$("#sDate2-2").val($(this).val());

	});

	$("#sDate2-2").datepicker({
		format: "yyyy.mm.dd",
		autoclose: true,
		startDate: "0d",
		endDate: "+30d",
		language: "kr",
		showMonthAfterYear: true,
		weekStart: 1,
	}).datepicker("setDate",'now')
		.on('changeDate', function(e) {
		$("#sDate1-1").val($(this).val());
		$("#sDate1-2").val($(this).val());
		$("#sDate2-1").val($(this).val());
		$("#eDate1-2").datepicker("setStartDate", new Date($( "#sDate2-2" ).datepicker("getDate")));
     	// 오는날 필드에서 가는날 필드의 이전날짜 선택을 막음
	});

	$("#eDate1-2").datepicker({
    	format: "yyyy.mm.dd",
		autoclose: true,
		startDate: "0d",
		endDate: "+30d",
		language: "kr",
		showMonthAfterYear: true,
		weekStart: 1,
	}).on('changeDate', function(e) {
        $("#eDate1-1").val($(this).val());
        $("#sDate2-2").datepicker("setEndDate", new Date($("#eDate1-2").datepicker("getDate")));
     	// 가는날 필드에서 오는날 필드의 이후날짜 선택을 막음
	});

	$("#schBtn").click(function() {
		if ($("#mode").val() == 'w' ) {	// 왕복인경우
			if (!($("#eDate1-1").val() == "") || !($("#eDate1-2").val() == "")) {
				// 통과 로직
			} else {
				alert("오는날을 선택해주세요.");
				return false;
			}
		}
		
		if ($("#sPoint").val() == "" || $("#ePoint").val() == "") {
			alert("출발지와 도착지를 선택해주세요.");
			return false;
		}
		
		document.frmLineInfo.submit();
	});
});
</script>
