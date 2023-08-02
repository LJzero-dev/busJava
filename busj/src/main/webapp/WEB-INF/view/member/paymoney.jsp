<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");  
List<paymoneyInfo> pList = (List<paymoneyInfo>)request.getAttribute("pList");
List<paymoneyInfo> mphList = (List<paymoneyInfo>)request.getAttribute("mphList");
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
<% if ( mi.getMi_pmoney() <= 0) { %>
	           	<td class="text-left">보유중인 페이머니가 없습니다.</td>
	           	<td colspan="2" class="text-right"><button type="button" class="btn btn-primary" onclick="location.href=''" />충전하기</td>
	           	</tr>
<% } else { %>	           	
	            <tr>
                  <td class="text-left">
                    <p class="mb-0"><%=mi.getMi_pmoney() %> 원</p>
                  </td>
                  <td colspan="2" class="text-right"><button type="button" class="btn btn-primary" onclick="location.href=''" />충전하기</td>
                </tr>
<% } %>	
              </tbody>
            </table>
            <p class="h4 mt-5 text-left text">페이머니 사용 내역</p>
            <div class="btn-wrap justify-content-start">         
              <p class="mb-0">최근 3개월 내역만 노출됩니다.</p>
<!--          <button type="button" class="btn btn-primary" onclick="" >3개월</button>
        	  <button type="button" class="btn btn-secondary" onclick="" >6개월</button>
              <button type="button" class="btn btn-secondary" onclick="" >1년</button> -->
            </div>
            <table class="table text-center mt-2">
              <colgroup>
                <col width="15%">
                <col width="40%">
                <col width="*">
              </colgroup>
              <tbody>
<% for (paymoneyInfo pl : pList) {  %>
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">-<%=pl.getTotal_cr_pmoney() %></p></td>
                  <td class="text-left">
                    <p class="mb-0"><%=pl.getBl_type() %>버스 예매</p>
                    <p class="mb-0"><%=pl.getBt_sidx() %> -> <%=pl.getBt_eidx() %></p>
                  </td>
                  <td class="text-right">사용일시</td>
                  <td class="text-right"><%=pl.getCr_date() %></td>
                </tr>
<% } %>
              </tbody>
            </table>
            
            <p class="h4 mt-5 text-left text">페이머니 충전 내역</p>
            <div class="btn-wrap justify-content-start">         
              <p class="mb-0">최근 3개월 내역만 노출됩니다.</p>
<!--          <button type="button" class="btn btn-primary" onclick="" >3개월</button>
        	  <button type="button" class="btn btn-secondary" onclick="" >6개월</button>
              <button type="button" class="btn btn-secondary" onclick="" >1년</button> -->
            </div>
            <table class="table text-center mt-2">
              <colgroup>
                <col width="15%">
                <col width="40%">
                <col width="*">
              </colgroup>
              <tbody>
<!-- 페이머니 내역 for문 동려서 출력  -->
<% for (paymoneyInfo mpl : mphList) {  %>
                <tr>
                  <td class="align-middle"><p class="h2 mb-0">+<%=mpl.getMph_pmoney() %></p></td>
                  <td class="text-left">
                    <p class="mb-0"><%=mpl.getMph_pmoney() %>원권 충전</p>
                    <p class="mb-0">10% 추가 적립</p>
                  </td>
                  <td class="text-right">충전일시</td>
                  <td class="text-right"><%=mpl.getMph_date() %></td>
                </tr>
<% } %>
              </tbody>
            </table>
        </div>
      </div>
    </section>

<%@ include file="../_inc/foot.jsp"%>
