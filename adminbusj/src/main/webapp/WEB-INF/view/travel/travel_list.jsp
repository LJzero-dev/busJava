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
			<button type="button" class="btn waves-effect waves-light btn-primary btn-lg" value="">추가</button>
			</div>		
		</div>
		<div class="card">
		<table class="table text-center">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="12%">
				<col width="*">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="12%">
			</colgroup>
            <thead class="bg-primary text-white">
                <tr>
                    <th>출발시간</th>
                    <th>도착시간</th>
                    <th>회사명</th>
                    <th>차량번호</th>
                    <th>등급</th>
                    <th>성인요금</th>
                    <th>청소년요금</th>
                    <th>아동요금</th>
                    <th>삭제</th>
                </tr>
            </thead>   
            <tbody class="border border-primary ">
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
					<td></td>
					<td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
			<tbody class="border border-primary">
            	<tr>
            		<td colspan="8">운행중인 시간표가 없습니다.</td>
            	</tr>
            </tbody>		
			<tbody class="border border-primary">
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
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