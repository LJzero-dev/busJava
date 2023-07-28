<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
List<BookInfo> bookList = (List<BookInfo>) request.getAttribute("bookList");
PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
//View로 넘어갈때  cpage번호랑 예매번호 가지고 가야함
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
                  <col width="10%">
                  <col width="10%">
                  <col width="10%">
                  <col width="15%">
                  <col width="10%">
                  <col width="27%">
                  <col width="8%">
                  <col width="10%">
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
<% for (BookInfo bl : bookList) {  
// 최근 3개월 조건 필요
// 좌석 번호 여러개 나와야함
%>
            <tr> <!-- 이동할 주소입력(ri_idx값 들고 가야함) -->
                  <td><a href="bookDetail<%=pi.getArgs() %>&riidx=<%=bl.getRi_idx() %>"><%=bl.getRi_idx() %></a></td>
                  <td><%=bl.getBl_type() %></td>
                  <td><%=bl.getBt_sidx() %></td>
                  <td><%=bl.getBt_eidx() %></td>
                  <td><%=bl.getRi_sday() %></td>
                  <td><%=bl.getBs_stime() %></td>
                  <td>성인 <%=bl.getRi_acnt() %>명&nbsp;청소년 <%=bl.getRi_scnt() %>명&nbsp;아동 <%=bl.getRi_ccnt() %>명&nbsp;</td>
				<td>
<% 
StringBuilder seats = new StringBuilder();
if (bl.getBusSeatList().size() > 0) {
  for (BusSeatList bs : bl.getBusSeatList()) {    
    if (seats.length() != 0) {
      seats.append(",");
    }
    seats.append(bs.getSi_seat());
  } 
}    
%>       
<%=seats.toString() %>         
				</td>
                  <td><%=bl.getRi_status() %></td>
              </tr>
<% } %>    
              </tbody>
          </table>

          <nav aria-label="Page navigation example" class="mt-4">
            <ul class="pagination justify-content-center">
<% if (pi.getCpage() == 1 ) { %>          
              <li class="page-item">
                  <span class="page-link" aria-hidden="true">&laquo;</span>
              </li>
<% } else if (pi.getCpage() > 1)  { %>
			 <li class="page-item">
                <a class="page-link" href="booking?cpage=<%=pi.getCpage() - 1 %>" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
<% }
int endPage = (pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt()) ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt();
for (int i = pi.getSpage(); i <= endPage; i++) { 
	if (i == pi.getCpage()) {
%>
            <li class="page-link" ><%=i%></li>
<% } else if (i != pi.getCpage()) { %>
			<li class="page-item"><a class="page-link" href="booking?cpage=<%=i%>"><%=i%></a></li>
<% }
}%>
<%  if (pi.getCpage() < pi.getPcnt()) { %>             
              <li class="page-item">
                <a class="page-link" href="booking?cpage=<%=pi.getCpage() + 1 %>" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
<% } else if (pi.getCpage() == pi.getPcnt()) { %>     
				<li class="page-item">
                  <span class="page-link" aria-hidden="true">&raquo;</span>
            	</li>
<% } %>         
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
<%@ include file="../_inc/foot.jsp"%>