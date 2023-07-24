<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>

<section class="probootstrap_section">
      <div class="container">
        <div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
          <div class="col-md-12">
            <h2 class="border-bottom probootstrap-section-heading">마이페이지</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-10 text-center mb-5 m-auto">
            <div class="d-flex align-items-end">
              <h3 class="text-left text-primary">유저 이름</h3>
              <h5 class="text-left">님 반갑습니다.</h5>
            </div>
            <ul class="mypage">
              <li>
                <a href="/busjava/pwChk">
                  <div class="h-100 d-flex justify-content-center align-items-center flex-column">
                  <img src="/assets/images/User.svg" />
                  <p class="h5 mt-3">내 정보</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="/busjava/booking">
                  <div class="h-100 d-flex justify-content-center align-items-center flex-column">
                  <img src="/assets/images/Newspaper.svg" />
                  <p class="h5 mt-3">예매 내역</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="/busjava/payMoney">
                  <div class="h-100 d-flex justify-content-center align-items-center flex-column">
                  <img src="/assets/images/Copyright.svg" />
                  <p class="h5 mt-3">내 페이머니</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="/busjava/coupon">
                  <div class="h-100 d-flex justify-content-center align-items-center flex-column">
                  <img src="/assets/images/Money.svg" />
                  <p class="h5 mt-3">내 쿠폰</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="/busjava/stamp">
                  <div class="h-100 d-flex justify-content-center align-items-center flex-column">
                  <img src="/assets/images/Gift.svg" />
                  <p class="h5 mt-3">내 스탬프</p>
                  </div>
                </a>
              </li>
            </ul>
        </div>
      </div>
    </section>

<%@ include file="../_inc/foot.jsp" %>