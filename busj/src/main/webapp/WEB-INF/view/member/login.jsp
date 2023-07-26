<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../_inc/head.jsp" %>


<section class="probootstrap_section" id="section-city-guides">
  <div class="container">
    <div class="row text-center mb-5 probootstrap-animate">
      <div class="col-md-12">
        <h2 class="display-5 border-bottom probootstrap-section-heading">로그인</h2>
      </div>
    </div>
    <div class="row mb-4">
      <div class="col-md-4 m-auto">
        <form name="frmLogin" action="memberLogin" method="post">
          <div class="form-group">
            <label for="mi_id">아이디</label>
            <input type="text" class="form-control" id="mi_id" name="mi_id" value="test1">
          </div>
          <div class="form-group">
            <label for="mi_pw">비밀번호</label>
            <input type="password" class="form-control" id="mi_pw" name="mi_pw" value="1234" >
          </div>
          <button type="submit" class="btn btn-primary btn-block" >로그인</button>
        </form>
        <div class="d-flex justify-content-center mT3">
	   <a href="memberJoinStep1" class="mR1">회원가입</a>
	   <a href="memberFind">아이디/비밀번호 찾기</a>
	   </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="../_inc/foot.jsp"%>