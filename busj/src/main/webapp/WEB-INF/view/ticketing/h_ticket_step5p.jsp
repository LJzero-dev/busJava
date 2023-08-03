<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
String[] seats1 = (String[])session.getAttribute("seats1");
String seatList = "";
for (String seat : seats1) {
	seatList += ", " + seat;
}
seatList = seatList.substring(2);
%>
<section class="probootstrap_section">
	<div class="container">
		<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
			<div class="col-md-12"><h2 class="border-bottom probootstrap-section-heading">고속버스 예매</h2></div>
			<div class="col-md-8 m-auto">
			  <div class="progress-bar-custom">
			    <div class="progress-step">
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
			    <div class="progress-step is-active">
			      <div class="step-count"></div>
			      <div class="step-description">예매 결과</div>
			    </div>
			  </div>
			</div>
		</div>
        <div class="row">
        	<div class="col-md-12">
				<div class="allchkbox active mb-5">
				<input type="checkbox" id="chkAll"><label for="chkAll" id="chkAllL"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-all" viewBox="0 0 16 16">
  				<path d="M8.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L2.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093L8.95 4.992a.252.252 0 0 1 .02-.022zm-.92 5.14.92.92a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 1 0-1.091-1.028L9.477 9.417l-.485-.486-.943 1.179z"/>
				</svg>예매가 완료되었습니다.</label>
				</div>
			</div>
			<div class="col-md-12 text-center mb-5">
			  <h4 class="text-left text-primary">승차권 정보</h4>
			  <h5 class="text-left">가는편</h5>
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
			        <td class="align-middle"><span class="badge badge-danger">출발지</span></td>
			        <td><%=ri1.getSspot() %></td>
			        <td class="align-middle"><span class="badge badge-primary">도착지</span></td>
			        <td><%=ri1.getEspot() %></td>
			        <td><%=ri1.getSdate() %></td>
			        <td>출발 <%=ri1.getStime() %></td>
			        <td>도착 <%=ri1.getEtime() %></td>
			        <td><%=ri1.getComname() %></td>
			      </tr>
			      <tr>
			      	<th colspan="2" class="text-center">예매 매수</th>
			        <td colspan="2" class="text-left">어른 <%=ri1.getRi_acnt() %>명, 청소년 <%=ri1.getRi_scnt() %>명, 아동 <%=ri1.getRi_ccnt() %>명</td>
			        <th colspan="2" class="text-center">예매 좌석</th>
			        <td colspan="2" class="text-left"></td>
			      </tr>
			    </tbody>
			  </table>
			</div>
			<div class="col-md-12 text-center mb-5">
			  <h4 class="text-left text-primary">결제 정보</h4>
			  <table class="table">
			    <colgroup>
			      <col width="25%">
			      <col width="25%">
			      <col width="25%">
			      <col width="*">
			    </colgroup>
			    <tbody>
			      <tr>
			        <th class="text-center">결제일시</th>
			        <td></td>
			        <th class="text-center">결제방법</th>
			        <td></td>
			      </tr>
			      <tr>
			        <th class="text-center">할인금액</th>
			        <td></td>
			        <th class="text-center">결제금액</th>
			        <td></td>
			      </tr>
			    </tbody>
			  </table>
			<ul class="text-left">
				<li>인터넷 예매를 이용한 승차권의 발권 및 환불은 해당 승차권의 출발지 터미널에서만 가능합니다.</li>
				<li>승차권 예매와 관련한 문의사항은 콜센터로 문의해주시기 바랍니다.</li>
			</ul>
			<div class="btn-wrap mt-2">
        		<button type="button" id="submitBtn" class="btn btn-lg btn-primary">예매 확인</button>
        	</div>
			</div>
			
</section>
<%@ include file="../_inc/foot.jsp" %>
<script>

// const pmoneybox = document.getElementById('pmoney_view');
// const paymentChks = document.getElementsByName('paymentOpt');
<%-- const myPmoney = <%=loginInfo.getMi_pmoney() %>; --%>
<%-- const basePrice = <%=base_price %>; --%>

// $("#basePrice").text(basePrice.toLocaleString());
// $("#realPrice").text(basePrice.toLocaleString());
// $("#myPmoney").text(myPmoney.toLocaleString());

// $(document).ready(function() {

// });

</script>


    
