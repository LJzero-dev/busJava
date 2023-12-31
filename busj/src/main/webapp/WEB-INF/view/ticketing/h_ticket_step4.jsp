<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
List<ScheduleInfo> scheduleList = (List<ScheduleInfo>)session.getAttribute("scheduleList");
ReservationInfo ri2 = (ReservationInfo) session.getAttribute("ri2");
%>
<section class="probootstrap_section">
	<div class="container">
		<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated mb-0">
			<div class="col-md-12"><h2 class="border-bottom mb-5 probootstrap-section-heading">고속버스 예매</h2></div>
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
		                <col width="10%">
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
<!-- 		                  <div class="w-50"> -->
<!-- 		                  <div class="probootstrap-date-wrap"> -->
<!-- 		                        <span class="icon ion-calendar"></span>  -->
<%-- 		                        <input type="text" id="sDate" class="form-control" value="<%=ri2.getSdate()%>" readonly> --%>
<!-- 		                      </div></td> -->
<!-- 		                  </div> -->
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
		            <!-- 시간표 영역 -->
					<form name="frmSchedule" method="post" action="hTicketingStep05">
					<input type="hidden" id="bsidx" name="bsidx" value="" />
					<input type="hidden" id="bllevel" name="bllevel" value="" />
					<input type="hidden" id="price" name="price" value="" />
					<input type="hidden" id="comname" name="comname" value="" />
					<input type="hidden" id="stime" name="stime" value="" />
					<input type="hidden" id="etime" name="etime" value="" />
					<input type="hidden" id="total-seat" name="total-seat" value="" />
					<input type="hidden" id="left-seat" name="left-seat" value="" />
					
<% if (scheduleList.size() > 0) {	// 해당 노선의 시간표가 있는 경우
for (ScheduleInfo sl : scheduleList) { 
	int adultPrice = 0;
	if (sl.getBi_level().equals("우등"))	adultPrice = sl.getBl_adult();
	else	adultPrice = (int)(sl.getBl_adult() * 1.5);
	if (sl.getLeft_seat() == 0) {	// 해당 노선이 매진인 경우 %>
		<tr class="sold-out">
			<td><%=sl.getBs_stime() %></td>
		    <td><%=sl.getComname() %>고속</td>
		    <td><%=sl.getBi_level() %></td>
		    <td><%= String.format("%,d", adultPrice) %></td>
		    <td><%=sl.getTotal_seat() %></td>
		    <td>매진</td>
		</tr>
		
<%	} else { // 해당 노선이 매진이 아닌경우 %>
		<tr class="data" data-bsidx="<%=sl.getBs_idx()%>" data-etime="<%=sl.getBs_etime()%>">
						<td><%=sl.getBs_stime() %></td>
					    <td><%=sl.getComname() %>고속</td>
					    <td><%=sl.getBi_level() %></td>
					    <td><%= String.format("%,d", adultPrice) %></td>
					    <td><%=sl.getTotal_seat() %></td>
					    <td><%=sl.getLeft_seat() %></td>
					</tr>
	<% }  %>			
<% 
	} 
} else { // 해당 노선의 시간표가 없는 경우 %>
					<tr>
						<td colspan="6">해당 노선의 시간표가 없습니다.</td>
					</tr>
<% } %>				
     
		            </form>
		            </tbody>
				</table>
				<!-- 페이지네이션 영역 -->
<!-- 				<nav aria-label="Page navigation example" class="mt-4"> -->
<!-- 					<ul class="pagination justify-content-center"> -->
<!-- 						<li class="page-item"> -->
<!-- 						  <a class="page-link" href="#" aria-label="Previous"> -->
<!-- 						    <span aria-hidden="true">&laquo;</span> -->
<!-- 						  </a> -->
<!-- 						</li> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">1</a></li> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!-- 						<li class="page-item"> -->
<!-- 						  <a class="page-link" href="#" aria-label="Next"> -->
<!-- 						    <span aria-hidden="true">&raquo;</span> -->
<!-- 						  </a> -->
<!-- 						</li> -->
<!-- 					</ul> -->
<!-- 				</nav> -->
				<!-- 페이지네이션 영역 끝 -->
			</div>
		</div>
	</div>
</section>
<%@ include file="../_inc/foot.jsp" %>
<script>



$(document).ready(function() {
	
    
	$("#sDate").datepicker({
		format: "yyyy.mm.dd",
		autoclose: true,
		startDate: "0d",
		endDate: "+30d",
		language: "kr",
		showMonthAfterYear: true,
		weekStart: 1,
		});

	$("tr.data").on('click', function() {
		let stime = $(this).find('td:nth-child(1)').text();
		let comname = $(this).find('td:nth-child(2)').text();
		let level = $(this).find('td:nth-child(3)').text();
		let bl_adult = $(this).find('td:nth-child(4)').text().replace(",", "");
		let totalseat = $(this).find('td:nth-child(5)').text();
		let leftseat = $(this).find('td:nth-child(6)').text();
		
		let bsidx = $(this).data("bsidx");
		let etimeT = $(this).data("etime");
		let priceT = $(this).data("price");
		
		$("#bsidx").val(bsidx);
		$("#bllevel").val(level);
		$("#comname").val(comname);
		$("#price").val(parseInt(bl_adult));
		$("#stime").val(stime);
		$("#etime").val(etimeT);
		$("#total-seat").val(totalseat);
		
		$("#left-seat").val(leftseat);
		document.frmSchedule.submit();
	});
});

</script>


    
