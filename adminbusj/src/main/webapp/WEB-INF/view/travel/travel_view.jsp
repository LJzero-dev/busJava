<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../_inc/head.jsp" %>
<%
if (!isLogin) {		// 로그인이 되어 있지 않다면
	out.println("<script>");
	out.println("alert('로그인 후 이용해 주세요.'); location.href='/adminbusj/login' ");
	out.println("</script>");
	out.close();
}
%>
<section class="probootstrap_section">
<div class="page-wrapper">
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">추천여행지 등록</h3>
		</div>
	</div>
	<div class="row">
    <div class="col-lg-12">
        <div class="card">
        <input type="hidden" name="kind" value="up" />
            <table class="table table-sm custom">
                <colgroup>
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="*">
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">지역</th>
                        <td class="text-left">${tr.getTl_area() }</td>
                        <th scope="row" class="text-center bg-gray align-middle">분류</th>
                        <td>
                        <div class="d-flex">
	                        ${tr.getTl_ctgr() }
                        </div>
                        </td>
                        <th scope="row" class="text-center bg-gray align-middle">장소명</th>
                        <td>${tr.getTl_title() }</td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray">내용</th>
                        <td class="text-left" colspan="5">${tr.getTl_content() }</td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">이미지</th>
                        <td class="text-left">
                            <div class="d-flex">
                                <img src="resources/images/travel/${tr.getTl_img() }" width="100" height="100" />
                            </div>
                        </td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">게시여부</th>
                        <td class="text-left" colspan="5">
                            <div class="d-flex">${tr.getTl_isview() }</div>
                        </td> 
                    </tr>
                </tbody>
            </table>
            <div class="d-flex justify-content-center">
	            <button type="button" class="btn waves-effect waves-light btn-secondary mb-2 mr-3" onclick="location.href='travelList'">목록</button>
	            <button type="button" class="btn waves-effect waves-light btn-secondary mb-2" onclick="location.href='travelForm?kind=up&tl_idx=${tr.getTl_idx()}'">수정</button>
            </div>
        </div> 
    </div>
</div>
</div>
</div>
</section>


<%@ include file="../_inc/foot.jsp" %>