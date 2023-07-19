<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<title>BUSJAVA</title>

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
<nav class="navbar navbar-expand-lg navbar-dark probootstrap_navbar" id="probootstrap-navbar">
	<div class="container">
		<h1><a class="navbar-brand" href="/"><img src="${pageContext.request.contextPath}/resources/images/logo.png" /></a></h1>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#probootstrap-menu" aria-controls="probootstrap-menu" aria-expanded="false" aria-label="Toggle navigation">
		<span><i class="ion-navicon"></i></span>
       </button>
       <div class="collapse navbar-collapse justify-content-between" id="probootstrap-menu">
         <ul class="navbar-nav">
           <li class="nav-item active"><a class="nav-link" href="index.html">버스 예매</a></li>
           <li class="nav-item"><a class="nav-link" href="city-guides.html">예매 내역</a></li>
           <li class="nav-item"><a class="nav-link" href="services.html">운행 정보</a></li>
           <li class="nav-item"><a class="nav-link" href="travel.html">추천 여행지</a></li>
           <li class="nav-item"><a class="nav-link" href="contact.html">페이머니 구매</a></li>
           <li class="nav-item"><a class="nav-link" href="contact.html">고객지원</a></li>
         </ul>
         <div class="d-flex align-items-center">
           <button class="btn btn-primary text-800 me-2" type="button">로그인</button>
           <button class="btn order-0" type="submit"><span class="text-primary">회원가입</span></button>
         </div>
         <!-- 로그인 상태 -->
         <!-- <div class="d-flex align-items-center">
           <p class="mb-0">test님</p>
           <button class="btn btn-primary text-800 me-2" type="button">로그아웃</button>
           <button class="btn order-0" type="submit"><span class="text-primary">마이페이지</span></button>
         </div> -->
		</div>
	</div>
</nav>