<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<body>
<section class="probootstrap_section">
<div class="page-wrapper">     
<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
    </div>
</div>
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">고속버스 터미널 시간표 관리</h3>
		</div>
	</div>
</div> 
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
		<div class="d-flex justify-content-between p-3 align-items-center">
			<p class="h3 text-primary">강릉고속버스터미널</p>
			<button type="button" class="btn waves-effect waves-light btn-primary btn-lg" id="seoul" value="서울" onclick="">추가</button>		
		</div>
		<div class="card">
		<table class="table text-center">
		<colgroup>
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
				<col width="12%">
			</colgroup>
            <thead class="bg-primary text-white">
                <tr>
                    <th>출발시간</th>
                    <th>도착시간</th>
                    <th>회사명</th>
                    <th>등급</th>
                    <th>성인요금</th>
                    <th>청소년요금</th>
                    <th>아동요금</th>
                    <th>수정/삭제</th>
                </tr>
            </thead>
            <tbody class="border border-primary">
                <tr>
                    <td>1</td>
                    <td>Nigam</td>
                    <td>Eichmann</td>
                    <td>@Sonu</td>
                    <td>1</td>
                    <td>Nigam</td>
                    <td>Eichmann</td>
                    <td>@Sonu</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Deshmukh</td>
                    <td>Prohaska</td>
                    <td>@Genelia</td>
                    <td>1</td>
                    <td>Nigam</td>
                    <td>Eichmann</td>
                    <td>@Sonu</td>
                </tr>
            </tbody>
        </table>
		</div>
		</div>
	</div>
</div>
</div>
<div class="modal fade" id="AddTerminal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>

</section>
<%@ include file="../_inc/foot.jsp" %>