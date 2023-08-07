<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ReservationInfo ri1 = (ReservationInfo)session.getAttribute("ri1");
ReservationInfo ri2 = (ReservationInfo)session.getAttribute("ri2");

int bsidx = Integer.parseInt(request.getParameter("bsidx"));	// 시간표인덱스 번호
int totalseat = Integer.parseInt(request.getParameter("totalseat"));	// 전체좌석
int leftseat = Integer.parseInt(request.getParameter("leftseat"));		// 잔여좌석

List<SeatInfo> seatList = (List<SeatInfo>)request.getAttribute("seatList"); 
%>

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
				<div class="progress-step">
					<div class="step-count"></div>
					<div class="step-description">오는 날 배차 조회</div>
				</div>
				<div class="progress-step is-active">
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
		<h4 class="display-5 probootstrap-section-heading text-left">오는편</h4>
		<table class="table">
			<colgroup>
				<col width="5%">
				<col width="15%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<tbody>
			<tr>
				<td><span class="badge badge-danger">출발지</span></td>
				<td><%=ri2.getSspot() %></td>
				<td><span class="badge badge-primary">도착지</span></td>
				<td><%=ri2.getEspot() %></td>
				<td><%=ri2.getSdate() %></td>
				<td>출발 <%=ri2.getStime() %></td>
				<td>도착 <%=ri2.getEtime() %></td>
				<td><%=ri2.getComname() %></td>
			</tr>
			</tbody>
		</table>
		</div>
	</div>
	<form name="frmSeat" action="sTicketingPay" method="post">
		<input type="hidden" name="selectedSeats" id="selectedSeats" value="">
		<input type="hidden" name="selectedSeatsIndexes" id="selectedSeatsIndexes" value="">
		<input type="hidden" name="basePrice2" id="baseP" value="" />
	<div class="row justify-content-center">
		<div class="col-md-6 text-center">
			<p>좌석선택 <%=leftseat %> / <%=totalseat %></p>
            <div class="seat-bg seat<%=totalseat %> ml-auto">
			<div class="seat-list">
			<!-- reserved_yn 'Y' : 예매완료(disabled) 'N' : 예매가능 -->
<%for(SeatInfo si : seatList) {
	String disabled = "", last_seat = "", check = "getSeat(this);";
	if (si.getReserved_yn().equals("Y")) {
		disabled = "disabled";
		check = "return false;";
	}
	if (totalseat == 28) {
		if (si.getSi_seat() >= 25 && si.getSi_seat() < totalseat)	last_seat = "last_seat";
		else if (si.getSi_seat() == totalseat)						last_seat = "last_seat last";
	}
%>
				<span class="seat-box <%=disabled %> <%=last_seat%>">
					<input type="checkbox" name="seatBoxDtl" id="seatNum_<%=si.getSi_seat() %>" data-idx="<%=si.getSi_idx() %>" value="<%=si.getSi_seat() %>" onclick="<%=check %>" <%=disabled %>>
					<label for="seatNum_<%=si.getSi_seat() %>"><%=si.getSi_seat() %></label>
				</span>
<%} %>
			</div>
			</div>
		</div>
		<div class="col-md-6">
		<div class="col-md-6 mb-5">
		<h4>매수</h4>
			<div class="d-block mb-2">
			<span class="mr-3">성인</span>
				<div class="btn-group custom">
					<button type="button" id="minusA" class="btn btn-primary p-1" onclick="setCnt(this.id);">	<!-- [-] 버튼 -->
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
						<path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>	<!-- 좌표값 -->
						</svg>
					</button>
					<input class="form-control text-center" type="text" name="riacnt" id="riacnt" value="0" size="5" readonly>	<!-- 성인티켓량 -->
					<button type="button" id="plusA" class="btn btn-primary p-1" onclick="setCnt(this.id);">	<!-- [+] 버튼 -->
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
						<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
						</svg>
					</button>
				</div>
			</div>
			<div class="d-block mb-2">
			<span class="mr-2">청소년</span>
				<div class="btn-group custom">
					<button type="button" id="minusT" class="btn btn-primary p-1" onclick="setCnt(this.id);">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
						<path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>
						</svg>
					</button>
					<input class="form-control text-center" type="text" name="riscnt" id="riscnt" value="0" size="5" readonly>
					<button type="button" id="plusT" class="btn btn-primary p-1" onclick="setCnt(this.id);">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
						<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
						</svg>
					</button>
				</div>
			</div>
			<div class="d-block mb-2">
			<span class="mr-3">아동</span>
				<div class="btn-group custom">
					<button type="button" id="minusC" class="btn btn-primary p-1" onclick="setCnt(this.id);">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
						<path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>	
						</svg>
					</button>
					<input class="form-control text-center" type="text" name="riccnt" id="riccnt" value="0" size="5" readonly>
					<button type="button" id="plusC" class="btn btn-primary p-1" onclick="setCnt(this.id);">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
						<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
						</svg>
					</button>
				</div>
			</div>
		<hr />
			<p class="h5 text-right">총 <span id="totalCnt">0</span> 명</p>
		</div>
		<div class="col-md-6 mb-5">
		<h4>선택 좌석</h4>
			<p id="seatArr" class="h5">좌석을 선택해주세요.</p>
		<hr />
		</div>
		<div class="col-md-6">
		<h4>금액</h4>
			<div class="d-flex justify-content-between">
				<span>성인 <span id="riacnt2">0</span> 명</span>
				<span id="priceA"></span>
			</div>
			<div class="d-flex justify-content-between">
				<span>청소년 <span id="riscnt2">0</span> 명</span>
				<span id="priceT"></span>
			</div>
			<div class="d-flex justify-content-between">
				<span>아동 <span id="riccnt2">0</span> 명</span>
				<span id="priceC"></span>
			</div>
		<hr />
			<p class="h5 text-right mb-5">총 <span id="basePrice2">0</span> 원</p>
				<button type="button" id="submitBtn" class="btn btn-primary btn-block">선택완료</button>
		</div>
		</div>
	</div>
	</form>
</div>
</section>
<!-- END section -->

<%@ include file="../_inc/foot.jsp" %>

<script>
const selectedValues = [];	// 좌석배열
const selectedIndexes = [];	// 좌석idx배열
const seats = document.getElementsByName("seatBoxDtl");
const selectedSeatsInput = document.getElementById("selectedSeats");
const selectedIndexesInput = document.getElementById("selectedSeatsIndexes");

function setCnt(op) {	// 매수 선택필드의 [-] / [+] 버튼 클릭 시 
	if (<%=leftseat %> >= 10) {
		if ( $("#totalCnt").text() == 10 && (op == 'plusA' || op == 'plusT' || op == 'plusC')) {
			alert("최대 예약 가능 인원은 10명입니다.");
			return;
		}
	} else if (<%=leftseat %> < 10) {
		if ( $("#totalCnt").text() == <%=leftseat %> && (op == 'plusA' || op == 'plusT' || op == 'plusC')) {
			alert("예약 가능한 좌석을 모두 선택하셨습니다.");
			return;
		}
	}
	
	let riacnt = parseInt($("#riacnt").val());	// 성인인원
	let riscnt = parseInt($("#riscnt").val());	// 청소년인원
	let riccnt = parseInt($("#riccnt").val());	// 아동인원
	
	// 연산자가 마이너스이고 해당 필드가 0인경우 미리 return하여 아래 배열에 영향을 주지않도록 함 (어른은 기본 1선택)
	if ((op == 'minusA' && riacnt === 0) || (op == 'minusT' && riscnt === 0) || (op == 'minusC' && riccnt === 0)) {
	    return;
	}
	
	// 어른 필드 계산시
	if (op == 'minusA' && !(riacnt < 1)) {
		$("#riacnt").val(riacnt - 1);
		riacnt--;
	} else if (op == 'plusA' && !(riacnt > 9)) {
		$("#riacnt").val(riacnt + 1);
		riacnt++;
	}
	
	// 청소년 필드 계산시
	if (op == 'minusT' && !(riscnt < 1)) {
		$("#riscnt").val(riscnt - 1);
		riscnt--;
	} else if (op == 'plusT' && !(riscnt > 9)) {
		$("#riscnt").val(riscnt + 1);
		riscnt++;
	}
	
	// 아동 필드 계산시
	if (op == 'minusC' && !(riccnt < 1)) {
		$("#riccnt").val(riccnt - 1);
		riccnt--;
	} else if (op == 'plusC' && !(riccnt > 9)) {
		$("#riccnt").val(riccnt + 1);
		riccnt++;
	}
	
	
	$("#riacnt2").text(riacnt);	$("#riscnt2").text(riscnt);	$("#riccnt2").text(riccnt);
	$("#priceA").text(formatNumber(riacnt * <%=ri2.getPrice()%>));
	$("#priceT").text(formatNumber(riscnt * <%=ri2.getPrice()%> * 0.8));
	$("#priceC").text(formatNumber(riccnt * <%=ri2.getPrice()%> * 0.5));
	  
	$("#totalCnt").text(riacnt + riscnt + riccnt);
	$("#basePrice2").text(formatNumber(riacnt * <%=ri2.getPrice()%> + riscnt * <%=ri2.getPrice()%> * 0.8 + riccnt * <%=ri2.getPrice()%> * 0.5));
	$("#baseP").val((riacnt * <%=ri2.getPrice()%> + riscnt * <%=ri2.getPrice()%> * 0.8 + riccnt * <%=ri2.getPrice()%> * 0.5));

	let seatsCnt = 0;
	for (let i = 0; i < seats.length; i++) {
		if (seats[i].checked) {
			seatsCnt++;
		}
	}
	
	if (op == 'minusA' || op == 'minusT' || op == 'minusC') {
		if (seatsCnt == selectedValues.length) {
			selectedValues.splice(selectedValues.length - 1);
			$("#seatArr").text(selectedValues.join(", "));
			for (let i = seats.length - 1; i >= 0 ; i--) {
				if (seats[i].checked) {
					seats[i].checked = false;
					return;
				}
			}
		}
		
		if (selectedValues.length == 0) {
			$("#seatArr").text("좌석을 선택해주세요.");
		}
	}
}

function formatNumber(number) {
	  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function getSeat(obj) {
		
	const value = obj.value;
	const siIdx = obj.dataset.idx;
	
	const index = selectedValues.indexOf(value);	// 체크한 값이 배열에 이미 있는지 확인을 위한 변수
	const idxIndex = selectedIndexes.indexOf(siIdx);
 
    
	let seatsCnt = 0;
	let max = parseInt($("#totalCnt").text());
	for (let i = 0; i < seats.length; i++) {
		if (seats[i].checked) {
			seatsCnt++;
		}
	}
	if (seatsCnt > max) {
		alert("먼저 매수를 선택해 주세요.");
		obj.checked = false;
		return false;
	}
	
	if (obj.checked) {
		if (index === -1) {
		    selectedValues.push(value);			// 선택한 좌석을 배열에 추가
		    selectedIndexes.push(siIdx);       // 선택된 좌석의 siIdx 값을 배열에 추가
		}
	} else {
		if (index !== -1) {
			selectedValues.splice(index, 1);   // 선택을 해제한 좌석을 배열에서 제거
		}
		if (idxIndex !== -1) {
			selectedIndexes.splice(idxIndex, 1); // 선택을 해제한 좌석의 siIdx 값을 배열에서 제거
		}
	}
	
	// 배열 오름차순 정렬
	selectedValues.sort(function (a, b) {
	  return a - b;
	});
	
	$("#seatArr").text(selectedValues.join(", "));
	selectedSeatsInput.value = selectedValues.join(", ");	// 선택된 좌석 값을 hidden input에 설정
	selectedIndexesInput.value = selectedIndexes.join(", ");   // 선택된 좌석의 siIdx 값을 숨겨진 입력 필드에 설정
	
	if (selectedValues.length == 0) {
		$("#seatArr").text("좌석을 선택해주세요.");
	}
	
}

$(document).ready(function() {

	$("#submitBtn").click(function() {
		// 총 인원이 선택이 0이고 좌석이 선택되지 않은 경우
		let totalHeadcount = parseInt($("#totalCnt").text());
		
		if (totalHeadcount === 0 && selectedValues.length === 0) {
			alert("인원이 선택되지 않았습니다.\n인원 선택 후 좌석을 선택해주세요.");
			return false;
		} else if (selectedValues.length !== totalHeadcount) {
			alert("좌석을 모두 선택해주세요.");
			return false;
		} else {
			document.frmSeat.submit();
		}
	});
});


</script>


    
