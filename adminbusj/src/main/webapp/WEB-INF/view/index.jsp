<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/head.jsp" %>
<%@ page import = "java.text.*" %>
<% 
// if (!isLogin) {		// 로그인이 되어 있지 않다면
// 	out.println("<script>");
// 	out.println("alert('로그인 후 이용해 주세요.'); location.href='/adminbusj/login' ");
// 	out.println("</script>");
// 	out.close();
// }
request.setCharacterEncoding("utf-8");
List<String> salesList = (List<String>)session.getAttribute("salesList");
String[] tmp1 = salesList.get(0).split(":");
String[] tmp2 = salesList.get(1).split(":");
String[] tmp3 = salesList.get(2).split(":");
String[] tmp4 = salesList.get(3).split(":");

DecimalFormat decimalFormat = new DecimalFormat("#,###");
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
                                        <h2 class="text-dark mb-1 font-weight-medium"><%=decimalFormat.format(Integer.parseInt(tmp1[1])) %></h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate">어제</h6>
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark"><%=tmp1[0] %></span>건</h6>
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
                                        <h2 class="text-dark mb-1 font-weight-medium"><%=decimalFormat.format(Integer.parseInt(tmp2[1])) %></h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate">최근 일주일</h6>
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark"><%=tmp2[0] %></span>건</h6>
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
                                        <h2 class="text-dark mb-1 font-weight-medium"><%=decimalFormat.format(Integer.parseInt(tmp3[1])) %></h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate">이번달</h6>
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark"><%=tmp3[0] %></span>건</h6>
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
                                        <h2 class="text-dark mb-1 font-weight-medium"><%=decimalFormat.format(Integer.parseInt(tmp4[1])) %></h2>원
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate">올해</h6>
                                        <h4 class="text-muted font-weight-normal mb-0 w-100 text-truncate text-right"><span class="text-dark"><%=tmp4[0] %></span>건</h6>
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
                                <h4 class="card-title">이달의 고속버스 인기 노선</h4>
                                <div>
                                    <canvas id="pie-chart1" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">이달의 시외버스 인기 노선</h4>
                                <div>
                                    <canvas id="pie-chart2" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">고속버스 분기별 매출 현황</h4>
                                <div>
                                    <canvas id="bar-chart1" height="150"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">시외버스 분기별 매출 현황</h4>
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