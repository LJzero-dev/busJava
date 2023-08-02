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
		<h2>추천여행지 관리</h2>
			<div class="d-flex justify-content-between align-items-center">
			<table class="table text-center">
			<colgroup>
				<col width="20%">
				<col width="*">
			</colgroup>
            <tbody class="">
                <tr>
                    <th>검색어</th>
                    <td>
                    <select class="form-control text-center" style="width:30%;">
                    	<option>전체</option>
                    	<option>맛집</option>
                    	<option>명소</option>
                    	<option>액티비티</option>
                    </select>
                    <input type="text" />
                    </td>
                    </tr>
            </tbody>   
            <tbody class="">
                <tr>
                    <th>분류</th>
                    <td>
                    <input type="checkbox" class="custom-control-input" />전체
                    <input type="checkbox" class="custom-control-input" />맛집
                    <input type="checkbox" class="custom-control-input" />명소
                    <input type="checkbox" class="custom-control-input" />액티비티
                    </td>
                </tr>
            </tbody>		
			<tbody class="">
                <tr>
                    <th>게시여부</th>
                    <td>
                    <select class="form-control text-center">
                    	<option>전체</option>
                    	<option>게시</option>
                    	<option>미게시</option>
                    </select>
                    </td>
                </tr>
            </tbody>
        </table>
				
			</div>
			<button type="button" class="btn waves-effect waves-light btn-primary btn-lg m-auto" value="">검색</button>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
		<div class="d-flex justify-content-between p-1 align-items-center">
			<p class="h3 text-primary">버스터미널</p>
			<div class="d-flex justify-content-between float_right">
			<button type="button" class="btn waves-effect waves-light btn-primary btn-lg mr-2" value="">글등록</button>
			<button type="button" class="btn waves-effect waves-light btn-primary btn-lg" value="">미게시로변경</button>
			</div>		
		</div>
		<div class="card">
		<table class="table text-center mb-0">
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col width="10%">
				<col width="10%">
				<col width="*%">
				<col width="10%">
				<col width="10%">
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
<nav aria-label="Page navigation example m-auto">
	<ul class="pagination m-auto">
	    <li class="page-item">
	        <a class="page-link" href="javascript:void(0)" aria-label="Previous">
	            <span aria-hidden="true">«</span>
	            <span class="sr-only">Previous</span>
	        </a>
	    </li>
	    <li class="page-item"><a class="page-link" href="javascript:void(0)">1</a></li>
	    <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
	    <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
	    <li class="page-item">
	        <a class="page-link" href="javascript:void(0)" aria-label="Next">
	            <span aria-hidden="true">»</span>
	            <span class="sr-only">Next</span>
	        </a>
	    </li>
	</ul>
</nav>
</div>

<div class="modal fade" id="AddLine" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
</section>
<%@ include file="../_inc/foot.jsp" %>