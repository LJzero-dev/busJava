<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<div class="container-fluid">
	<div class="row">
		<div class="col-lg-12">
			<h2>추천여행지 등록</h2>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
		<div class="card">
		<table class="table text-center mb-0">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="*">
			</colgroup>
            <thead class="bg-primary text-white">
                <tr>
                    <th><input type="checkbox" /></th>
                    <th>No</th>
                    <th>지역</th>
                    <th>분류</th>
                    <th>장소명</th>
                    <th>작성일</th>
                    <th>게시여부</th>
                </tr>
            </thead>   
            <tbody class="border border-primary text-black ">
                <tr>
                    <td><input type="checkbox" /></td>
                    <td>20</td>
                    <td>서울</td>
                    <td><span class="badge badge-pill badge-primary">액티비티</span></td>
                    <td>남산타워</td>
					<td>23.08.03</td>
					<td>Y</td>
                </tr>
            </tbody>
			<tbody class="border border-primary">
            	<tr>
                    <td><input type="checkbox" /></td>
                    <td>20</td>
                    <td>서울</td>
                    <td><span class="badge badge-pill badge-primary">맛집</span></td>
                    <td>남산타워</td>
					<td>23.08.03</td>
					<td>Y</td>
                </tr>
            </tbody>		
        </table>
		</div>
		</div>
	</div>
</div>
</div>
<div class="modal fade" id="AddLine" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
</section>


<%@ include file="../_inc/foot.jsp" %>