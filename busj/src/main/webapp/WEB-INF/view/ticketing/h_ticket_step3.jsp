<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
String mode = ri1.getMode();

int totalSeat = Integer.parseInt(request.getParameter("total-seat"));
int leftSeat = Integer.parseInt(request.getParameter("left-seat"));

List<SeatInfo> seatList = (List<SeatInfo>)session.getAttribute("seatList");

String action = "";
if (mode.equals("p"))	action = "hTicketingStep04P";
else					action = "hTicketingStep04W";
%>
<section class="probootstrap_section">
	<div class="container">
	<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
		<div class="col-md-12"><h2 class="border-bottom probootstrap-section-heading">고속버스 예매</h2></div>
			<div class="col-md-12">
<% if (mode.equals("p")) { // 편도일 경우 %>
				<div class="col-md-8 m-auto">
					<div class="progress-bar-custom 1">
					    <div class="progress-step ">
					      <div class="step-count"></div>
					      <div class="step-description">정보 입력</div>
					    </div>
					    <div class="progress-step">
					      <div class="step-count"></div>
					      <div class="step-description">배차 조회</div>
					    </div>
					    <div class="progress-step is-active">
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
<% } else { // 왕복일 경우 %>   
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
		                <div class="progress-step is-active">
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
			<h4 class="display-5 probootstrap-section-heading text-left">가는편</h4>
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
			      <td><%=ri1.getSspot() %></td>
			      <td><span class="badge badge-primary">도착지</span></td>
			      <td><%=ri1.getEspot() %></td>
			      <td><%=ri1.getSdate() %></td>
			      <td>출발 <%=ri1.getStime() %></td>
			      <td>도착 <%=ri1.getEtime() %></td>
			      <td><%=ri1.getComname() %></td>
			    </tr>
			  </tbody>
			</table>
		</div>
	</div>
	<form name="frmSeat" action="<%=action %>" method="post">
	<div class="row justify-content-center">
		<input type="hidden" name="totalPrice" id="totalP" value="" />
		<div class="col-md-6 text-center">
			<p>좌석선택 <%=leftSeat %>/<%=totalSeat %></p>
			<div class="seat-bg <%= ri1.getLevel().equals("우등") ? "seat28" : "seat18" %> ml-auto">
				<div class="seat-list">
<% for (SeatInfo si : seatList) { %>
				<span class="seat-box <% if (si.getReserved_yn().equals("Y")) { %>disabled<% } %> <% if (si.getSi_seat() > 24) %>last_seat <% if (si.getSi_seat() == 28) { %>last<% }%>">
					<input type="checkbox" name="seatBoxDtl" id="seatNum_<%=si.getSi_seat() %>" value="<%=si.getSi_seat() %>" onclick="getSeat(this);" <% if (si.getReserved_yn().equals("Y")) { %>disabled<% } %>>
					<label for="seatNum_<%=si.getSi_seat() %>"><%=si.getSi_seat() %></label>
				</span>
<% } %>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="col-md-6 mb-5">
			  <h4>매수</h4>
				<div class="d-flex mb-2 align-items-center">
				  <div class="col-md-5"><span class="mr-3">성인</span></div>
				  <div class="col-md-7">
				    <div class="btn-group custom">
				      <button type="button" id="minusA" class="btn btn-primary p-1" onclick="setCnt(this.id);">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
				        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>
				        </svg>
				      </button>
				      <input class="form-control text-center" type="text" name="adult" id="adult" value="0" size="5" readonly>
				      <button type="button" id="plusA" class="btn btn-primary p-1" onclick="setCnt(this.id);">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
				          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
				        </svg>
				      </button>
				    </div>
				  </div>
				</div>
				<div class="d-flex mb-2 align-items-center">
				  <div class="col-md-5"><span class="mr-3">청소년</span></div>
				  <div class="col-md-7">
				    <div class="btn-group custom">
				      <button type="button" id="minusT" class="btn btn-primary p-1" onclick="setCnt(this.id);">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
				        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>
				        </svg>
				      </button>
				      <input class="form-control text-center" type="text" name="teen" id="teen" value="0" size="5" readonly>
				      <button type="button" id="plusT" class="btn btn-primary p-1" onclick="setCnt(this.id);">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
				          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
				        </svg>
				      </button>
				    </div>
				  </div>
				</div>
				<div class="d-flex mb-2 align-items-center">
				  <div class="col-md-5"><span class="mr-3">아동</span></div>
				  <div class="col-md-7">
				    <div class="btn-group custom">
				      <button type="button" id="minusC" class="btn btn-primary p-1" onclick="setCnt(this.id);">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
				        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>
				        </svg>
				      </button>
				      <input class="form-control text-center" type="text" name="child" id="child" value="0" size="5" readonly>
				      <button type="button" id="plusC" class="btn btn-primary p-1" onclick="setCnt(this.id);">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
				          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
				        </svg>
				      </button>
				    </div>
				  </div>
				</div>
				<hr />
				<p class="h5 text-right">총 <span id="totalCnt">0</span>명</p>
	      	</div>
			<div class="col-md-6 mb-5">
			  <h4>선택 좌석</h4>
			  <p id="seatArr" class="h5">좌석을 선택해주세요.</p>
			  <hr />
			</div>
			<div class="col-md-6">
			  <h4>금액</h4>
			  <div class="d-flex justify-content-between">
			    <span>성인 <span id="adult2">0</span>명</span>
			    <span id="priceA"></span>
			  </div>
			  <div class="d-flex justify-content-between">
			    <span>청소년 <span id="teen2">0</span>명</span>
			    <span id="priceT">0</span>
			  </div>
			  <div class="d-flex justify-content-between">
			    <span>아동 <span id="child2">0</span>명</span>
			    <span id="priceC">0</span>
			  </div>
			  <hr />
			  <p class="h5 text-right mb-5">총 <span id="totalPrice"></span>원</p>
			<button type="button" id="submitBtn" class="btn btn-primary btn-block">선택완료</button>
			</div>
		</div>
	</div>
	</form>
	</div>
</section>
<%@ include file="../_inc/foot.jsp" %>
<script>

const selectedValues = [];
const seats = document.getElementsByName("seatBoxDtl");
function setCnt(op) {
	if ( $("#totalCnt").text() == 10 && (op == 'plusA' || op == 'plusT' || op == 'plusC')) {
		alert("최대 예약 가능 인원은 10명입니다.");
		return;
	}
	
	let adult = parseInt($("#adult").val());
	let teen = parseInt($("#teen").val());
	let child = parseInt($("#child").val());
	
	// 연산자가 마이너스이고 해당 필드가 0인경우 미리 return하여 아래 배열에 영향을 주지않도록 함 (어른은 기본 1선택)
	if ((op == 'minusA' && adult === 1) || (op == 'minusT' && teen === 0) || (op == 'minusC' && child === 0)) {
	    return;
	}
	
	// 어른 필드 계산시
	if (op == 'minusA' && !(adult < 2)) {
		$("#adult").val(adult - 1);
		adult--;
	} else if (op == 'plusA' && !(adult > 9)) {
		$("#adult").val(adult + 1);
		adult++;
	}
	
	// 청소년 필드 계산시
	if (op == 'minusT' && !(teen < 1)) {
		$("#teen").val(teen - 1);
		teen--;
	} else if (op == 'plusT' && !(teen > 9)) {
		$("#teen").val(teen + 1);
		teen++;
	}
	
	// 아동 필드 계산시
	if (op == 'minusC' && !(child < 1)) {
		$("#child").val(child - 1);
		child--;
	} else if (op == 'plusC' && !(child > 9)) {
		$("#child").val(child + 1);
		child++;
	}
	
	
	$("#adult2").text(adult);	$("#teen2").text(teen);	$("#child2").text(child);
	$("#priceA").text(formatNumber(adult * <%=ri1.getPrice()%>));
	$("#priceT").text(formatNumber(teen * <%=ri1.getPrice()%> * 0.8));
	$("#priceC").text(formatNumber(child * <%=ri1.getPrice()%> * 0.5));
	  
	$("#totalCnt").text(adult + teen + child);
	$("#totalPrice").text(formatNumber(adult * <%=ri1.getPrice()%> + teen * <%=ri1.getPrice()%> * 0.8 + child * <%=ri1.getPrice()%> * 0.5));
	$("#totalP").val((adult * <%=ri1.getPrice()%> + teen * <%=ri1.getPrice()%> * 0.8 + child * <%=ri1.getPrice()%> * 0.5));

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
	const index = selectedValues.indexOf(value);	// 체크한 값이 배열에 이미 있는지 확인을 위한 변수
	
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
	
	if (index === -1) {
	    selectedValues.push(value);
	  } else {
	    selectedValues.splice(index, 1);
	  }
	
	// 배열 오름차순 정렬
	selectedValues.sort(function (a, b) {
	  return a - b;
	});
	
	$("#seatArr").text(selectedValues.join(", "));
	
	if (selectedValues.length == 0) {
		$("#seatArr").text("좌석을 선택해주세요.");
	}
	
}

$(document).ready(function() {
	setCnt('plusA');
	// 기본적으로 성인1명의 표 값이 보이는 상태로 로딩
	
	$("#submitBtn").click(function() {
		if (!(selectedValues.length == parseInt($("#totalCnt").text()))) {
			alert("좌석을 선택해주세요.");
		} else {
			document.frmSeat.submit();
		}
	});
});

</script>


    
