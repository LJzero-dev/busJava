<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<section class="probootstrap_section">
<div class="page-wrapper">
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">추천여행지 등록</h3>
		</div>
	</div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
        <form name="frmIn" action="travelIn" method="post" enctype="multipart/form-data">
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
                        <td class="text-left">
	                        <select class="form-control w-auto" name="area">
	                            <option>서울</option>
	                            <option>경기도</option>
	                            <option>강원도</option>
	                            <option>경상북도</option>
	                            <option>경상남도</option>
	                        </select>
                        </td>
                        <th scope="row" class="text-center bg-gray align-middle">분류</th>
                        <td>
                        <div class="d-flex">
	                        <select class="form-control w-auto" name="ctgr">
	                            <option>명소</option>
	                            <option>액티비티</option>
	                            <option>맛집</option>
	                        </select>
                        </div>
                        </td>
                        <th scope="row" class="text-center bg-gray align-middle">장소명</th>
                        <td><input type="text" class="form-control" name="title"></td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray">내용</th>
                        <td class="text-left" colspan="5">
                        <textarea class="textarea" name="content" style="width:100%; height:250px;" maxlength="150" placeholder="내용을 입력하세요."></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">이미지</th>
                        <td class="text-left">
                            <div class="d-flex">
                                <input type="file" name="uploadFile" required />
                            </div>
                        </td> 
                    </tr>
                    <tr>
                        <th scope="row" class="text-center bg-gray align-middle">게시여부</th>
                        <td class="text-left" colspan="5">
                            <div class="d-flex">
                            <div class="btn-group" data-toggle="buttons">
                                <label class="btn waves-effect waves-light ">
                                    <div class="custom-control custom-radio">
                                        <input type="radio" id="customRadio4" name="isview" class="custom-control-input" checked="checked" />
                                        <label class="custom-control-label" for="customRadio4">게시</label>
                                    </div>
                                </label>
                                <label class="btn waves-effect waves-light ml-3">
                                    <div class="custom-control custom-radio">
                                        <input type="radio" id="customRadio5" name="isview" class="custom-control-input" />
                                        <label class="custom-control-label" for="customRadio5">미게시</label>
                                    </div>
                                </label>
                            </div>
                            </div>
                        </td> 
                    </tr>
                </tbody>
            </table>
            <div class="d-flex justify-content-center">
	            <button type="button" class="btn waves-effect waves-light btn-secondary mb-2 mr-3">취소</button>
	            <button type="submit" class="btn waves-effect waves-light btn-secondary mb-2">등록</button>
            </div>
        </form>
        </div> 
    </div>
</div>
</div>
</section>


<%@ include file="../_inc/foot.jsp" %>