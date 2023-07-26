<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
List<BookInfo> bookList = (List<BookInfo>) request.getAttribute("bookList");

for (BookInfo book : bookList) {
%>
<section class="probootstrap_section">
    <div class="container">
        <div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated mb-0">
          <div class="col-md-12">
            <h2 class="border-bottom mb-5 probootstrap-section-heading">예매 내역</h2>
          </div>
       
        </div>
        <div class="row">
          <div class="col-md-12">
            <table class="table table-hover">
              <colgroup>
                  <col width="*">    
                  <col width="8%">
                  <col width="10%">
                  <col width="10%">
                  <col width="15%">
                  <col width="10%">
                  <col width="20%">
                  <col width="5%">
                  <col width="8%">
              </colgroup>
              <thead>
              <tr>
                  <th scope="col" class="text-center">예매번호</th>
                  <th scope="col" class="text-center">버스구분</th>
                  <th scope="col" class="text-center">출발지</th>
                  <th scope="col" class="text-center">도착지</th>
                  <th scope="col" class="text-center">출발일자</th>
                  <th scope="col" class="text-center">출발시간</th>
                  <th scope="col" class="text-center">매수</th>
                  <th scope="col" class="text-center">좌석</th>
                  <th scope="col" class="text-center">상태</th>
              </tr>
              </thead>
              <tbody class="text-center">
              <tr>
                  <td><%=book.getRi_idx() %></td>
                  <td>시외</td>
                  <td>동서울터미널</td>
                  <td>가천대</td>
                  <td>2023.07.10</td>
                  <td>06:20</td>
                  <td>성인 1명 청소년 1명 아동 1명</td>
                  <td>15</td>
                  <td>예매</td>
              </tr>
              <tr>
                  <td>230710AA1002</td>
                  <td>시외</td>
                  <td>동서울터미널</td>
                  <td>가천대</td>
                  <td>2023.07.10</td>
                  <td>06:20</td>
                  <td>성인 1명 청소년 1명 아동 1명</td>
                  <td>15</td>
                  <td>예매</td>
              </tr>
              <tr>
                  <td>230710AA1002</td>
                  <td>시외</td>
                  <td>동서울터미널</td>
                  <td>가천대</td>
                  <td>2023.07.10</td>
                  <td>06:20</td>
                  <td>성인 1명 청소년 1명 아동 1명</td>
                  <td>15</td>
                  <td>예매</td>
              </tr>
              <tr>
                  <td>230710AA1002</td>
                  <td>시외</td>
                  <td>동서울터미널</td>
                  <td>가천대</td>
                  <td>2023.07.10</td>
                  <td>06:20</td>
                  <td>성인 1명 청소년 1명 아동 1명</td>
                  <td>15</td>
                  <td>예매</td>
              </tr>
              <tr>
                  <td>230710AA1002</td>
                  <td>시외</td>
                  <td>동서울터미널</td>
                  <td>가천대</td>
                  <td>2023.07.10</td>
                  <td>06:20</td>
                  <td>성인 1명 청소년 1명 아동 1명</td>
                  <td>15</td>
                  <td>예매</td>
              </tr>
              <tr>
                  <td>230710AA1002</td>
                  <td>시외</td>
                  <td>동서울터미널</td>
                  <td>가천대</td>
                  <td>2023.07.10</td>
                  <td>06:20</td>
                  <td>성인 1명 청소년 1명 아동 1명</td>
                  <td>15</td>
                  <td>예매</td>
              </tr>
              <tr>
                  <td>230710AA1002</td>
                  <td>시외</td>
                  <td>동서울터미널</td>
                  <td>가천대</td>
                  <td>2023.07.10</td>
                  <td>06:20</td>
                  <td>성인 1명 청소년 1명 아동 1명</td>
                  <td>15</td>
                  <td>예매</td>
              </tr>
              </tbody>
          </table>
          <nav aria-label="Page navigation example" class="mt-4">
            <ul class="pagination justify-content-center">
              <li class="page-item">
                <a class="page-link" href="#" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
              <li class="page-item"><a class="page-link" href="#">1</a></li>
              <li class="page-item"><a class="page-link" href="#">2</a></li>
              <li class="page-item"><a class="page-link" href="#">3</a></li>
              <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </ul>
          </nav>
          </div>
        </div>
        <ul>
            <li>예매 내역 및 예매 취소 내역은 과거 3개월까지 조회 가능합니다.</li>
            <li>신용카드 예매 취소 시 일주일 내로 예매했던 카드로 청구 취소 처리가 되면서 반환됩니다.</li>
        </ul>
    </div>
   

</section>
<% } %>
<%@ include file="../_inc/foot.jsp"%>