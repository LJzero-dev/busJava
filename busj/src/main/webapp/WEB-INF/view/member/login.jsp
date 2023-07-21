<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
          </div>
        </div>

      </div>
    </section>
