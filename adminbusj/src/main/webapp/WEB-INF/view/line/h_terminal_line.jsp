<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

List<BusLineInfo> busLineList = (List<BusLineInfo>)request.getAttribute("busLineList");
%>
<script>
function delLine(lineNum) {
	var bt_idx = <%=request.getParameter("bt_idx") %>;
	var bt_name = "<%=request.getParameter("bt_name") %>";
	if(confirm("해당 노선을 정말 삭제하시겠습니까?\n삭제 후 복구 불가능합니다.")){
		location.href="LineDel?bt_idx=" + bt_idx + "&bt_name=" + bt_name + "&lineNum=" + lineNum;
	}
}
</script>
<body>
<section class="probootstrap_section">
<div class="page-wrapper">     
<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
    </div>
</div>
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1"><%=request.getParameter("bt_name") %>고속버스 터미널 시간표 관리</h3>
		</div>
	</div>
</div> 
<div class="container-fluid">

<% for (BusLineInfo bl : busLineList) { %>
	<div class="row">
		<div class="col-lg-12">
		<div class="d-flex justify-content-between p-1 align-items-center">
			<p class="h3 text-primary"><%=bl.getBt_name() %>고속버스터미널</p>
			<div class="d-flex justify-content-between float_right">
			<button type="button" class="btn float-right btn-outline-danger btn-lg mr-1" id="bl_idx" 
			value="<%=bl.getBl_idx() %>" onclick="delLine(this.value);">노선삭제</button>
			<button type="button" class="btn waves-effect waves-light btn-primary btn-lg" id="seoul" value="<%=bl.getBl_idx() %>"
			 onclick="">추가</button>
			</div>		
		</div>
		<div class="card">
		<table class="table text-center mb-0">
			<colgroup>
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
			</colgroup>
            <thead class="bg-primary text-white">
                <tr>
                    <th>출발시간</th>
                    <th>도착시간</th>
                    <th>회사명</th>
                    <th>등급</th>
                    <th>성인요금</th>
                    <th>청소년요금</th>
                    <th>아동요금</th>
                    <th>수정/삭제</th>
                </tr>
            </thead>
<% 
	if (bl.getBusScheduleInfo().size() > 0) {
		for (BusScheduleInfo bs : bl.getBusScheduleInfo()) {
			
%>
            
            <tbody class="border border-primary">
                <tr>
                    <td><%=bs.getBs_stime() %></td>
                    <td><%=bs.getBs_etime() %></td>
                    <td><%=bs.getBc_name() %></td>
                    <td><%=bs.getBi_level() %></td>
                    <td><%=bl.getBl_adult() %></td>
                    <td><%=Math.round(bl.getBl_adult() * 0.8) %></td>
                    <td><%=Math.round(bl.getBl_adult() * 0.5) %></td>
                    <td>수정, 삭제</td>
                </tr>
            </tbody>
<%
		} 
	} else {
%>
			<tbody class="border border-primary">
            	<tr>
            		<td colspan="8">운행중인 시간표가 없습니다.</td>
            	</tr>
            </tbody>
<%	} %>
        </table>
		</div>
		</div>
	</div>
<% } %>
	
</div>
</div>
<div class="modal fade" id="AddTerminalLine" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>

</section>
<%@ include file="../_inc/foot.jsp" %>