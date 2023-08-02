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
        <label for="1" class="font-weight-bold">충전할 페이머니</label>
        <input type="text" class="form-control form-control-lg" id="chagePay" required readonly>
        <div class="mt-2">
        <input type="button" class="btn-success btn-sm" id="" onclick="changePay(this.value);" value="200,000">
        <input type="button" class="btn-success btn-sm" id="" onclick="changePay(this.value);" value="300,000">
        <input type="button" class="btn-success btn-sm" id="" onclick="changePay(this.value);" value="500,000">
        </div>
        <div class="mt-2 d-flex justify-content-between">
          <span>결제 금액</span><span id="payment"></span>
        </div>
        <div class="d-flex justify-content-between">
          <span>추가 적립(10%)</span><span id="bonus"></span>
        </div>
        <hr class="mt-0"/>
        <div class="mt-2 d-flex justify-content-between">
          <p class="h6">충전 예정 페이머니</p><p class="h6" id="point"></p>
        </div>
        <p class="font-weight-bold mt-2 mb-1">결제 방법</p>
        <div>
          <div class="form-check custom ml-0">
            <input class="form-check-input" type="radio" name="payment" id="card" value="card" checked />
            <label class="form-check-label" for="card">카드</label>
          </div>
          <div class="form-check custom">
            <input class="form-check-input" type="radio" name="payment" id="bankbook" value="bankbook" />
            <label class="form-check-label" for="bankbook">무통장입금</label>
          </div>
          <div class="form-check custom">
            <input class="form-check-input" type="radio" name="payment" id="simplepay" value="simplepay" />
            <label class="form-check-label" for="simplepay">간편결제</label>
          </div>
        </div>
        <div class="form-check custom ml-0">
          <input class="form-check-input" type="checkbox" id="agreeP">
          <label class="form-check-label" for="agreeP">
            <span class="text-danger">[필수]</span> 상품, 가격, 결제 전 주의사항 확인
          </label>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      <button type="button" id="submitBtnP" class="btn btn-primary">충전</button>
    </div>

<%@ include file="../_inc/foot.jsp" %>
<script>
	function openModal2(chargePmoney) {
		// 팝업 내용이 모두 로드된후 값이 보이도록 콜백함수 지정
		$('#ViewModal .modal-content').load("/busj/pmoneyCharge2", function() {
			$("#resultMoney").text(chargePmoney.toLocaleString());
			$("#resultBonus").text((chargePmoney*0.1).toLocaleString());
			$("#resultTotal").text((chargePmoney+(chargePmoney*0.1)).toLocaleString());
		});
		$('#ViewModal').modal();

	  }
	
	function changePay(money) {
		const frm = document.frm;
		const arr = money.split(',');
		const num = arr[0] + arr[1];
		const sales = Number(num) * 0.1;
		const totalPoint = Number(num) + Number(sales);
		
		frm.chagePay.value = money;
		
		const payment = document.getElementById("payment");
		const bonus = document.getElementById("bonus");
		const point = document.getElementById("point");
		
		payment.innerHTML = money;
		bonus.innerHTML = sales.toLocaleString();
		point.innerHTML = totalPoint.toLocaleString();
	}
	
	$(document).ready(function() {
		let agreeP = document.getElementById("agreeP");
	});
	
	
	
	$("#submitBtnP").on('click', function() {
		let chargePmoney;	// 충전 금액
		let payment = $("input[type=radio][name=payment]:checked").val();	// 충전방식
		
		if ($("#chagePay").val() == "") {
			alert("충전할 페이머니를 선택해 주세요.");
			return;
		} else {
			chargePmoney = parseInt($("#chagePay").val().replace(",", ""));
		}

		
		if (!agreeP.checked) {
			alert("약관에 동의해 주세요.");
			return;
		}
		
		$.ajax({
		      url: "chargePmoney",
		      type: "POST",
		      data: {
		        chargePmoney: chargePmoney,
		        payment: payment
		      },
		      dataType: "json",
		      success: function(data) {
		    	  console.log("충전 성공");
		      },
		      error: function(xhr, status, error) {
		    	  alert("페이머니 충전에 실패했습니다.");
		      }
		    });
		
		openModal2(chargePmoney, point);
		
	});
</script>