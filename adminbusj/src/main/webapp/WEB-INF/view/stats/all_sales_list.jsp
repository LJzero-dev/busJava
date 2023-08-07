<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../_inc/head.jsp" %>
<style>
.changePointer {
      cursor: pointer;
}
</style>
<script>
$(document).ready(function(){
	changePointer();
})
 
function changePointer(){
	$('.tr').mouseover(function(){
	   $(this).addClass('changePointer');
	}).mouseout(function() {
	   $(this).removeClass('changePointer');
	});
}

function makeCtgr() {
// 검색폼의 조건들을 쿼리스트링 sch의 값으로 만듦
	var frm = document.frmSch;	var sch = "";
	
	// 브랜드 조건
	var arr = frm.schctgr;	// brand라는 이름의 컨트롤들을 배열로 받아옴
	var isFirst = true;		// brand 체크박스들 중 첫번째로 선택한 체크박스인지 여부를 저장
	for (var i = 0; i < arr.length; i++) {
		if (arr[i].checked) {
			if(isFirst) {	// 첫번째로 선택한 체크박스 이면
				isFirst = false;
				sch += arr[i].value;
			} else {
				sch += ":" + arr[i].value;
			}
		}
	}
	
	document.frmSch.hiddenCtgr.value = sch;
	document.frmSch.submit();
}
</script>
<div class="page-wrapper">
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">매출 관리</h3>
		</div>
	</div>
	<div class="row">
    <div class="col-lg-12">
        <div class="card">
        <form name="frmSch">
        <input type="hidden" id="hiddenCtgr" name="hiddenCtgr" value="" />
            <table class="table table-sm custom">
                <colgroup>
                    <col width="20%">
                    <col width="*">
                </colgroup>
                <tbody>
                <tr>
                        <th scope="row" class="text-center bg-gray align-middle">버스구분</th>
                        <td class="text-left">
                            <div class="d-flex">
                                <select class="form-control w-auto" name="isview" id="">
                                    <option value="">전체</option>
                                    <option value="y" <c:if test="${pi.getIsview() == 'y' }">selected='selected'</c:if> >게시</option>
                                    <option value="n" <c:if test="${pi.getIsview() == 'n' }">selected='selected'</c:if>>미게시</option>
                                </select>
                            </div>
                        </td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">기간</th>
                        <td class="text-left">
                            <div class="d-flex align-center">
                                <div class="form-group mb-0 mr-1">
                                	<input type="date" class="form-control" value="2018-05-13">
                                </div>
                                <span style="line-height: 2.2;"> ~ </span>
                                <div class="form-group mb-0 ml-1">
                                    <input type="date" class="form-control" value="2018-05-13">
                                </div>
                            </div>
                        </td> 
                    </tr>
                </tbody>
            </table>
            <div class="d-flex justify-content-center">
            <button type="button" class="btn waves-effect waves-light btn-secondary mb-2" onclick="makeCtgr();">검색</button>
            </div>
            </form>
        </div> 
    </div>
</div>
<div class="row">
<div class="col-lg-12 text-right mb-2">
	<button type="button" class="btn waves-effect waves-light btn-primary btn-lg" onclick="location.href='travelForm?kind=in'">글등록</button>
	<button type="button" class="btn waves-effect waves-light btn-secondary btn-lg ml-2" onclick="chkDel();" value="">미게시로변경</button>
</div>
    <div class="col-lg-12">
        <div class="card">
        <form name="frm">
        <input type="hidden" name="chk" value="" />
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
                    <th><input type="checkbox" name="chechkall" style="width:18px; height:18px;" onclick="chkAll(this);" /></th>
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
		                <tr class="tr">
		                    <td><input type="checkbox" name="chk" value="${tl.getTl_idx() }" style="width:18px; height:18px;" onclick="chkOne(this);" /></td>
		                    <td>${pi.getNum() - status.index}</td>
		                    <td>${tl.getTl_area()}</td>
		                    <td><span class="badge badge-pill badge-primary">${tl.getTl_ctgr() }</span></td>
		                    <td class="text-left"><a href="travelView?tl_idx=${tl.getTl_idx() }">${tl.getTl_title()}</a></td>
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
				<c:if test="${travelList.size() > 0 }">
				    <li class="page-item">
				    <c:choose>
						<c:when test="${ pi.getCpage() == 1 }">
						<a class="page-link" href="travelList?cpage=1${pi.getSchargs()}" aria-label="Previous"></c:when>
						<c:when test="${ pi.getCpage() > 1 }">
						<a class="page-link" href="travelList?cpage=${pi.getCpage() - 1}${pi.getSchargs()}" aria-label="Previous"></c:when>
					</c:choose>
				            <span aria-hidden="true">«</span>
				            <span class="sr-only">Previous</span>
				        </a>
				    </li>
				    <c:forEach var="i" begin="${pi.getSpage() }" end="${pi.getSpage() + pi.getBsize() - 1 <= pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt()}">
							<li class="page-item"><a class="page-link" href="travelList?cpage=${i }${pi.getSchargs() }">${i }</a></li>
					</c:forEach>
				    <li class="page-item">
				    <c:choose>
						<c:when test="${pi.getCpage() == pi.getPcnt()}">
						<a class="page-link" href="travelList?cpage=${pi.getCpage()}${pi.getSchargs() }" aria-label="Next"></c:when>
						<c:when test="${pi.getCpage() <  pi.getPcnt()}">
						<a class="page-link" href="travelList?cpage=${pi.getCpage() + 1 }${pi.getSchargs() }" aria-label="Next"></c:when>
					</c:choose>
				            <span aria-hidden="true">»</span>
				            <span class="sr-only">Next</span>
				        </a>
				    </li>
				</c:if>
				</ul>
			</nav>
            </div>
        </form>
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