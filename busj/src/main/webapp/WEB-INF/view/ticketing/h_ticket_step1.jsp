<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>

<section class="probootstrap_section">
  <div class="container">
    <div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
      <div class="col-md-12">
        <h2 class="border-bottom probootstrap-section-heading">고속버스 예매</h2>
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
      <form name="frmLineInfo" action="hTicketingStep02" method="POST" class="probootstrap-form">
        <input type="hidden" name="mode" id="mode" value="p" />
        <input type="hidden" name="sDate1-1" id="sDate1-1" value="" />
        <input type="hidden" name="sDate2-1" id="sDate2-1" value="" />
        <input type="hidden" name="eDate1-1" id="eDate1-1" value="" />
        <input type="hidden" name="lineNum" id="lineNum" value="" />
        <div class="form-group">
          <ul class="nav nav-pills nav-justified mb-3" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
              <button class="nav-link w-100 active" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true" aria-expanded="false">편도</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link w-100" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false" aria-expanded="true">왕복</button>
            </li>
          </ul>

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
<div class="modal fade" id="ViewModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
</section>

<%@ include file="../_inc/foot.jsp" %>
<script>

function openModal() {
	$('#ViewModal .modal-content').load("/busj/pickSpotHigh");
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


    
