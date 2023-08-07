<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
List<ReservationStep2> scheduleList = (List<ReservationStep2>)request.getAttribute("scheduleList");
ReservationInfo ri2 = (ReservationInfo) session.getAttribute("ri2");

int bsidx = 0;
String etime = "";
%>
<style>
tr:hover {
/* 행에 마우스를 올렸을 때 커서 모양 변경 */
    cursor: pointer;
  }
</style>
<section class="probootstrap_section">
<div class="container">
	<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated mb-0">
		<div class="col-md-12">
		<h2 class="border-bottom mb-5 probootstrap-section-heading">시외버스 예매</h2></div>
		<div class="col-md-12">
			<div class="col-md-12 m-auto">
			<div class="progress-bar-custom 2">
				<div class="progress-step">
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
				<div class="progress-step is-active">
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
	<div class="row">
		<div class="col-md-12 text-center mb-5">
		<h5 class="text-left">오는편</h5>
		<table class="table">
			<colgroup>
				<col width="5%">
				<col width="15%">
				<col width="5%">
				<col width="15%">
				<col width="*">
			</colgroup>
			<tbody>
			<tr class="border-b">
				<td class="align-middle"><span class="badge badge-danger">출발지</span></td>
				<td class="align-middle"><%=ri2.getSspot() %></td>
				<td class="align-middle"><span class="badge badge-primary">도착지</span></td>
				<td class="align-middle"><%=ri2.getEspot() %></td>
				<td class="align-middle">탑승일</td>
				<td class="text-left"><%=ri2.getSdate() %>
					<%-- <div class="w-50">
					<div class="probootstrap-date-wrap">
						<span class="icon ion-calendar"></span> 
							<input type="text" id="sday3" class="form-control" value="<%=ri2.getSdate() %>" readonly >
							<input type="hidden" id="ri_sday3" name="ri_sday3" value="" />
					</div>
					</div> --%>
				</td>	
			</tr>
			</tbody>
		</table>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
		<table class="table table-hover">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead class="bg-primary">
			<tr style="cursor: default">
				<th scope="col" class="text-center">출발시각</th>
				<th scope="col" class="text-center">고속사</th>
				<th scope="col" class="text-center">등급</th>
				<th scope="col" class="text-center">금액</th>
				<th scope="col" class="text-center">전체좌석</th>
				<th scope="col" class="text-center">잔여좌석</th>
			</tr>
			</thead>
			<tbody class="text-center">
<%if (scheduleList.size() > 0) {	// 해당 노선의 시간표가 있는 경우
	for (ReservationStep2 sl : scheduleList) {
		bsidx = sl.getBs_idx();		etime = sl.getBs_etime();
		
		int adultPrice = sl.getBl_adult();
		if (sl.getBi_level().equals("일반"))	adultPrice = sl.getBl_adult();
		else	adultPrice = (int)(sl.getBl_adult() * 1.5);
		
		String data = "data";	String leftseat = sl.getLeft_seat() + "";
		if (sl.getLeft_seat() == 0)	{
			data = "sold-out";
			leftseat = "매진";
		}
%>
			<tr class="<%=data %>" onclick="rowClicked('<%=sl.getBs_idx() %>', '<%=sl.getBs_etime() %>', '<%=sl.getBs_stime() %>', '<%=sl.getBc_name() %>', 
			'<%=sl.getBi_level() %>', '<%=sl.getBl_adult() %>', '<%=sl.getTotal_seat() %>', '<%=sl.getLeft_seat() %>');">
				<td><%=sl.getBs_stime() %></td>		
				<td><%=sl.getBc_name() %></td>		
				<td><%=sl.getBi_level() %></td>				
				<td><%= String.format("%,d", adultPrice) %></td>		
				<td><%=sl.getTotal_seat()%></td>	<!-- 전체좌석 int seat		if(bi_level.equals("우등")) seat = 28 else seat = 36 -->
				<td><%=leftseat %></td>	<!-- 잔여(예매가능)좌석 si.getLseat -->
			</tr>
<% }
} else {%>
			<tr>
				<td colspan="6">해당 노선의 시간표가 없습니다.</td>
			</tr>
<% } %>				
			</tbody>
<!-- 		</form>	 -->	
		</table>
		
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
	
	$("#sday3").datepicker({
		format: "yyyy.mm.dd",
		autoclose: true,
		startDate: "0d",
		endDate: "+30d",
		language: "kr",
		showMonthAfterYear: true,
		weekStart: 1,
		})
	    .on('changeDate', function(e) {	
	      $("#ri_sday3").val($(this).val());	// 왕복 가는 날, 오는 날 값 설정
	    });

});

function rowClicked(bsidx, etime, stime, bcname, bilevel, bladult, totalseat, leftseat) {
// 클릭한 행의 데이터를 가져와서 폼을 새롭게 생성하여 제출하기
	var form = document.createElement("form");
	form.method = "post";
	form.action = "sTicketingStep05";
	
	if (leftseat == 0) {
		alert("예매 가능한 좌석이 없습니다.");
		return;
	}

	// 클릭한 행의 데이터를 input hidden 필드로 추가
	var bsidxInput = document.createElement("input");
    bsidxInput.type = "hidden";
    bsidxInput.name = "bsidx";
    bsidxInput.value = bsidx;
    form.appendChild(bsidxInput);

    var etimeInput = document.createElement("input");
    etimeInput.type = "hidden";
    etimeInput.name = "etime";
    etimeInput.value = etime;
    form.appendChild(etimeInput);
	
	var busCompanyInput = document.createElement('input');
	busCompanyInput.type = 'hidden';
	busCompanyInput.name = 'bcname';	  
	busCompanyInput.value = bcname;
	form.appendChild(busCompanyInput); 

	var departureTimeInput = document.createElement('input');
	departureTimeInput.type = 'hidden';
	departureTimeInput.name = 'stime';  
	departureTimeInput.value = stime;
	form.appendChild(departureTimeInput);
	
	var busLevelInput = document.createElement('input');
	busLevelInput.type = 'hidden';
	busLevelInput.name = 'bilevel';	  
	busLevelInput.value = bilevel;
	form.appendChild(busLevelInput);
	
	var adultFareInput = document.createElement('input');
	adultFareInput.type = 'hidden';
	adultFareInput.name = 'bladult';	  
	adultFareInput.value = bladult;
	form.appendChild(adultFareInput);
	
	var totalSeatsInput = document.createElement('input');
	totalSeatsInput.type = 'hidden';
	totalSeatsInput.name = 'totalseat';  
	totalSeatsInput.value = totalseat;
	form.appendChild(totalSeatsInput);
	
	var availableSeatsInput = document.createElement('input');
	availableSeatsInput.type = 'hidden';
	availableSeatsInput.name = 'leftseat';  
	availableSeatsInput.value = leftseat;
	form.appendChild(availableSeatsInput);
	
	/* var ri_sday1Input = document.createElement("input");
	ri_sday1Input.type = "hidden";
	ri_sday1Input.name = "ri_sday3";
	ri_sday1Input.value = document.getElementById("ri_sday3").value;
	form.appendChild(ri_sday1Input); */
	
	// form 서버로 제출
	document.body.appendChild(form);
	form.submit();
}
</script>


    
