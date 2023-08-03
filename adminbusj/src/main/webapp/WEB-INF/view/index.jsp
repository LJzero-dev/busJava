<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/head.jsp" %>
<% if (!isLogin) {		// 로그인이 되어 있지 않다면
	out.println("<script>");
	out.println("alert('로그인 후 이용해 주세요.'); location.href='/adminbusj/login' ");
	out.println("</script>");
	out.close();
}
%>
<div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">대시보드</h3>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="card-group">
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-md-block">
                                <div>
                                    <div class="d-flex justify-content-end align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium">84,000</h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">어제</h6>
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark">12</span>건</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-md-block">
                                <div>
                                    <div class="d-flex justify-content-end align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium">84,000</h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">어제</h6>
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark">12</span>건</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-md-block">
                                <div>
                                    <div class="d-flex justify-content-end align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium">84,000</h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">어제</h6>
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark">12</span>건</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div class="d-md-block">
                                <div>
                                    <div class="d-flex justify-content-end align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium">84,000</h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">어제</h6>
                                        <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark">12</span>건</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Pie Chart</h4>
                                <div>
                                    <canvas id="pie-chart1" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Pie Chart</h4>
                                <div>
                                    <canvas id="pie-chart2" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Bar Chart</h4>
                                <div>
                                    <canvas id="bar-chart1" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Bar Chart</h4>
                                <div>
                                    <canvas id="bar-chart2" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<%@ include file="_inc/foot.jsp" %>