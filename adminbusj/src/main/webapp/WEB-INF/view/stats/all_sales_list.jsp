<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.time.*" %>
<%
request.setCharacterEncoding("utf-8");
List<SalesInfo> salesList = (List<SalesInfo>)session.getAttribute("salesList");
LocalDate nowDate = LocalDate.now();
System.out.println(nowDate);
System.out.println(nowDate.minusDays(7));

int realTotal = 0;
%>
<style>
.changePointer {
      cursor: pointer;
}

h4.sub_title {font-size: 20px; margin-top: 10px; margin-left: 10px;}
</style>
<script>


function makeCtgr() {
// 검색폼의 조건들을 쿼리스트링 sch의 값으로 만듦
	var frm = document.frmSch;	var sch = "";
	
	// 브랜드 조건
	var arr = frm.schctgr;	// brand라는 이름의 컨트롤들을 배열로 받아옴
	var isFirst = true;		// brand 체크박스들 중 첫번째로 선택한 체크박스인지 여부를 저장
	for (var i = 0; i < arr.length; i++) {
		if (arr[i].checked) {
			if(isFirst) {	// 첫번째로 선택한 체크박스 이면
				isFirst = false;
				sch += arr[i].value;
			} else {
				sch += ":" + arr[i].value;
			}
		}
	}
	
	document.frmSch.hiddenCtgr.value = sch;
	document.frmSch.submit();
}
</script>
<div class="page-wrapper">
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">매출 관리</h3>
		</div>
	</div>
	<div class="row">
    <div class="col-lg-12">
        <div class="card">
        <h4 class="sub_title">총 매출 금액 : <span id="realTotal"></span></h4>
        <form name="frmSch">
        <input type="hidden" id="hiddenCtgr" name="hiddenCtgr" value="" />
        <input type="hidden" id="sDate1-1" value="" />
            <table class="table table-sm custom">
                <colgroup>
                    <col width="20%">
                    <col width="*">
                </colgroup>
                <tbody>
                <tr>
                        <th scope="row" class="text-center bg-gray align-middle">버스구분</th>
                        <td class="text-left">
                            <div class="d-flex">
                                <select class="form-control w-auto" name="isview" id="">
                                    <option value="">전체</option>
									<option value="">고속</option>
									<option value="">시외</option>
                                </select>
                            </div>
                        </td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">기간</th>
                        <td class="text-left">
                            <div class="d-flex align-center">
                                <div class="form-group mb-0 mr-1">
                                	<input type="date" id="sDate1-2" class="form-control" value="<%=nowDate.minusDays(7) %>" onchange="handler(event)">
                                </div>
                                <span style="line-height: 2.2;"> ~ </span>
                                <div class="form-group mb-0 ml-1">
                                    <input type="date" id="eDate" class="form-control" value="<%=nowDate%>">
                                </div>
                            </div>
                        </td> 
                    </tr>
                </tbody>
            </table>
            <div class="d-flex justify-content-center">
            <button type="button" class="btn waves-effect waves-light btn-secondary mb-2" onclick="makeCtgr();">검색</button>
            </div>
            </form>
        </div> 
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
        <form name="frm">
        <input type="hidden" name="chk" value="" />
            <table id="table" class="table text-center mb-0">
                <colgroup>
                    <col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="8%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="*">
                </colgroup>
                <thead class="bg-primary text-white">
                <tr>
                    <th>버스구분</th>
                    <th>출발지</th>
                    <th>도착지</th>
                    <th>운영횟수</th>
                    <th>카드</th>
                    <th>무통장 입금</th>
                    <th>간편 결제</th>
                    <th>매출 합계</th>
                </tr>
            	</thead>
				<tbody class="border border-primary">
<% if (salesList.size() > 0) {
	for (SalesInfo si : salesList) {
		int salesTotal = si.getCardP() + si.getBankP() + si.getEasyP();
		realTotal += salesTotal; 
%>	
					<tr>
	                    <td><%=si.getBl_type()%></td>
	                    <td><%=si.getStart_spot()%></td>
	                    <td><%=si.getEnd_spot() %></td>
	                    <td><%=si.getCount_schedule() %></td>
	                    <td><%=String.format("%,d",si.getCardP()) %></td>
	                    <td><%=String.format("%,d",si.getBankP()) %></td>
	                    <td><%=String.format("%,d",si.getEasyP()) %></td>
	                    <td><%=String.format("%,d",salesTotal) %></td>
	                </tr>

<% } %>

					
<% } else { %>
					<tr>
	                    <td colspan="8">매출내역이 존재하지 않습니다.</td>
	                </tr>
<% } %>
	           	</tbody>
            </table>
            
        </form>
        </div> 
    </div>
</div>
</div>
</div>


<div class="modal fade" id="AddLine" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
<%@ include file="../_inc/foot.jsp" %>
<script>
$(document).ready(function() {
	let total_period = <%=realTotal%>
	$("#realTotal").text(total_period.toLocaleString());
	
// 	$("#sDate1-2").datepicker({
// 		autoclose: true,
// 		startDate: "0d",
		
// 		endDate: "+30d",
// 		language: "kr",
// 		showMonthAfterYear: true,
// 		weekStart: 1,
// 		}).datepicker("setDate",'now')
// 		.on('changeDate', function(e) {
// 			console.log(1);
//  			$("#sDate1-1").val($(this).val());

// 	});
	
});

function handler(e){
	$("#sDate1-1").val(e.target.value);
	console.log($("#sDate1-1").val());
}
</script>