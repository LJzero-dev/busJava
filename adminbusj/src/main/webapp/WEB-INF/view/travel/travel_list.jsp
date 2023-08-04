<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../_inc/head.jsp" %>
<style>
.changePointer {
      cursor: pointer;
}
</style>
<script>
$(document).ready(function(){
	changePointer();
	clickTd();
	clickTr();
})
 
function changePointer(){
	$('.tr').mouseover(function(){
	   $(this).addClass('changePointer');
	}).mouseout(function() {
	   $(this).removeClass('changePointer');
	});
}
</script>
<div class="page-wrapper">
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">추천여행지 관리</h3>
		</div>
	</div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <table class="table table-sm custom">
                <colgroup>
                    <col width="20%">
                    <col width="*">
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">검색어</th>
                        <td class="text-left">
                            <div class="d-flex">
                                <select class="form-control w-auto" id="">
                                    <option>전체</option>
                                    <option>지역</option>
                                    <option>장소명</option>
                                </select>
                                <input type="text" class="form-control">
                            </div>
                        </td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray">분류</th>
                        <td class="text-left">
                        <div class="d-flex">
                            <div class="form-check form-check-inline">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="customCheck1">
                                    <label class="custom-control-label" for="customCheck1">전체</label>
                                </div>
                            </div>
                            <div class="form-check form-check-inline">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="customCheck1">
                                    <label class="custom-control-label" for="customCheck1">맛집</label>
                                </div>
                            </div>
                            <div class="form-check form-check-inline">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="customCheck1">
                                    <label class="custom-control-label" for="customCheck1">명소</label>
                                </div>
                            </div>
                            <div class="form-check form-check-inline">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="customCheck1">
                                    <label class="custom-control-label" for="customCheck1">액티비티</label>
                                </div>
                            </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">게시여부</th>
                        <td class="text-left">
                            <div class="d-flex">
                                <select class="form-control w-auto" id="">
                                    <option>전체</option>
                                    <option>게시</option>
                                    <option>미게시</option>
                                </select>
                            </div>
                        </td> 
                    </tr>
                </tbody>
            </table>
            <div class="d-flex justify-content-center">
            <button type="button" class="btn waves-effect waves-light btn-secondary mb-2">검색</button>
            </div>
        </div> 
    </div>
</div>
<div class="col-lg-12 text-right">
	<button type="button" class="btn waves-effect waves-light btn-primary btn-lg" onclick="location.href='travelForm?kind=in'">글등록</button>
	<button type="button" class="btn waves-effect waves-light btn-primary btn-lg ml-2" value="">미게시로변경</button>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <table id="table" class="table text-center mb-0">
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
                    <th><input type="checkbox" style="width:18px; height:18px;" /></th>
                    <th>No</th>
                    <th>지역</th>
                    <th>분류</th>
                    <th class="text-left">장소명</th>
                    <th>작성일</th>
                    <th>게시여부</th>
                </tr>
            	</thead>  
            	<c:if test="${travelList.size() > 0 }">
					<c:forEach items="${travelList }" var="tl" varStatus="status">
		                <tbody class="border border-primary">
		                <tr class="tr" onclick="location.href='travelView?tl_idx=${tl.getTl_idx() }'">
		                    <td><input type="checkbox" style="width:18px; height:18px;" /></td>
		                    <td>${pi.getNum() - status.index}</td>
		                    <td>${tl.getTl_area()}</td>
		                    <td><span class="badge badge-pill badge-primary">${tl.getTl_ctgr() }</span></td>
		                    <td class="text-left">${tl.getTl_title()}</td>
							<td>${tl.getTl_date() }</td>
							<td>${tl.getTl_isview() }</td>
		                </tr>
		           		</tbody>
		           	</c:forEach>
				</c:if>
           		<c:if test="${travelList.size() == 0 }">
					<tbody class="border border-primary">
		                <tr>
		                    <td colspan="7">검색결과가 없습니다.</td>
		                </tr>
		           	</tbody>
				</c:if>
            </table>
            <div class="d-flex justify-content-center mt-2">
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
<%@ include file="../_inc/foot.jsp" %>