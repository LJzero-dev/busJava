<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>BUSJAVA</title>
		<meta name="description" content="Free Bootstrap 4 Theme by ProBootstrap.com">
		<meta name="keywords" content="free website templates, free bootstrap themes, free template, free bootstrap, free website template">

		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
    <link rel="stylesheet" href="assets/fonts/ionicons/css/ionicons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">
    
    <link rel="stylesheet" href="assets/fonts/flaticon/font/flaticon.css">

    <link rel="stylesheet" href="assets/fonts/fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/select2.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/helpers.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">


	</head>
<script>
function areaChange() {
	
}
</script>
	<body>
    <div class="modal-header">
      <h5 class="modal-title" id="exampleModalLabel">노선 등록</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="modal-body">
      <table class="table text-center">
        <colgroup>
          <col width="25%">
          <col width="*">
        </colgroup>
        <tbody>
          <tr>
            <th>출발지</th>
            <td class="text-left"><%=request.getParameter("bt_name") %></td>
          </tr>
          <tr>
            <th>도착지</th>
            <td class="text-left">
            <div class="form-group pl-0">
                <select id="inputState" class="form-control select-size mr-5" onchange="areaChange(this.value);">
                  <option value="">지역</option>
                  <option>서울</option>
                  <option>경기도</option>
                  <option>강원도</option>
                  <option>경상북도</option>
                  <option>경상남도</option>
                </select>
                <select id="inputState" class="form-control select-size">
                  <option value="">터미널</option>
                  <option></option>
                </select>
            </div>
            </td>
          </tr>
          <tr>
            <th>성인 요금</th>
            <td>
              <input type="text" class="form-control" id="validationServer01" required>
            </td>
          </tr>
          <tr>
            <th>청소년 요금</th>
            <td>
              <input type="text" class="form-control" id="validationServer01" readonly>
            </td>
          </tr>
          <tr>
            <th>아동 요금</th>
            <td>
              <input type="text" class="form-control" id="validationServer01" readonly>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      <button type="button" class="btn btn-primary">확인</button>
    </div>
	</body>
</html>