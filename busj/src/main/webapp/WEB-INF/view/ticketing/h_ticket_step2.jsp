<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
%>

<section class="probootstrap_section">
	<div class="container">
		<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated mb-0">
			<div class="col-md-12"><h2 class="border-bottom mb-5 probootstrap-section-heading">고속버스 예매</h2></div>
			<div class="col-md-12">
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
			</div>
		</div>
        <div class="row">
			<div class="col-md-12 text-center mb-5">
				<h5 class="text-left">가는편</h5>
	            <table class="table">
					<colgroup>
						<col width="5%">
		                <col width="15%">
		                <col width="5%">
		                <col width="15%">
		                <col width="*">
					</colgroup>
		            <tbody>
		              <tr>
		                <td><span class="badge badge-danger">출발지</span></td>
		                <td>서울</td>
		                <td><span class="badge badge-primary">도착지</span></td>
		                <td>부산</td>
		                <td class="text-left">
		                  <div class="w-50">
		                  <div class="probootstrap-date-wrap">
		                        <span class="icon ion-calendar"></span> 
		                        <input type="text" id="probootstrap-date-departure" class="form-control" placeholder="">
		                      </div></td>
		                  </div>
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
		            <thead>
		            <tr>
		                <th scope="col" class="text-center">출발시각</th>
		                <th scope="col" class="text-center">고속사</th>
		                <th scope="col" class="text-center">등급</th>
		                <th scope="col" class="text-center">금액</th>
		                <th scope="col" class="text-center">전체좌석</th>
		                <th scope="col" class="text-center">잔여좌석</th>
		            </tr>
		            </thead>
		            <tbody class="text-center">
		            <tr>
		                <td>HH:MM</td>
		                <td>동양고속</td>
		                <td>우등</td>
		                <td>30000</td>
		                <td>28</td>
		                <td>20</td>
		            </tr>
		            </tbody>
				</table>
				<!-- 페이지네이션 영역 -->
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
				<!-- 페이지네이션 영역 끝 -->
			</div>
		</div>
	</div>
</section>
<%@ include file="../_inc/foot.jsp" %>
<script>


function getToday(){
	const DATE = new Date();
    const YEAR = DATE.getFullYear();
    const MONTH = ("0" + (1 + DATE.getMonth())).slice(-2);
    const DAY = ("0" + DATE.getDate()).slice(-2);

    return YEAR + "." + MONTH + "." + DAY;
}


$(document).ready(function() {

});
</script>


    
