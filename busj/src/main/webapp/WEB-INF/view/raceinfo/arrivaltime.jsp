<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<%
request.setCharacterEncoding("utf-8");
List<TerminalInfo> terminalList = (List<TerminalInfo>)request.getAttribute("terminalList");
List<BusCompanyInfo> busCompany = (List<BusCompanyInfo>)request.getAttribute("busCompany");
LocalTime now = LocalTime.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
String time = now.format(formatter);
%>
<section class="probootstrap_section">
<div class="container">
	<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
		<div class="col-md-12">
		<h2 class="border-bottom probootstrap-section-heading">도착시간 안내</h2>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 probootstrap-animate fadeInUp probootstrap-animated m-auto">
		<form name="frmArrivaltime" action=""  method="post" class="probootstrap-form">
			<div class="d-flex">
				<div class="form-group col-md-3">
					<label for="departureArea">출발 지역</label>
					<select id="departureArea" class="form-control">
						<option selected>지역 선택</option>
				        <option value="서울">서울</option>
				        <option value="경기">경기도</option>
				        <option value="강원">강원도</option>
				        <option value="경상">경상도</option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label for="departureTerminal">출발 터미널</label>
					<select id="departureTerminal" name="departureTerminal" class="form-control">
						<option selected>터미널 선택</option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label for="arrivalTerminal" name="arrivalTerminal">도착 터미널</label>
					<select id="arrivalTerminal" class="form-control">
						<option selected>터미널 선택</option>
						<option></option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label for="busCompany">고속사</label>
					<select id="busCompany" class="form-control">
						<option selected>전체</option>
<%for(BusCompanyInfo bc : busCompany) {%>
						<option value="<%=bc.getBc_name() %>"><%=bc.getBc_name() %></option>
<%} %>						
					</select>
				</div>
			</div>
			<div class="btn-wrap">
				<input type="button" id="schBtn" value="조회하기" class="btn btn-primary">	<!-- ID부여 -->
			</div> 
		</form>        
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 text-center mb-5" style="display: none;" id="timetable-container">
			<div id="timetable">
			</div>
		</div>
	<div class="row mb-3">
		<ul>
			<li>도착예정 시간은 차량의 실제 도착시간과 다소 차이가 발생할 수 있습니다.</li>
			<li>도착예정 2시간 이전 혹은 도착완료 30분 이내 차량에 한하여 서비스가 지원됩니다.</li>
			<li>고속버스 시간표 조회를 위해서는 시간표 조회 메뉴를 이용하시기 바랍니다.</li>
		</ul>
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
$(document).ready(function() {
    // 출발 지역 선택 셀렉트 박스에 onchange 이벤트 핸들러 추가
	$("#departureArea").change(function() {
        // 선택된 출발 지역 값을 가져옴
        const selectedArea = $(this).val();
        $.ajax({
            type: "POST",
            url: "./getDepartureTerminal",
            data: { selectedArea : selectedArea },
            dataType: "json",
            success: function(data) {
            	if (data.length > 0 ) {
					$("#departureTerminal").children('option:not(:first)').remove();
					data.forEach(function(terminal) {
						$("#departureTerminal").append("<option value='" + terminal.bt_name + "'>" + terminal.bt_name + "</option>");
            		});
            	} else {
					alert("조회된 시간표가 없습니다.");
            	}
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", error);
                // 오류 처리 로직을 추가할 수도 있음
            }
        });
    });
    
	// 출발 터미널 선택 셀렉트 박스에 onchange 이벤트 핸들러 추가
	$("#departureTerminal").change(function() {
        // 선택된 출발 터미널 값을 가져옴
        const selectedTerminal = $(this).val();
        if (selectedTerminal == "터미널 선택") return;
        
        $.ajax({
            type: "POST",
            url: "./getArrivalTerminal",
            data: { selectedTerminal : selectedTerminal },
            dataType: "json",
            success: function(data) {
            	if (data.length > 0 ) {
					$("#arrivalTerminal").children('option:not(:first)').remove();
					data.forEach(function(line) {
						$("#arrivalTerminal").append("<option value='" + line.bl_idx + "'>" + line.ename + "</option>");
            		});
            	} else {
					alert("조회된 시간표가 없습니다.");
            	}
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", error);
                // 오류 처리 로직을 추가할 수도 있음
            }
        });
    });
	
	$("#schBtn").click(function() {
	    if ($("#departureArea").val() == "지역 선택" || $("#departureTerminal").val() == "터미널 선택" || $("#arrivalTerminal").val() == "터미널 선택") {
	        alert("터미널을 선택해주세요.");
	        return false;
	    }

	    const arrivalTerminal = $("#arrivalTerminal").val();	// 노선 인덱스 (bl_idx)
	    const busCompany = $("#busCompany").val();				// 버스회사 인덱스 (bc_idx)
	    const time = "<%=time %>";								// 현재시간 (hh:mm)

	    $.ajax({
	        type: "POST", 
	        url: "./getArrivalTime",
	        data: { arrivalTerminal: arrivalTerminal, busCompany: busCompany, time: time },
	        dataType: "json",
	        success: function(data) {

	            if (data.length > 0) {
	                let tableHTML = "<table class='table table-hover'>" + 
	               					"<colgroup><col width='15%'><col width='10%'><col width='15%'><col width='15%'>" +
									"<col width='15%'><col width='15%'><col width='15%'></colgroup>" + 
		            				"<thead class='bg-primary'><tr>" + 
		            				"<th scope='col' class='text-center'>출발시간</th><th scope='col' class='text-center'>고속사</th>" + 
		            				"<th scope='col' class='text-center'>등급</th><th scope='col' class='text-center'>차량번호</th>" + 
		            				"<th scope='col' class='text-center'>도착예정시간</th><th scope='col' class='text-center'>남은시간</th>" + 
		            				"<th scope='col' class='text-center'>상태</th></tr></thead><tbody>";
	                data.forEach(function(table) {
	                    tableHTML += "<tr>";
	                    tableHTML += "<td>" + table.bs_stime + "</td>";
	                    tableHTML += "<td>" + table.bc_company + "고속</td>";
	                    tableHTML += "<td>" + table.bi_level + "</td>";
	                    tableHTML += "<td>" + table.bi_num + "</td>";
	                    tableHTML += "<td>" + table.bs_etime + "</td>";
	                    tableHTML += "<td>" + table.leftTime + "</td>";
	                    tableHTML += "<td>" + table.status + "</td>";
	                    tableHTML += "</tr>";
	                });
	                tableHTML += "</tbody></table>";

	                // 테이블을 보여줌
	                $("#timetable").html(tableHTML);
	                $("#timetable-container").show();
	            } else {
	                // 데이터가 없는 경우
	                alert("조회 결과가 없습니다.");
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