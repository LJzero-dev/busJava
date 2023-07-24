<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
List<TerminalInfo> terminalList = (List<TerminalInfo>)request.getAttribute("terminalList");
%>
<script>
function openModal(area) {
	$('#AddTerminal .modal-content').load("/adminbusj/terminalAdd?area=" + area);
	$('#AddTerminal').modal();
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
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">고속버스 터미널 관리</h3>
		</div>
	</div>
</div> 
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="d-flex justify-content-between p-3 align-items-center">
					<h4 class="text-dark">서울</h4>
					<button type="button" class="btn waves-effect waves-light btn-primary" id="seoul" value="서울" onclick="openModal(this.value);">추가</button>
				</div>
				<ul class="custom-list">
<%
for (TerminalInfo terminal : terminalList) {
	if (terminal.getBt_area().equals("서울")) {
%>
					<li><a href="javascript:void(0);"><%=terminal.getBt_name() %></a></li>
<%
	}
}
%>
				</ul>
			</div>
			<div class="card">
				<div class="d-flex justify-content-between p-3 align-items-center">
					<h4 class="text-dark">경기도</h4>
					<button type="button" class="btn waves-effect waves-light btn-primary" id="seoul" value="경기도" onclick="openModal(this.value);">추가</button>
				</div>
				<ul class="custom-list">
<%
for (TerminalInfo terminal : terminalList) {
	if (terminal.getBt_area().equals("경기도")) {
%>
					<li><a href="javascript:void(0);"><%=terminal.getBt_name() %></a></li>
<%
	}
}
%>
				</ul>
			</div>
				<div class="card">
				<div class="d-flex justify-content-between p-3 align-items-center">
					<h4 class="text-dark">강원도</h4>
					<button type="button" class="btn waves-effect waves-light btn-primary" value="강원도" onclick="openModal(this.value);">추가</button>
				</div>
				<ul class="custom-list">
<%
for (TerminalInfo terminal : terminalList) {
	if (terminal.getBt_area().equals("강원도")) {
%>
					<li><a href="javascript:void(0);"><%=terminal.getBt_name() %></a></li>
<%
	}
}
%>
				</ul>
			</div>
			<div class="card">
				<div class="d-flex justify-content-between p-3 align-items-center">
					<h4 class="text-dark">경상북도</h4>
					<button type="button" class="btn waves-effect waves-light btn-primary" value="경상북도" onclick="openModal(this.value);">추가</button>
				</div>
				<ul class="custom-list">
<%
for (TerminalInfo terminal : terminalList) {
	if (terminal.getBt_area().equals("경상북도")) {
%>
					<li><a href="javascript:void(0);"><%=terminal.getBt_name() %></a></li>
<%
	}
}
%>
				</ul>
			</div>
			<div class="card">
				<div class="d-flex justify-content-between p-3 align-items-center">
					<h4 class="text-dark">경상남도</h4>
					<button type="button" class="btn waves-effect waves-light btn-primary" value="경상남도" onclick="openModal(this.value);">추가</button>
				</div>
				<ul class="custom-list">
<%
for (TerminalInfo terminal : terminalList) {
	if (terminal.getBt_area().equals("경상남도")) {
%>
					<li><a href="javascript:void(0);"><%=terminal.getBt_name() %></a></li>
<%
	}
}
%>
				</ul>
			</div>
		</div>
	</div>
</div>
</div>
<div class="modal fade" id="AddTerminal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>


</section>
<%@ include file="../_inc/foot.jsp" %>