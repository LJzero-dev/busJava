<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>

<section class="probootstrap_section">
      <div class="container">
        <div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
          <div class="col-md-12">
            <h2 class="border-bottom probootstrap-section-heading">내 쿠폰</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-10 text-center mb-5 m-auto">
            <table class="table text-center mt-2">
              <colgroup>
                <col width="*">
                <col width="16.5%">
                <col width="25%">
              </colgroup>
              <tbody>
               <p class="h4 mt-5 text-left text">보유중인 쿠폰 ?? 장</p>
<!-- 쿠폰개수 출력 / if문 사용  -->
	           	<tr	colspan=5>보유중인 쿠폰이 없습니다.</tr>
	            <tr>
                  <td class="text-left">
                    <p class="mb-0">버스 무료 탑승권</p>
                  </td>
                  <td class="text-left">
                   <p class="mb-0">사용일시 </p>
                  </td>
                  <td class="text-right">2023.07.06 12:00</td>
                </tr>
              </tbody>
            </table>
            <p class="h4 mt-5 text-left text">쿠폰 적립&사용 내역</p>
            <div class="btn-wrap justify-content-start">
<!-- 버튼에 따라 jQuery 사용  -->            
              <button type="button" class="btn btn-primary">3개월</button>
              <button type="button" class="btn btn-secondary">6개월</button>
              <button type="button" class="btn btn-secondary">1년</button>
            </div>
            <table class="table text-center mt-2">
              <colgroup>
                <col width="15%">
                <col width="40%">
                <col width="*">
              </colgroup>
              <tbody>
<!-- 쿠폰정보 for문 동려서 출력  -->
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">-1</p></td>
                  <td class="text-left">
                    <p class="mb-0">고속버스 예매</p>
                    <p class="mb-0">서울 -> 부산</p>
                  </td>
                  <td class="text-right">사용일시 2023.07.06 12:00</td>
                </tr>
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">- 1</p></td>
                  <td class="text-left">
                    <p class="mb-0">시외버스 예매</p>
                    <p class="mb-0">여수 -> 순천 </p>
                  </td>
                  <td class="text-right">사용일시 2023.07.06 12:00</td>
                </tr>
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">+1</p></td>
                  <td class="text-left">
                    <p class="mb-0">버스 무료 탑승권</p>
                    <p class="mb-0">스탬프 30개 리워드</p>
                  </td>
                  <td class="text-right">적립일시 2023.07.06 12:00</td>
                </tr>
              </tbody>
            </table>
        </div>
      </div>
    </section>

<%@ include file="../_inc/foot.jsp"%>
