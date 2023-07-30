<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String mode = request.getParameter("mode");
String ri_sday1 = request.getParameter("ri_sday1");
String ri_sday2 = request.getParameter("ri_sday2");
String btsname = request.getParameter("btsname");
String btename = request.getParameter("btename");
List<ReservationStep2> scheduleList = (List<ReservationStep2>)request.getAttribute("scheduleList");
int bsidx = 0;
/* System.out.println(mode);
System.out.println(ri_sday1);	// 편도 : 가는날	왕복 : 가는날	형식 : yyyy.mm.dd
System.out.println(ri_sday2);	// 편도 : 가는날 	왕복 : 오는날	
System.out.println(btsname);	// 출발지 : 터미널 이름(bt_name)
System.out.println(btename);	// 도착지 : 터미널 이름(bt_name) */
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
<% if (mode.equals("p")) { // 편도일 경우 %>
			<div class="col-md-8 m-auto">
			<div class="progress-bar-custom 1">
				<div class="progress-step ">
					<div class="step-count"></div>
					<div class="step-description">정보 입력</div>
				</div>
				<div class="progress-step is-active">
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
<% } else { // mode.equals("w")왕복일 경우 %>   
			<div class="col-md-12 m-auto">
			<div class="progress-bar-custom 2">
				<div class="progress-step">
					<div class="step-count"></div>
					<div class="step-description">정보 입력</div>
				</div>
				<div class="progress-step is-active">
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
<% } %>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 text-center mb-5">
		<h5 class="text-left"><% if (mode.equals("p")) { // 편도일 경우 %>가는편<%} %><%else { // 왕복일 경우 %>가는 날 가는편<%} %></h5>
		<form name="frmSchedule" action="sTicketingStep03" method="post">
		<input type="hidden" name="mode" id="mode" value="<%=mode %>" />
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
				<td class="align-middle"><%=btsname %></td>
				<td class="align-middle"><span class="badge badge-primary">도착지</span></td>
				<td class="align-middle"><%=btename %></td>
				<td class="text-left">
					<div class="w-50">
					<div class="probootstrap-date-wrap">
						<span class="icon ion-calendar"></span> 
							<input type="text" id="sday1" class="form-control" value="<%=ri_sday1 %>" readonly >
					</div>
					</div>
				</td>	
			</tr>
			</tbody>
		</table>
		</form>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
		<form name="frmSchedule" action="sTicketingStep03" method="post">
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
<%for (ReservationStep2 sl : scheduleList) {
	bsidx = sl.getBs_idx();
	int seat = 0;
	if (sl.getBi_level().equals("우등"))	seat = 28;
	else 								seat = 36;
%>
			<tr onclick="rowClicked(this)">	
				<td><%=sl.getBs_stime() %></td>	<!-- 출발시간 si.getBs_stime -->
				<td><%=sl.getBc_name() %></td>	<!-- 버스회사이름 bc_name -->
				<td><%=sl.getBi_level() %></td>		<!-- 버스등급 bi_level -->
				<td><%=sl.getBl_adult() %></td>	<!-- 성인요금 bl_adult -->
				<td><%=seat%></td>		<!-- 전체좌석 int seat		if(bi_level.equals("우등")) seat = 28 else seat = 36 -->
				<td>구하는 방법을 알려줘...</td>		<!-- 잔여(예매가능)좌석 si.getLseat -->			
			</tr>
<% } %>				
			</tbody>
		</form>	
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
	
    
	$("#sday1").datepicker({
		format: "yyyy.mm.dd",
		autoclose: true,
		startDate: "0d",
		endDate: "+30d",
		language: "kr",
		showMonthAfterYear: true,
		weekStart: 1,
		});
		
});

function rowClicked(row) {
	  // 클릭한 행의 데이터를 가져오기
	  var bsidx = <%=bsidx %>; // bs_idx 값 추가
	  // 기존의 form 가져오기
	  var form = document.forms['frmSchedule'];
	  // 클릭한 행의 데이터를 input hidden 필드로 추가
	  var bsIdxInput = document.createElement('input');
	  bsIdxInput.type = 'hidden';
	  bsIdxInput.name = 'bsidx';
	  bsIdxInput.value = bsidx;
	  form.appendChild(bsIdxInput);
	  // form 서버로 제출
	  form.submit();
}
</script>


    
