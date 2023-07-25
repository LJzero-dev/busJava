<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
List<TerminalInfo> terminalList = (List<TerminalInfo>)request.getAttribute("terminalList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>BUSJAVA</title>
	<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/resources/images/favicon.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/ionicons/css/ionicons.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/flaticon/font/flaticon.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fonts/fontawesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-datepicker.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/select2.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpers.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
</head>
<body>
<div class="modal-header">
	<h5 class="modal-title" id="exampleModalLabel">출/도착지 선택</h5>
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	  <span aria-hidden="true">&times;</span>
	</button>
</div>
<div class="modal-body">
<form name="frmSch">
<div class="input-group mb-3">
	<input type="text" name="schTField" class="form-control focus-none"  placeholder="터미널 이름을 검색하세요.">
	<div class="input-group-append"><button class="btn btn-outline-success" type="button" id="schBtn">검색</button></div>
</div>
</form>
<hr />
    <div>
	    <button type="button" class="btn-success btn-sm">동서울</button>
	    <button type="button" class="btn-success btn-sm">동서울</button>
	    <button type="button" class="btn-success btn-sm">동서울</button>
	    <button type="button" class="btn-success btn-sm">동서울</button>
    </div>
<hr />
    <form name="frmPoint">
      <div class="form-row">
        <div class="col-md-6 mb-3">
          <label for="sPointPop">출발지</label>
          <input type="text" class="form-control form-control-lg focus-none active" id="sPointPop" required readonly>
        </div>
        <div class="col-md-6 mb-3">
          <label for="ePointPop">도착지</label>
          <input type="text" class="form-control form-control-lg focus-none" id="ePointPop" required readonly>
        </div>
      </div>
    </form>
    <div class="row">
      <div class="col-2">
        <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
          <button class="nav-link active" id="v-pills-home-tab" data-toggle="pill" data-target="#all" type="button" role="tab">전체</button>
          <button class="nav-link" id="v-pills-profile-tab" data-toggle="pill" data-target="#seoulg" type="button" role="tab">서울/경기</button>
          <button class="nav-link" id="v-pills-messages-tab" data-toggle="pill" data-target="#gang" type="button" role="tab">강원</button>
          <button class="nav-link" id="v-pills-settings-tab" data-toggle="pill" data-target="#gyong" type="button" role="tab">경상</button>
        </div>
      </div>
      <div class="col-10">
        <div class="tab-content" id="v-pills-tabContent">
			<ul class="tab-pane scroll-box t-list active t-list" id="all" role="tabpanel" aria-expanded="true">
<%
	if (terminalList.size() > 0) {	// 터미널 목록이 있는경우
		for (int i = 0 ; i < terminalList.size() ; i++) {	// 전체목록
			TerminalInfo ti = terminalList.get(i);	
%>
				<li><a href="lineSch?btidx=<%=ti.getBt_idx() %>" onclick="pickSpot('<%=ti.getBt_name()%>')"><%=ti.getBt_name() %></a></li>
<%
		}
%>
			</ul>
			<ul class="tab-pane scroll-box t-list" id="seoulg" role="tabpanel">
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 서울경기
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().startsWith("서울") || ti.getBt_area().startsWith("경기")) { %>
			<li><a href="<%=ti.getBt_idx() %>" onclick=""><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
			</ul>
          	<ul class="tab-pane scroll-box t-list" id="gang" role="tabpanel">
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 강원
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().startsWith("강원")) { %>
			<li><a href="<%=ti.getBt_idx() %>" onclick=""><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
          	</ul>
          	<ul class="tab-pane scroll-box t-list" id="gyong" role="tabpanel">
          	
          	</ul>
          
		</div>
<%
	}
%>

			

        </div> 
      </div>
</div>
</div>
<div class="modal-footer">
  <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
  <button type="button" class="btn btn-primary">확인</button>
</div>
<script>
	const pickSpot = function(btname) {
		$("#sPointPop").val(btname);
		$("#sPointPop").removeClass("active");
		$("#ePointPop").addClass("active");
	}
</script>
<%@ include file="../_inc/foot.jsp" %>