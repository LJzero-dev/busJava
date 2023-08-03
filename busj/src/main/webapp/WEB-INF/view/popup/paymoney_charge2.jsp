<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
      <h5 class="modal-title" id="exampleModalLabel">페이머니 충전</h5>
    </div>
    <div class="modal-body">
      <form name="frm" action="" method="">
        <div class="circle-complete">
          <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#ffffff" class="bi bi-check2" viewBox="0 0 16 16">
            <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
          </svg>
        </div>
        <p class="text-center">충전 완료</p>
        <img src="">
        <div class="mt-2 d-flex justify-content-between">
          <span>결제 금액</span><span id="resultMoney">0</span>
        </div>
        <div class="d-flex justify-content-between">
          <span>추가 적립(10%)</span><span id="resultBonus"></span>
        </div>
        <hr class="mt-0"/>
        <div class="mt-2 d-flex justify-content-between">
          <p class="h6">페이머니</p><p class="h6" id="resultTotal"></p>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" id="lastBtn" class="btn btn-primary btn-block" data-dismiss="modal">확인</button>
    </div>

<%@ include file="../_inc/foot.jsp" %>
<script>
$("#lastBtn").click(function() {
	location.reload();
});
</script>