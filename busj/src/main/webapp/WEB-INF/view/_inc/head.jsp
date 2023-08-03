<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
boolean isLogin = false;
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
if (loginInfo != null)	isLogin = true;
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
<nav class="navbar navbar-expand-lg navbar-dark probootstrap_navbar" id="probootstrap-navbar">
<div class="container">
<h1><a class="navbar-brand" href="/busj"><img src="${pageContext.request.contextPath}/resources/images/logo.png" /></a></h1>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#probootstrap-menu" aria-controls="probootstrap-menu" aria-expanded="false" aria-label="Toggle navigation">
	<span><i class="ion-navicon"></i></span>
	</button>
	<div class="collapse navbar-collapse justify-content-between" id="probootstrap-menu">
		<ul class="navbar-nav">
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">버스예매</a>
        	<div class="dropdown-menu">
				<a class="dropdown-item" href="hTicketingStep01">고속버스 예매</a>
				<a class="dropdown-item" href="sTicketingStep01">시외버스 예매</a>
			</div>
			</li>
			<li class="nav-item"><a class="nav-link" href="booking">예매 내역</a></li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">운행정보</a>
        	<div class="dropdown-menu">
				<a class="dropdown-item" href="schedule">시간표 조회</a>
				<a class="dropdown-item" href="arrivaltime">도착시간 안내</a>
			</div>
			</li>
			<li class="nav-item"><a class="nav-link" href="recommendTrip">추천 여행지</a></li>
			<li class="nav-item"><a class="nav-link" href="pmoneyInfo">페이머니 구매</a></li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">고객지원</a>
        	<div class="dropdown-menu">
				<a class="dropdown-item" href="noticeList">공지사항</a>
				<a class="dropdown-item" href="csList">자주하는질문</a>
				<a class="dropdown-item" href="lostList">유실물 안내</a>
			</div>
			</li>
		</ul>
        <div class="d-flex align-items-center">
<% if (isLogin) { %> <!-- 로그인 상태 -->
		<p class="mb-0"><%=loginInfo.getMi_id() %>님</p>
			<button class="btn btn-primary text-800 me-2" type="button" onclick="location.href='memberLogout'">로그아웃</button>
			<button class="btn order-0" type="submit"><span class="text-primary" onclick="location.href='memberMypage'">마이페이지</span></button>
<%} else { %>
			<button class="btn btn-primary text-800 me-2" type="button" onclick="location.href='memberLogin'">로그인</button>
			<button class="btn order-0" type="button"><span class="text-primary" onclick="location.href='memberJoinStep1'">회원가입</span></button>
<%} %>
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