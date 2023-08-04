<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="_inc/head.jsp" %>

   <div class="main-wrapper">
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/resources/images/favicon.png">
    <title>BUSJAVA ADMIN</title>
    <link href="${pageContext.request.contextPath}/resources/css/style.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.timepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.timepicker.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/jquery.timepicker.min.css">
    
</head>
<body>
    <div class="main-wrapper">
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
        <div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative">
            <div class="auth-box row text-center">
                <div class="col-lg-7 col-md-5 modal-bg-img" style="background-image: url(assets/images/big/관리자로그인.png);">
                </div>
                <div class="col-lg-5 col-md-7 bg-white">
                    <div class="p-3">
                        <h2 class="mt-3 text-center">로그인</h2>
                        <form class="mt-4" name="frmLogin" action="adminLogin" method="post">
        <div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative">
            <div class="auth-box row text-center">
                <div class="col-lg-7 col-md-5 modal-bg-img" style="background-image: url(${pageContext.request.contextPath}/resources/images/login.png);">
                </div>
                <div class="col-lg-5 col-md-7 bg-white">
                    <div class="p-3">
                        <h2 class="mt-3 text-center text-primary">로그인</h2>
                        <form name="frmLogin" action="adminLogin" method="post">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group custom">
                                        <label for="ai_id">아이디</label>
                                        <input class="form-control" type="text" id="ai_id" name="ai_id" value="admin1">
                                        <input type="text" class="form-control" id="ai_id" name="ai_id" value="admin1">
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group custom">
                                        <label for="ai_pw">비밀번호</label>
                                        <input class="form-control" type="password" id="ai_pw" name="ai_pw" value="1234">
                                    </div>
                                </div>
                                <div class="col-lg-12 text-center">
                                        <input type="password" class="form-control" id="ai_pw" name="ai_pw" value="1234" >
                                    </div>
                                </div>
                                <div class="col-lg-12 text-center mb-3">
                                    <button type="submit" class="btn btn-block btn-dark">로그인</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- All Required js -->
    <!-- ============================================================== -->
    <script src="assets/libs/jquery/dist/jquery.min.js "></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="assets/libs/popper.js/dist/umd/popper.min.js "></script>
    <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js "></script>
    <!-- ============================================================== -->
    <!-- This page plugin js -->
    <!-- ============================================================== -->
    <script>
        $(".preloader ").fadeOut();
    </script>
<%@ include file="_inc/foot.jsp"%>




 
    </div>
    <script>
        $(".preloader ").fadeOut();
    </script>
<%@ include file="_inc/foot.jsp"%>
