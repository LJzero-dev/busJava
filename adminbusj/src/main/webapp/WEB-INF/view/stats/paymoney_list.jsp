<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../_inc/head.jsp" %>
<style>
.changePointer {
      cursor: pointer;
}

h4.sub_title {font-size: 20px; margin-top: 10px; margin-left: 10px;}
</style>
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
        <input type="hidden" name="sDate2-1" id="sDate2-1" value="2023-07-23" />
        <input type="hidden" name="eDate2-1" id="eDate2-1" value="2023-08-07" />
            <table class="table table-sm custom">
                <colgroup>
                    <col width="20%">
                    <col width="*">
                </colgroup>
                <tbody>
                <tr>
                        <th scope="row" class="text-center bg-gray align-middle">회원ID</th>
                        <td class="text-left">
                            <div class="d-flex">
                                <input type="text" class="form-control" name="mi_id" />
                            </div>
                        </td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">기간</th>
                        <td class="text-left">
                            <div class="d-flex align-center">
                                <div class="form-group mb-0 mr-1">
                                	<input type="date" class="form-control" id="sDate1-1" onchange="handler(event)" value="2023-07-23">
                                </div>
                                <span style="line-height: 2.2;"> ~ </span>
                                <div class="form-group mb-0 ml-1">
                                    <input type="date" class="form-control" id="eDate1-1" onchange="" value="2023-08-07">
                                </div>
                            </div>
                        </td> 
                    </tr>
                </tbody>
            </table>
            <div class="d-flex justify-content-center">
            <button type="submit" class="btn waves-effect waves-light btn-secondary mb-2" >검색</button>
            </div>
            </form>
        </div> 
    </div>
</div>
<c:set var="allCount" value="0" />
<div class="row">

    <div class="col-lg-12">
        <div class="card">
        <form name="frm">
        <input type="hidden" name="chk" value="" />
            <table id="table" class="table text-center mb-0">
                <colgroup>
                    <col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
                </colgroup>
                <thead class="bg-primary text-white">
                <tr>
                    <th>회원ID</th>
                    <th>결제금액</th>
                    <th>충전금액</th>
                    <th>충전일시</th>
                    <th>결제수단</th>
                </tr>
            	</thead>  
            	<c:if test="${paymoneyList.size() > 0 }">
					<c:forEach items="${paymoneyList }" var="pl" varStatus="status">
					<c:set var="allCount" value="${allCount + pl.getMph_real_price()}" />
		                <tbody class="border border-primary">
		                <tr class="tr">
		                    <td>${pl.getMi_id() }</td>
		                    <td><fmt:formatNumber value="${pl.getMph_real_price() }" type="number" groupingUsed="true" /></td>
		                    <td><fmt:formatNumber value="${pl.getMph_pmoney() }" type="number" groupingUsed="true" /></td>
		                    <td>${pl.getMph_date()}</td>
		                    <td>${pl.getMph_payment()}</td>
		                </tr>
		           		</tbody>
		           	</c:forEach>
				</c:if>
           		<c:if test="${paymoneyList.size() == 0 }">
					<tbody class="border border-primary">
		                <tr>
		                    <td colspan="5">검색결과가 없습니다.</td>
		                </tr>
		           	</tbody>
				</c:if>
            </table>
        </form>
        </div>
        <h4 class="sub_title">총 매출 금액 : <fmt:formatNumber value="${allCount }" type="number" groupingUsed="true" /> <span id=""></span></h4>
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
<script>
function handler(e){
	$("#sDate2-1").val(e.target.value);
	console.log($("#sDate1-1").val());
}
</script>
<%@ include file="../_inc/foot.jsp" %>