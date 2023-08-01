<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<%@ page import="java.text.*" %>
<%@ page import="vo.*" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<%
request.setCharacterEncoding("utf-8");
BookInfo bi = (BookInfo)request.getAttribute("bi");
String args = (String)request.getAttribute("args");

String busType;
switch (bi.getBl_type()) {
    case "b":
    	busType = "고속";
        break;
    case "c":
    	busType = "시외";
        break;
    default:
    	busType = "고속/시외";
}

NumberFormat nf = NumberFormat.getInstance();
String formattedNumber = "";

if (bi.getTatal_cr_pay() > 1000) {
    nf = NumberFormat.getInstance();
    formattedNumber = nf.format(bi.getTatal_cr_pay());
    // 이제 formattedNumber는 세 자리마다 쉼표가 찍힌 숫자를 문자열 형태로 저장합니다.
}

%>

<section class="probootstrap_section">
예매정보
<table class="table" class="thead-light">
	<colgroup>
		<col width="25%">
		<col width="25%">
		<col width="25%">
		<col width="25%">
	</colgroup>
	<tr>
		<th scope="col">예매번호</th><td><%=bi.getRi_idx() %></td>
		<th scope="col">버스구분</th><td><%=busType %></td>
	</tr>
	<tr>
		<th scope="col">출발지</th><td><%=bi.getBt1_sidx() %></td>
		<th scope="col">도착지</th><td><%=bi.getBt2_eidx() %></td>
	</tr>
	<tr>
		<th scope="col">출발일자</th><td><%=bi.getRi_sday() %></td>
		<th scope="col">출발시간</th><td><%=bi.getBs_stime() %></td>
	</tr>
	<tr>
		<th scope="col">버스등급</th><td><%=bi.getBi_level() %></td>
		<th scope="col">버스회사</th><td><%=bi.getBc_name() %></td>
	</tr>
	<tr>
		<th scope="col">매수</th><td>어른 <%=bi.getRi_acnt() %>,
		청소년 <%=bi.getRi_scnt() %>,
		아동 <%=bi.getRi_ccnt() %></td>
		<th scope="col">좌석</th><td>
<% 
StringBuilder seats = new StringBuilder();
if (bi.getBusSeatList().size() > 0) {
  for (BusSeatList bs : bi.getBusSeatList()) {    
    if (seats.length() != 0) {
      seats.append(",");
    }
    seats.append(bs.getSi_seat());
  } 
}    
%>       
<%=seats.toString() %>
</td>
	</tr>
	<tr>
		<th scope="col">상태</th><td><%=bi.getRi_status() %></td>
		<th scope="col">환불금액</th>
<% if (!bi.getRi_status().equals("예매취소")) { %>
		<td>-</td>
<% } else { 
	String returnCount = formattedNumber.replace(",", "");  // 콤마 제거
	Double Count = Double.parseDouble(returnCount);  // 숫자로 변환 
	Double tmp = Count * 0.8;
	if (tmp > 1000) {
	    NumberFormat nft = NumberFormat.getInstance();
	    String result = nft.format(tmp);  // tmp 값을 세 자리마다 쉼표가 찍힌 문자열로 변환 	%>
	<!-- Double returnCount = Double.parseDouble(formattedNumber);  -->
		<td><%=result %></td>
<% }
}%>
	</tr>
</table>
<br />
<br />
결제정보
<table class="table" class="thead-light">
	<colgroup>
		<col width="25%">
		<col width="25%">
		<col width="25%">
		<col width="25%">
	</colgroup>
	<tr>
		<th scope="col">결제일자</th><td><%=bi.getCr_date().substring(0,11) %></td>
		<th scope="col">결제시간</th><td><%=bi.getCr_date().substring(11,16) %></td>
	</tr>
	<tr>
		<th scope="col">결제수단</th><td><%=bi.getCr_payment() %></td>
		<th scope="col">결제금액</th><td id="pay"><%=formattedNumber %>원</td>
	</tr>
</table>
<% if (!bi.getRi_status().equals("예매취소")) { %>
      <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#ViewModal" onclick="openModal('<%=bi.getRi_idx() %>');">예매취소</button>
      <button type="submit" class="btn btn-primary" onclick="history.back()">확인</button>
<% } else { %>
 	  <button type="submit" class="btn btn-primary" onclick="history.back()">확인</button>
<% } %>
      
<div class="modal fade" id="ViewModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
</section>
<script>
function openModal(riidx) {
	$('#ViewModal .modal-content').load("/busj/cancel?riidx=" + riidx);
	$('#ViewModal').modal();
  }
</script>


<%@ include file="../_inc/foot.jsp"%>
