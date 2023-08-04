<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
List<MemberInfo> memberList = (List<MemberInfo>) request.getAttribute("memberList");
PageInfo pi = (PageInfo)request.getAttribute("pi");
/* PageInfo pi = (PageInfo)request.getAttribute("pageInfo"); */
%>
<script>
function chkAll() {
	  var allCheckbox = document.getElementById("all");
	  var checkboxes = document.getElementsByName("chk");

	  if (allCheckbox.checked) {
	    for (var i = 0; i < checkboxes.length; i++) {
	      checkboxes[i].checked = true;
	    }
	    allCheckbox.closest(".allchkbox").classList.add("active");
	  } else {
	    for (var i = 0; i < checkboxes.length; i++) {
	      checkboxes[i].checked = false;
	    }
	    allCheckbox.closest(".allchkbox").classList.remove("active");
	  }
	}

document.addEventListener("click", function(e) {
 if (e.target && e.target.name === "chk") {
     var checkboxes = document.getElementsByName("chk");
     var chksChecked = 0;
     for (var i = 0; i < checkboxes.length; i++) {
         var checkbox = checkboxes[i];
         if (checkbox.checked) {
             chksChecked++;
          }
       }
       var allCheckbox = document.getElementById("all");

       if (checkboxes.length === chksChecked) {
         allCheckbox.checked = true;
         allCheckbox.closest(".allchkbox").classList.add("active");
       } else {
         allCheckbox.checked = false;
         allCheckbox.closest(".allchkbox").classList.remove("active");
       }
    }
});

</script>
<section class="probootstrap_section">
    <div class="container">
        <div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated mb-0">
          <div class="col-md-12">
            <h2 class="border-bottom mb-5 probootstrap-section-heading">회원 목록</h2>
          </div>
    <form name="frmSch">
	<fieldset>
		<legend>회원관리</legend>
		<table>
		<tr>
		<th>검색어</th>
		<th colspan="2">
		<select name="schtype">
			<option value="all" <% if (pi.getSchtype() == "all") { %> selected="selected" <% } %> >전체</option>
			<option value="id" <% if (pi.getSchtype() == "id") { %> selected="selected" <% } %>>아이디</option>
			<option value="email" <% if (pi.getSchtype() == "email") { %> selected="selected" <% } %>>이메일</option>
		</select>
		<input type="text" name="keyword" value="" />
		<input type="submit" value="검색" />
		<input type="button" value="전체글" onclick="location.href='memberList';" />
		</th>
		</tr>
		<tr>
		<th>회원상태</th>
		<th>
		<div class="allchkbox" onclick="chkAll();"><input type="checkbox" name="chkall" id="all" /><label class="form-check-label" for="all">전체</label></div>
		<input type="checkbox" name="chk" id="chkA" value="정상" /><label class="form-check-label" for="chkA">정상</label>
		<input type="checkbox" name="chk" id="chkB" value="휴면" /><label class="form-check-label" for="chkB">휴면</label>
		<input type="checkbox" name="chk" id="chkC" value="탈퇴" /><label class="form-check-label" for="chkC">탈퇴</label>
		</th>
		</tr>
		</table>
	</fieldset>
	</form>
        </div>
        <div class="row">
          <div class="col-md-12">
            <table id="memList" class="table table-hover">
              <colgroup>
                  <col width="5%">    
                  <col width="10%">
                  <col width="20%">
                  <col width="20%">
                  <col width="8%">
              </colgroup>
              <thead>
              <tr>
                  <th scope="col" class="text-center">no</th>
                  <th scope="col" class="text-center">아이디</th>
                  <th scope="col" class="text-center">이메일</th>
                  <th scope="col" class="text-center">가입일시</th>
                  <th scope="col" class="text-center">상태</th>
              </tr>
              </thead>
              <tbody class="text-center">
<% if (memberList.size() > 0) {
		for (MemberInfo mi : memberList) { 
			for (int i = 1; i <= memberList.size(); i++) { %>              
              <tr onclick="">
                  <td><%=i %></td>
                  <td><%=mi.getMi_id() %></td>
                  <td><%=mi.getMi_email() %></td>
                  <td><%= mi.getMi_date().substring(0,16).replace("-", ".") %></td>
                  <td><%= mi.getMi_status() %></td>
              </tr>
<%			}
		}
	} else {    %>	
        <tr height="50"><td colspan="5" align="center">
		검색결과가 없습니다.
		</td></tr>
<%} %>
              </tbody>
          </table>
          </div>
        </div>
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
<% }  %>         
            </ul>
          </nav>
    </div>

</section>
<%@ include file="../_inc/foot.jsp" %>