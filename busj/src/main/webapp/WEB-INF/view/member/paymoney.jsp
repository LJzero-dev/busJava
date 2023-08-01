<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
paymoneyInfo pi = (paymoneyInfo)request.getAttribute("pi");
%>
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
               <p class="h4 mt-5 text-left text">내 페이머니</p>
<!-- 페이머니 잔액 출력 / if문 사용  -->
	           	<tr>
<% if (!(pi.getMi_pmoney() > 0)) { %>
	           	<td class="text-left">보유중인 페이머니가 없습니다.</td>
	           	<td colspan="2" class="text-right"><button type="button" class="btn btn-primary" onclick="" />충전하기</td>
	           	</tr>
<% } else { %>	           	
	            <tr>
                  <td class="text-left">
                    <p class="mb-0"><%=pi.getMi_pmoney() %> 원</p>
                  </td>
                  <td colspan="2" class="text-right"><button type="button" class="btn btn-primary" onclick="" />충전하기</td>
                </tr>
<% } %>	
              </tbody>
            </table>
            <p class="h4 mt-5 text-left text">페이머니 충전&사용 내역</p>
            <div class="btn-wrap justify-content-start">
<!-- 버튼에 따라 jQuery 사용  -->            
              <button type="button" class="btn btn-primary" onclick="" >3개월</button>
              <button type="button" class="btn btn-secondary" onclick="" >6개월</button>
              <button type="button" class="btn btn-secondary" onclick="" >1년</button>
            </div>
            <table class="table text-center mt-2">
              <colgroup>
                <col width="15%">
                <col width="40%">
                <col width="*">
              </colgroup>
              <tbody>
<!-- 페이머니 내역 for문 동려서 출력  -->
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">-<%=pi.getTotal_cr_pmoney() %></p></td>
                  <td class="text-left">
                    <p class="mb-0"><%=pi.getBl_type() %>버스 예매</p>
                    <p class="mb-0"><%=pi.getBt_sidx() %> -> <%=pi.getBt_eidx() %></p>
                  </td>
                  <td class="text-right">사용일시</td>
                  <td class="text-right">2023.07.06 12:00</td>
                </tr>
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">-20000</p></td>
                  <td class="text-left">
                    <p class="mb-0">시외버스 예매</p>
                    <p class="mb-0">여수 -> 순천 </p>
                  </td>
                <td class="text-right">사용일시</td>
                  <td class="text-right">2023.07.06 12:00</td>
                </tr>
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">+220000</p></td>
                  <td class="text-left">
                    <p class="mb-0">20만원 충전</p>
                    <p class="mb-0">10% 추가 적립</p>
                  </td>
                  <td class="text-right">사용일시</td>
                  <td class="text-right">2023.07.06 12:00</td>
                </tr>
              </tbody>
            </table>
        </div>
      </div>
    </section>

<%@ include file="../_inc/foot.jsp"%>
