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
		<input type="hidden" name="lineNum" value="" />
      <div class="form-row">
        <div class="col-md-6 mb-3">
          <label for="sPointPop">출발지</label>
          <input type="text" class="form-control form-control-lg focus-none active" id="sPointPop" name="sPointPop" readonly>
        </div>
        <div class="col-md-6 mb-3">
          <label for="ePointPop">도착지</label>
          <input type="text" class="form-control form-control-lg focus-none" id="ePointPop" name="ePointPop" readonly>
        </div>
      </div>
    </form>
    <div class="row" id="go">
      <div class="col-2">
        <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
          <button class="nav-link active" id="v-pills-home-tab" data-toggle="pill" data-target="#all1" type="button" role="tab">전체</button>
          <button class="nav-link" id="v-pills-profile-tab" data-toggle="pill" data-target="#seoulg1" type="button" role="tab">서울/경기</button>
          <button class="nav-link" id="v-pills-messages-tab" data-toggle="pill" data-target="#gang1" type="button" role="tab">강원</button>
          <button class="nav-link" id="v-pills-settings-tab" data-toggle="pill" data-target="#gyong1" type="button" role="tab">경상</button>
        </div>
      </div>
      <div class="col-10">
        <div class="tab-content" id="v-pills-tabContent">
			<ul class="tab-pane scroll-box t-list active" id="all1" role="tabpanel" aria-expanded="true">
<%
	if (terminalList.size() > 0) {	// 터미널 목록이 있는경우
		for (int i = 0 ; i < terminalList.size() ; i++) {	// 전체목록
			TerminalInfo ti = terminalList.get(i);	
%>
				<li><a href="<%=ti.getBt_idx() %>" ><%=ti.getBt_name() %></a></li>
<%
		}
%>
			</ul>
			<ul class="tab-pane scroll-box t-list" id="seoulg1" role="tabpanel">
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 서울경기
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().startsWith("서울") || ti.getBt_area().startsWith("경기")) { %>
			<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
			</ul>
          	<ul class="tab-pane scroll-box t-list" id="gang1" role="tabpanel">
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 강원
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().startsWith("강원")) { %>
			<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
          	</ul>
          	<ul class="tab-pane scroll-box t-list" id="gyong1" role="tabpanel">
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 경상
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().startsWith("경상")) { %>
			<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
          	</ul>
		</div>
<%
	}
%>
		</div> 
	</div>
	    <div class="row" id="arrival" style="display:none;">
      <div class="col-2">
        <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
          <button class="nav-link active" id="v-pills-home-tab" data-toggle="pill" data-target="#all2" type="button" role="tab">전체</button>
          <button class="nav-link" id="v-pills-profile-tab" data-toggle="pill" data-target="#seoulg2" type="button" role="tab">서울/경기</button>
          <button class="nav-link" id="v-pills-messages-tab" data-toggle="pill" data-target="#gang2" type="button" role="tab">강원</button>
          <button class="nav-link" id="v-pills-settings-tab" data-toggle="pill" data-target="#gyong2" type="button" role="tab">경상</button>
        </div>
      </div>
      <div class="col-10">
        <div class="tab-content" id="v-pills-tabContent">
			<ul class="tab-pane scroll-box t-list active" id="all2" role="tabpanel" aria-expanded="true">
			</ul>
			<ul class="tab-pane scroll-box t-list" id="seoulg2" role="tabpanel">
			</ul>
          	<ul class="tab-pane scroll-box t-list" id="gang2" role="tabpanel">
          	</ul>
          	<ul class="tab-pane scroll-box t-list" id="gyong2" role="tabpanel">
          	</ul>
		</div>
		</div> 
	</div>
</div>
</div>
<div class="modal-footer">
  <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
  <button type="button" id="btnSubmit" class="btn btn-primary" data-dismiss="modal">확인</button>
</div>

<%@ include file="../_inc/foot.jsp" %>
	<script>
	// 각 탭에 데이터를 추가하는 함수
	function addTerminalToTab(data, targetTabId) {
	  let tabContent = '';
	  if (data.length > 0) {
	    data.forEach(function (terminal) {
	      tabContent += '<li><span onclick="getESpotVal(this);">' + terminal.ename + '</span></li>';
	    });
	  } else {
	    tabContent = '<li>터미널 없음</li>';
	  }
	  $(targetTabId).html(tabContent);
	}
	
	$('#go li a').each(function () {
	  $(this).on('click', function (event) {
		  
	    event.preventDefault();
	    $("#sPointPop").val($(this).text());
	    $("#sPointPop").removeClass("active");
	    $("#ePointPop").addClass("active");
	    
	    
	
	    var btsidx = parseInt($(this).attr('href'), 10); // a 태그의 href 속성으로 터미널 인덱스 가져오기
	
	    $.ajax({
	      url: "lineSch",
	      type: "GET",
	      data: { btsidx: btsidx },
	      dataType: "json",
	      contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	      success: function (data) {
			$("#go").hide();
	        $("#arrival").show();
	
	        // 필요한 데이터를 필터링하여 함수 호출
	        addTerminalToTab(data, '#all2');
	        addTerminalToTab(data.filter(t => t.earea === '서울' || t.earea === '경기도'), '#seoulg2');
	        addTerminalToTab(data.filter(t => t.earea === '강원도'), '#gang2');
	        addTerminalToTab(data.filter(t => t.earea === '경상남도' || t.earea === '경상북도'), '#gyong2');
	      },
	      error: function (xhr, status, error) {
	        console.error(error);
	      }
	    });
	  });
	});
	
	
	function getESpotVal(span)  {
		$("#ePointPop").val(span.innerHTML);
		$("#ePointPop").removeClass("active");
		$("#arrival").hide();
	}
	
	
	$("#btnSubmit").on('click', function() {
		if (($("#sPointPop").val() == "") || ($("#ePointPop").val() == "")) {
			alert("출발지와 도착지를 선택해주세요.");
			return;
		}
		
		$("#sPoint").val(($("#sPointPop").val()));
		$("#ePoint").val(($("#ePointPop").val()));
		let sPoint = $("#sPoint").val();
		let ePoint = $("#ePoint").val();
		
		$.ajax({
		      url: "getLineNum",
		      type: "POST",
		      data: {
		        spoint: sPoint,
		        epoint: ePoint
		      },
		      dataType: "json",
		      success: function(data) {
		        $("#lineNum").val(data);
		      },
		      error: function(xhr, status, error) {
		        console.error(error);
		      }
		    });
		$('#ViewModal').modal('hide');
		
	});

</script>