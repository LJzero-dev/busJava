<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
List<MemberInfo> memberList = (List<MemberInfo>) request.getAttribute("memberList");
PageInfo pi = (PageInfo)request.getAttribute("pi");

String cb = (String)request.getAttribute("schctgr");
if (cb == null) cb = "all:정상:휴면:탈퇴";  
String[] arrcb = cb.split(":");
%>	
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
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

window.onload = function() {
    document.getElementById('schForm').addEventListener('submit', function(event) {

        function chkval() {
            var frm = document.schForm;
            var chk = frm.chk; //schtype라는 이름이 2개이상이면 배열로 들어감 
            var isChecked = false;
            for (var i = 0 ; i < chk.length ; i++ ){
                if (chk[i].checked){
                    isChecked = true;
                    break;
                }
            }
            /* if (!isChecked) {
                alert("검색조건을 선택해주세요.");
                return false;
            }
            var keyword = frm.keyword.value;
            if (keyword == "") {
                alert("검색어를 입력하세요.");
                frm.keyword.focus(); 
                return false;
            } */
            return true;
        }

        function makeCtgr() {
            // 검색폼의 조건들을 쿼리스트링 sch의 값으로 만듦
            var frm = document.schForm;
            var sch = "";
            // 브랜드 조건
            var arr = frm.chk;
            var isFirst = true;
            for (var i = 0; i < arr.length; i++) {
                if (arr[i].checked) {
                    if(isFirst) {
                        isFirst = false;
                        sch += arr[i].value;
                    } else {
                        sch += ":" + arr[i].value;
                    }
                }
            }

              // sch 값을 출력

            document.schForm.hiddenCtgr.value = sch;  
              // hiddenCtgr 필드의 값을 출력
        }

        if (!chkval()) {
            event.preventDefault();
            return;
        }

        makeCtgr();
    });
};


</script>
<div class="page-wrapper">
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">회원 관리</h3>
		</div>
	</div>
	<div class="row">
<div class="col-lg-12">
    <div class="card">
      <form id="schForm" name="schForm" onsubmit="">
      <input type="hidden" id="hiddenCtgr" name="hiddenCtgr" value="" />
        <table class="table table-sm custom">
            <colgroup>
                <col width="20%">
                <col width="*">
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row" class="text-center bg-gray align-middle">검색어</th>
                    <td class="text-left">
                        <div class="d-flex">
		                <select class="form-control w-auto" id="" name="schtype" >
		                    <option value="all" <% if (pi.getSchtype() == "all") { %> selected="selected" <% } %> >전체</option>
							<option value="id" <% if (pi.getSchtype() == "id") { %> selected="selected" <% } %>>아이디</option>
							<option value="email" <% if (pi.getSchtype() == "email") { %> selected="selected" <% } %>>이메일</option>
						</select>
		                <input type="text" class="form-control" name="keyword" value="<%=pi.getKeyword() %>" />
                        </div>
                    </td> 
                <tr>
                    <th scope="row" class="text-center bg-gray">분류</th>
                    <td class="text-left">
                    <div class="d-flex">
                        <div class="form-check form-check-inline">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" value="all" id="all" name="chk" onclick="chkAll(this);"
                       			<% for (int k = 0; k < arrcb.length; k++) { if (arrcb[k].equals("all")) { %> checked="checked" <%} } %> >
                                <label class="custom-control-label" for="all">전체</label>
                            </div>
                        </div>
                        <div class="form-check form-check-inline">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" value="정상" id="customCheck1" name="chk"
                                <%for (int k = 0; k < arrcb.length; k++) { if (arrcb[k].equals("정상")) { %> checked="checked" <% } } %> >
                                <label class="custom-control-label" for="customCheck1">정상</label>
                            </div>
                        </div>
                        <div class="form-check form-check-inline">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" value="휴면" id="customCheck2" name="chk"
                                <%for (int k = 0; k < arrcb.length; k++) { if (arrcb[k].equals("휴면")) { %> checked="checked" <% } } %>>
                                <label class="custom-control-label" for="customCheck2">휴면</label>
                            </div>
                        </div>
                        <div class="form-check form-check-inline">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" value="탈퇴" id="customCheck3" name="chk"
                                <%for (int k = 0; k < arrcb.length; k++) { if (arrcb[k].equals("탈퇴")) { %> checked="checked" <% } } %>>
                                <label class="custom-control-label" for="customCheck3">탈퇴</label>
                            </div>
                        </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="d-flex justify-content-center">
        <input type="submit" class="btn waves-effect waves-light btn-secondary mb-2" value="검색" ></button>
        </div>
       </form>
    </div> 
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <table id="table" class="table text-center mb-0 padding-size-sm">
              <colgroup>
                  <col width="5%">    
                  <col width="10%">
                  <col width="20%">
                  <col width="20%">
                  <col width="8%">
              </colgroup>
              <thead class="bg-primary text-white">
              <tr>
                  <th scope="col" class="text-center">no</th>
                  <th scope="col" class="text-center">아이디</th>
                  <th scope="col" class="text-center">이메일</th>
                  <th scope="col" class="text-center">가입일시</th>
                  <th scope="col" class="text-center">상태</th>
              </tr>
              </thead>
              <tbody class="text-center border border-primary">
<% if (memberList.size() > 0) {
		int j = 1;
		for (MemberInfo mi : memberList) { 
	 %>              
              <tr onclick="qwer(this);" >
                  <td><%=j %></td>
                  <td class="mi_id"><%=mi.getMi_id() %></td>
                  <td><%=mi.getMi_email() %></td>
                  <td><%=mi.getMi_date().substring(0,16).replace("-", ".") %></td>
                  <td><%=mi.getMi_status() %></td>
              </tr>
<%	j++;	
}
				%>
              </tbody>
          	</table>
            <div class="d-flex justify-content-center mt-2">
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
<% 	}
}	%>
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
<% } else {    %>	
        <tr height="50"><td colspan="5" align="center">
		검색결과가 없습니다.
		</td></tr>
<%} %>
        </div> 
    </div>
</div>
<!-- ajax -->
<form name="frmMemUp" action="memberUp" method="post">
<div class="row">
   	<div class="col-md-12 text-center mb-5" style="display: none;" id="memberDetail-container">
   		<div class="card">
       	<div id="memberDetail">
       	</div>
    </div>
</div>
</form>
<!-- ajax -->
</div>
</div>

<!-- ------------------------------------------------------------------------------------------------ -->
<script>
function qwer (elem) {
    const uid = elem.querySelector(".mi_id").innerText;
/* 		alert(uid); */
		$.ajax({
			type : "POST", 
			url : "./memberDetail", 
			data : {"uid" : uid},
			dataType: "json",
			success : function(data){
				if (data.length > 0) {
					let tableHTML = "<table class='table' algin='center' >" + 
					"<colgroup><col width='10%'><col width='10%'><col width='15%'><col width='15%'>" +
					"</colgroup>" + 
					/* <col width='15%'><col width='15%'><col width='10%'><col width='10%'> 
					"<thead class='bg-primary'>" + 
				    "<tr><th scope='col' class='text-center'>아이디</th><td>아이디입력</td>" +
					"<th scope='col' class='text-center'>비밀번호</th><td>비밀번호입력</td>" +
					"<th scope='col' class='text-center'>이메일</th><td>이메일입력</td>" +
					"<th scope='col' class='text-center'>상태</th><td>상태입력</td>" +
					"<th scope='col' class='text-center'>이름/성별</th><td>이름/성별입력</td>" +
					"<th scope='col' class='text-center'>휴대폰번호</th><td>휴대폰번호입력</td>" +
					"<th scope='col' class='text-center'>보유페이머니</th><td>보유페이머니입력</td>" +
					"<th scope='col' class='text-center'>보유스템프</th><td>보유스템프입력</td>" +
					"<th scope='col' class='text-center'>보유쿠폰</th><td>보유쿠폰입력</td>" +
					"<th scope='col' class='text-center'>가입일시</th><td>가입일시입력</td>" + 
					"</tr> 
					"</thead>*/
					"<tbody>";
					
					data.forEach(function(table) {
	                    tableHTML += "<tr><th scope='col' class='text-center'>아이디</th>";
	                    tableHTML += "<td>" + table.mi_id + "</td>";
	                    tableHTML += "<input type='hidden' name='mi_id' value='" + table.mi_id + "' />" ;
	                    tableHTML += "<th scope='col' class='text-center'>비밀번호</th>";
	                    tableHTML += "<td>" + table.mi_pw + "</td><tr>";
	                    tableHTML += "<tr><th scope='col' class='text-center align-middle'>이메일</th>";
	                    tableHTML += "<td class='align-middle'>" + table.mi_email + "</td>";
	                   /*  tableHTML += "<th scope='col' class='text-center'>상태</th>";
	                    tableHTML += "<td>" + table.mi_status + "</td>"; */
	                    tableHTML += "<th scope='col' class='text-center align-middle'>상태</th>";
	                    tableHTML += "<td><select class='form-control w-auto' name='mi_status' style='margin:0 auto'><option " + (table.mi_status === '정상' ? "selected='selected'" : "") + ">정상</option><option " + (table.mi_status === '휴면' ? "selected='selected'" : "") + ">휴면</option><option " + (table.mi_status === '탈퇴' ? "selected='selected'" : "") + ">탈퇴</option></select></td>";
	                    tableHTML += "<tr><th scope='col' class='text-center'>이름/성별</th>";
	                    tableHTML += "<td>" + table.mi_name + "/" + table.mi_gender + "</td>";
	                    tableHTML += "<th scope='col' class='text-center'>번호</th>";
	                    tableHTML += "<td>" + table.mi_phone + "</td>";
	                    tableHTML += "<tr><th scope='col' class='text-center align-middle'>보유페이머니</th>";
	                    tableHTML += "<td><input class='form-control'  type='text' style='width:100px; border:0.1; text-align:center; margin: 0 auto' name='mi_pmoney' value='" + table.mi_pmoney +"' /></td>";
	                   /*  tableHTML += "<th scope='col' class='text-center'>스템프</th>";
	                    tableHTML += "<td>" + table.mi_stamp + "</td>";
	                    tableHTML += "<tr><th scope='col' class='text-center'>쿠폰</th>";
	                    tableHTML += "<td>" + table.mi_coupon + "</td>"; */
	                    tableHTML += "<th scope='col' class='text-center'>가입일시</th>";
	                    tableHTML += "<td>" + table.mi_date + "</td>";
	                    tableHTML += "</tr>";
	                });
	                tableHTML += "</tbody></table><div class='btn-wrap mb-3'>";
	                tableHTML += "<button type='submit' class='btn waves-effect waves-light btn-primary btn-lg m-auto' >수정</button>&nbsp;&nbsp;&nbsp;";  
	                tableHTML += "<button type='button' class='btn waves-effect waves-light btn-primary btn-lg m-auto' onclick='location.href=\"memberList\"'>확인</button></div>";
				
				$("#memberDetail").html(tableHTML);
	            $("#memberDetail-container").show();
	        } else {
	            // 데이터가 없는 경우
	            alert("회원이 없습니다.");
	            $("#memberDetail").empty();
	            $("#memberDetail-container").hide();
	        }
		 },
		 error: function(jqXHR, textStatus, errorThrown) {
			    console.error("AJAX Error: " + textStatus);
			    console.error("HTTP Error: " + errorThrown);
			    console.error("Server Response: " + jqXHR.responseText);
			}
	    });
	};
</script>
<%@ include file="../_inc/foot.jsp" %>