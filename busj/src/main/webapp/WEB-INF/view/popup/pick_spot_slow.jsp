<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
/*
출/도착지 선택 모달
※ 동작 순서 : 출발지선택 -> 도착지 선택 -> [확인]버튼 클릭 시 출발지(bt_sidx)/도착지(bt_eidx) 값을 s_ticket_step1.jsp파일로 보냄
※ 필요한 기능
 - %터미널명% 검색 (검색 결과 하단에 [터미널명] 버튼으로 노출)
 - 지역별 터미널 리스트 노출 (기본: 전체 / 서울 / 경기도 / 강원도 / 경상북도 / 경상남도)
 	- 해당 지역 클릭 시 그 지역에 있는 터미널만 노출 (일종의 검색)
 	- 터미널 명은 <a>태그 클릭하여 값을 출발지/도착지에 넣어줌
*/
request.setCharacterEncoding("utf-8");
List<TerminalInfo> terminalList = (List<TerminalInfo>)request.getAttribute("terminalList");
String schTField = request.getParameter("schTField");
if (schTField == null || schTField.equals(""))	schTField = "";		// 검색을 하지 않는 경우
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
<form name="schTname">
	<div class="input-group mb-3">
		<input type="text" name="schTField" value="<%=schTField %>" class="form-control focus-none"  placeholder="터미널 이름을 검색하세요.">
		<div class="input-group-append">
			<button class="btn btn-outline-success" type="submit" id="schBtn">검색</button>
		</div>
	</div>
	<hr />
	<div>
		<button type="button" class="btn-success btn-sm">동서울</button>
	</div>	
</form>	
	<hr />
<form name="frmPoint" action="selectSSpot" method="post">	
	<div class="form-row">
	<div class="col-md-6 mb-3">
		<label for="sPointPop">출발지</label>
			<input type="text" class="form-control form-control-lg focus-none active" id="sPointPop" name="sPointPop" required readonly>	<!-- 기본값 focus-none active / 출발지 선택 후 active 삭제 -->
	</div>
	<div class="col-md-6 mb-3">
		<label for="ePointPop">도착지</label>
			<input type="text" class="form-control form-control-lg focus-none" id="ePointPop" name="ePointPop" required readonly>	<!-- 기본값 focus-none / 출발지 선택 후 도착지 active -->
	</div>
	</div>
</form>	
	<div class="row" id="departure">
	<div class="col-2">
		<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">	<!-- id랑 data-target이 같아야 함 -->
			<button class="nav-link active" id="" data-toggle="pill" data-target="#all1" type="button" role="tab">전체</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#seoul1" type="button" role="tab">서울</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gyeonggi1" type="button" role="tab">경기도</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gangwon1" type="button" role="tab">강원도</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gyeongbuk1" type="button" role="tab">경상북도</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gyeongnam1" type="button" role="tab">경상남도</button>
		</div>
	</div>
	<div class="col-10">
		<div class="tab-content" id="v-pills-tabContent">
			<ul class="tab-pane scroll-box2 t-list active" id="all1" role="tabpanel" aria-expanded="true">	<!-- 전체 버튼 -->
<%
if (terminalList.size() > 0) {	// 터미널 목록이 있는경우
	for (int i = 0 ; i < terminalList.size() ; i++) {	// 전체목록
		TerminalInfo ti = terminalList.get(i);	
%>
				<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
%>
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="seoul1" role="tabpanel">	<!-- 서울 버튼 -->
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 서울
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().equals("서울")) { %>
				<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
			</ul>
          	<ul class="tab-pane scroll-box2 t-list" id="gyeonggi1" role="tabpanel">	<!-- 경기도 버튼 -->
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 경기도
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().equals("경기도")) { %>
				<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
          	</ul>
          	<ul class="tab-pane scroll-box2 t-list" id="gangwon1" role="tabpanel">	<!-- 강원도 버튼 -->
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 강원도
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().equals("강원도")) { %>
				<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="gyeongbuk1" role="tabpanel">	<!-- 경상북도 버튼 -->
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 경상북도
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().equals("경상북도")) { %>
			<li><a href="<%=ti.getBt_idx() %>"><%=ti.getBt_name() %></a></li>
<%
		}
	}
%>
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="gyeongnam1" role="tabpanel">	<!-- 경상남도 버튼 -->
<%
	for (int i = 0 ; i < terminalList.size() ; i++) { // 경상남도
		TerminalInfo ti = terminalList.get(i);
		if (ti.getBt_area().equals("경상남도")) { %>
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
		<div class="nav flex-column nav-pills" id="" role="tablist" aria-orientation="vertical">
			<button class="nav-link active" id="" data-toggle="pill" data-target="#all2" type="button" role="tab">전체</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#seoul2" type="button" role="tab">서울</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gyeonggi2" type="button" role="tab">경기도</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gangwon2" type="button" role="tab">강원도</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gyeongbuk2" type="button" role="tab">경상북도</button>
			<button class="nav-link" id="" data-toggle="pill" data-target="#gyeongnam2" type="button" role="tab">경상남도</button>
		</div>
	</div>
	<div class="col-10">
		<div class="tab-content" id="v-pills-tabContent">
			<ul class="tab-pane scroll-box2 t-list active" id="all2" role="tabpanel" aria-expanded="true">
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="seoul2" role="tabpanel">
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="gyeonggi2" role="tabpanel">
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="gangwon2" role="tabpanel">
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="gyeongbuk2" role="tabpanel">
			</ul>
			<ul class="tab-pane scroll-box2 t-list" id="gyeongnam2" role="tabpanel">
			</ul>
		</div>
	</div> 
	</div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	<button type="button" id="btnSubmit" class="btn btn-primary" data-dismiss="modal">확인</button>	<!-- 출발지 / 도착지 value 전달 -->
</div>
<%@ include file="../_inc/foot.jsp" %>

<script>
//각 탭에 데이터를 추가하는 함수
function addTerminalToTab(data, targetTabId) {
	let tabContent = '';
	if (data.length > 0) {
		data.forEach(function (terminal) {
		tabContent += '<li><span onclick="getESpotVal(this);">' + terminal.ename + '</span></li>';
		});
	} else {
		tabContent = '<li>해당 노선 터미널 없음</li>';
	}
	
	$(targetTabId).html(tabContent);
}

$('#departure li a').each(function () {		// ID로 태그 선택
	$(this).on('click', function (event) {	// 각 a태그에 대해 클릭 이벤트를 처리하는 함수 등록
	  
		event.preventDefault();
		$("#sPointPop").val($(this).text());	// a태그의 텍스트 값을 sPointPop(ID)의 값으로 넣어줌
		$("#sPointPop").removeClass("active");	// sPointPop의 active 클래스를 제거(출발지에 값이 들어가면 테두리가 사라짐)
		$("#ePointPop").addClass("active");		// ePointPop에 active 클래스를 추가(도착지를 고를 수 있게 테두리 지정)

		var btsidx = parseInt($(this).attr('href'), 10); // a 태그의 href 속성으로 터미널 인덱스 가져오기

		$.ajax({
			url: "sLineSch",					// 맵핑값
			type: "GET",
			data: { btsidx : btsidx },		// 출발지 인덱스
			dataType: "json",				// "json" - JSON 형식의 데이터로 배열, 객체를 포함하는 문자열
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			success: function (data) {
				$("#departure").hide();		// 출발지 터미널 리스트 숨김
				$("#arrival").show();		// 도착지 터미널 리스트 표시
        	// 필요한 데이터를 필터링하여 함수 호출
	        addTerminalToTab(data, '#all2');
	        addTerminalToTab(data.filter(t => t.earea === '서울'), '#seoul2');
	        addTerminalToTab(data.filter(t => t.earea === '경기도'), '#gyeonggi2');
	        addTerminalToTab(data.filter(t => t.earea === '강원도'), '#gangwon2');
	        addTerminalToTab(data.filter(t => t.earea === '경상북도'), '#gyeongbuk2');
	        addTerminalToTab(data.filter(t => t.earea === '경상남도'), '#gyeongnam2');
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
	$("#btsname").val(($("#sPointPop").val()));
	$("#btename").val(($("#ePointPop").val()));
	$('#ViewModal').modal('hide');
	
});
</script>
