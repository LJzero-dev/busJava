<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "java.time.format.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
int realPrice = (int)((ri1.getPrice() * ri1.getRi_acnt()) + (ri1.getPrice() * 0.8 * ri1.getRi_scnt()) + (ri1.getPrice() * 0.5 * ri1.getRi_ccnt()));

LocalDateTime nowDateTime = LocalDateTime.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd E요일 HH:mm");
String formattedDateTime = nowDateTime.format(formatter);
%>
<section class="probootstrap_section">
	<div class="container">
		<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
			<div class="col-md-12"><h2 class="border-bottom probootstrap-section-heading">시외버스 예매</h2></div>
						<div class="col-md-12">
<% if (ri1.getMode().equals("p")) { // 편도일 경우 %>
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
		                <div class="progress-step is-active">
		                  <div class="step-count"></div>
		                  <div class="step-description">예매 결과</div>
		                </div>
					</div>
				</div>
<% } %>
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
			      <tr class="border-b">
			      	<td colspan="2">예매 매수</td>
			        <td colspan="2" class="text-left">어른 <%=ri1.getRi_acnt() %>명, 청소년 <%=ri1.getRi_scnt() %>명, 아동 <%=ri1.getRi_ccnt() %>명</td>
			        <td colspan="2">예매 좌석</td>
			        <td colspan="2" class="text-left"><%=ri1.getSeat() %></td>
			      </tr>
			    </tbody>
			  </table>
<% if (ri1.getMode().equals("w")) {
	ReservationInfo ri2 = (ReservationInfo) session.getAttribute("ri2");
	realPrice += ri2.getPrice() * (ri2.getRi_acnt() + ri2.getRi_scnt()+ ri2.getRi_ccnt());
%>
				<h5 class="text-left mt-5">오는편</h5>
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
				      <td><%=ri2.getSspot() %></td>
				      <td class="align-middle"><span class="badge badge-primary">도착지</span></td>
				      <td><%=ri2.getEspot() %></td>
				      <td><%=ri2.getSdate() %></td>
				      <td>출발 <%=ri2.getStime() %></td>
				      <td>도착 <%=ri2.getEtime() %></td>
				      <td><%=ri2.getComname() %></td>
				    </tr>
				    <tr class="border-b">
				      <td colspan="2">예매 매수</td>
				      <td colspan="2" class="text-left">어른 <%=ri2.getRi_acnt() %>명, 청소년 <%=ri2.getRi_scnt() %>명, 아동 <%=ri2.getRi_ccnt() %>명</td>
				      <td colspan="2">예매 좌석</td>
				      <td colspan="2" class="text-left"><%=ri2.getSeat() %></td>
				    </tr>
				  </tbody>
				</table>
<% } %>
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
			        <td><%=formattedDateTime %></td>
			        <th class="text-center">결제방법</th>
			        <td><%=ri1.getPayment() %></td>
			      </tr>
			      <tr>
			        <th class="text-center">할인금액</th>
			        <td>-</td>
			        <th class="text-center">결제금액</th>
			        <td class="text-right"><%=String.format("%,d", realPrice) %></td>
			      </tr>
			    </tbody>
			  </table>
			<ul class="text-left">
				<li>인터넷 예매를 이용한 승차권의 발권 및 환불은 해당 승차권의 출발지 터미널에서만 가능합니다.</li>
				<li>승차권 예매와 관련한 문의사항은 콜센터로 문의해주시기 바랍니다.</li>
			</ul>
			<div class="btn-wrap mt-2">
				<a href="/busj/booking" class="btn btn-lg btn-primary">예매 확인</a>
        	</div>
			</div>
			
</section>
<%@ include file="../_inc/foot.jsp" %>