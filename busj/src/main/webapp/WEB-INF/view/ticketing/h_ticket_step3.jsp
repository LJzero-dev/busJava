<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
String mode = ri1.getMode();

int totalSeat = Integer.parseInt(request.getParameter("total-seat"));
int leftSeat = Integer.parseInt(request.getParameter("left-seat"));
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
<% } else { // 왕복일 경우 %>   
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
	<div class="row justify-content-center">
		<div class="col-md-6 text-center">
			<p>좌석선택 <%=leftSeat %>/<%=totalSeat %></p>
			<div class="seat-bg seat28 ml-auto">
		    <div class="seat-list">
				<span class="seat-box disabled"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_01" value="1" onclick="" disabled><label for="seatNum_28_01">1</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_02" value="2" onclick=""><label for="seatNum_28_02">2</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_03" value="3" onclick=""><label for="seatNum_28_03">3</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_04" value="4" onclick=""><label for="seatNum_28_04">4</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_05" value="5" onclick=""><label for="seatNum_28_05">5</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_06" value="6" onclick=""><label for="seatNum_28_06">6</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_07" value="7" onclick=""><label for="seatNum_28_07">7</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_08" value="8" onclick=""><label for="seatNum_28_08">8</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_09" value="9" onclick=""><label for="seatNum_28_09">9</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_10" value="10" onclick=""><label for="seatNum_28_10">10</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_11" value="11" onclick=""><label for="seatNum_28_11">11</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_12" value="12" onclick=""><label for="seatNum_28_12">12</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_13" value="13" onclick=""><label for="seatNum_28_13">13</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_14" value="14" onclick=""><label for="seatNum_28_14">14</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_15" value="15" onclick=""><label for="seatNum_28_15">15</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_16" value="16" onclick=""><label for="seatNum_28_16">16</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_17" value="17" onclick=""><label for="seatNum_28_17">17</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_18" value="18" onclick=""><label for="seatNum_28_18">18</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_19" value="19" onclick=""><label for="seatNum_28_19">19</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_20" value="20" onclick=""><label for="seatNum_28_20">20</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_21" value="21" onclick=""><label for="seatNum_28_21">21</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_22" value="22" onclick=""><label for="seatNum_28_22">22</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_23" value="23" onclick=""><label for="seatNum_28_23">23</label></span>
				<span class="seat-box"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_24" value="24" onclick=""><label for="seatNum_28_24">24</label></span>
				<span class="seat-box last_seat"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_25" value="25" onclick=""><label for="seatNum_28_25">25</label></span>
				<span class="seat-box last_seat"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_26" value="26" onclick=""><label for="seatNum_28_26">26</label></span>
				<span class="seat-box last_seat"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_27" value="27" onclick=""><label for="seatNum_28_27">27</label></span>
				<span class="seat-box last_seat last"><input type="checkbox" name="seatBoxDtl" id="seatNum_28_28" value="28" onclick=""><label for="seatNum_28_28">28</label></span>
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
				      <button type="button" class="btn btn-primary p-1">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
				        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>
				        </svg>
				      </button>
				      <input class="form-control text-center" type="text" name="ex1" id="exampleRadios1" value="1" size="5">
				      <button type="button" class="btn btn-primary p-1">
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
				      <button type="button" class="btn btn-primary p-1">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
				        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>
				        </svg>
				      </button>
				      <input class="form-control text-center" type="text" name="ex1" id="exampleRadios1" value="0" size="5">
				      <button type="button" class="btn btn-primary p-1">
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
				      <button type="button" class="btn btn-primary p-1">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-dash" viewBox="0 0 16 16">
				        <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"></path>
				        </svg>
				      </button>
				      <input class="form-control text-center" type="text" name="ex1" id="exampleRadios1" value="0" size="5">
				      <button type="button" class="btn btn-primary p-1">
				        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
				          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
				        </svg>
				      </button>
				    </div>
				  </div>
				</div>
				<hr />
				<p class="h5 text-right">총 ?명</p>
	      	</div>
			<div class="col-md-6 mb-5">
			  <h4>선택 좌석</h4>
			  <p class="h5">15, 16, 17</p>
			  <hr />
			</div>
			<div class="col-md-6">
			  <h4>금액</h4>
			  <div class="d-flex justify-content-between">
			    <p class="h5">성인 1</p>
			    <p class="h5">30,000</p>
			  </div>
			  <div class="d-flex justify-content-between">
			    <p class="h5">청소년 1</p>
			    <p class="h5">30,000</p>
			  </div>
			  <div class="d-flex justify-content-between">
			    <p class="h5">아동 1</p>
			    <p class="h5">30,000</p>
			  </div>
			  <hr />
			  <p class="h5 text-right mb-5">총 ?원</p>
			<button type="button" class="btn btn-primary btn-block">선택완료</button>
			</div>
		</div>
	</div>
	</div>
</section>
<%@ include file="../_inc/foot.jsp" %>
<script>

$(document).ready(function() {

});

</script>


    
