<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

List<BusLineInfo> busLineList = (List<BusLineInfo>)request.getAttribute("busLineList");
List<BusInfo> busInfo = (List<BusInfo>)request.getAttribute("busInfo");

%>
<script>
function delLine(lineNum) {
	var bt_idx = <%=request.getParameter("bt_idx") %>;
	var bt_name = "<%=request.getParameter("bt_name") %>";
	if(confirm("해당 노선을 정말 삭제하시겠습니까?\n삭제 후 복구 불가능합니다.")){
		location.href="LineDel?bt_idx=" + bt_idx + "&bt_name=" + bt_name + "&lineNum=" + lineNum;
	}
}

function openModal(area) {
	var bt_name = "<%=request.getParameter("bt_name") %>";
	$('#AddLine .modal-content').load("/adminbusj/popUpLineAdd?bt_idx=" + 
	<%=request.getParameter("bt_idx")%> + "&bt_name=" + bt_name);
	$('#AddLine').modal();
}

function adultGyesan(sale) {
	var adult = document.getElementById("adult");
	var teenager = document.getElementById("teenager");
	var children = document.getElementById("children");
	var numericSale = parseInt(sale.replace(/,/g, ''), 10); // 쉼표 제거 후 정수로 변환
	
	if (!isNaN(numericSale)) {
        adult.value = numericSale.toLocaleString('ko-KR');
        teenager.value = Math.floor(numericSale * 0.8).toLocaleString('ko-KR');
        children.value = Math.floor(numericSale * 0.5).toLocaleString('ko-KR');
    } else {
        // 입력된 값이 숫자로 변환될 수 없는 경우, 텍스트 박스를 빈 값으로 설정
        adult.value = "";
        teenager.value = "";
        children.value = "";
    }
}

function restrictAdult(input) {
	input.value = input.value.replace(/[^0-9]/g, '');
}

</script>
<style>
.timepicker { width:100px; text-align:center; }
.form-control { text-align:center; }
.paddingRL { padding:10px 30px; }
</style>
<body>
<section class="probootstrap_section">
<div class="page-wrapper">     
<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
    </div>
</div>
<div class="page-breadcrumb">
	<div class="row">
		<div class="col-7 align-self-center">
			<h3 class="page-title text-truncate text-dark font-weight-medium mb-1"><%=request.getParameter("bt_name") %>고속버스 터미널 시간표 관리
			<button type="button" class="btn waves-effect waves-light btn-primary ml-5" 
			onclick="openModal();">노선추가</button>
			</h3>
		</div>
	</div>
</div> 
<div class="container-fluid">

<% for (BusLineInfo bl : busLineList) { %>
	<div class="row">
		<div class="col-lg-12">
		<div class="d-flex justify-content-between p-1 align-items-center">
			<p class="h3 text-primary"><%=bl.getBt_name() %>고속버스터미널</p>
			<div class="d-flex justify-content-between float_right">
			<button type="button" class="btn float-right btn-outline-danger btn-lg mr-1" id="bl_idx" 
			value="<%=bl.getBl_idx() %>" onclick="delLine(this.value);">노선삭제</button>
			<button type="button" class="btn waves-effect waves-light btn-primary btn-lg" id="seoul" value="<%=bl.getBl_idx() %>"
			 onclick="scheduleAdd(this.value);">추가</button>
			</div>		
		</div>
		<div class="card">
		<form name="frmIn" action="" method="">
		<table class="table text-center mb-0 padding-size-sm">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="12%">
				<col width="*">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="12%">
			</colgroup>
            <thead class="bg-primary text-white">
                <tr>
                    <th>출발시간</th>
                    <th>도착시간</th>
                    <th>회사명</th>
                    <th>차량번호</th>
                    <th>등급</th>
                    <th>성인요금</th>
                    <th>청소년요금</th>
                    <th>아동요금</th>
                    <th>수정/삭제</th>
                </tr>
            </thead>
<% 
	if (bl.getBusScheduleInfo().size() > 0) {
		for (BusScheduleInfo bs : bl.getBusScheduleInfo()) {
			
%>
            
            <tbody class="border border-primary ">
                <tr>
                    <td><input type="text" class="text-center" style="width:100px; border:0;"  
                    value="<%=bs.getBs_stime() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" style="width:100px; border:0;"  
                    value="<%=bs.getBs_etime() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" style="width:100px; border:0;" 
                    value="<%=bs.getBc_name() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" style="width:100px; border:0;"  
                    value="<%=bs.getBi_num() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" style="width:100px; border:0;" 
                    value="<%=bs.getBi_level() %>" readonly="readonly" /></td>
<% 
String tmp = "";
String tmp1 = "";
String tmp2 = "";
tmp += Math.round(bl.getBl_adult() * 0.8);
tmp1 += Math.round(bl.getBl_adult());
tmp2 += Math.round(bl.getBl_adult() * 0.5);

StringBuffer sb = new StringBuffer();
StringBuffer sb1 = new StringBuffer();
StringBuffer sb2 = new StringBuffer();

sb.append(tmp);
if (tmp.length() > 7)
	sb.insert(3, ",");
sb.insert(2, ",");

sb1.append(tmp1);
if (tmp1.length() > 7)
	sb1.insert(3, ",");
sb1.insert(2, ",");

sb2.append(tmp2);
if (tmp2.length() > 7)
	sb2.insert(3, ",");
sb2.insert(2, ",");

%>
					<td><input type="text" class="text-center" style="width:100px; border:0;" 
                    value="<%=sb1 %>원" readonly="readonly" /></td>
					<td><input type="text" class="text-center" style="width:100px; border:0;" 
                    value="<%=sb %>원" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" style="width:100px; border:0;" 
                    value="<%=sb2 %>원" readonly="readonly" /></td>
                    <td>수정, 삭제</td>
                </tr>
            </tbody>
<%
		} 
	} else {
%>
			<tbody class="border border-primary">
            	<tr>
            		<td colspan="8">운행중인 시간표가 없습니다.</td>
            	</tr>
            </tbody>
<%	} %>
			
			<tbody class="border border-primary">
                <tr style="" id="dis">
                    <td>
    					<input type="text" name="time1" id="time1" class="timepicker mt-1" oninput="updateTime2Options(this.value);" >
				    </td>
                    <td>
                    	<input type="text" name="time2" id="time2" class="timepicker mt-1" >
                    </td>
                    <td style="padding:10px 20px;">
                    <select class="form-control text-center" id="company" name="company" onchange="companyChange();">
                    	<option value="">회사명</option>
                    	<option>금호고속</option>
                    	<option>동부고속</option>
                    	<option>동양고속</option>
                    	<option>중앙고속</option>
                    </select>
                    </td>
                    <td style="padding:10px 50px;">
                    <select class="form-control text-center" id="number" name="number">
                    	<option value="">차량번호</option>
<% for (BusInfo bi : busInfo) { %>
						<option value="<%=bi.getBc_name() %>"><%=bi.getBi_num() %></option>
<% } %>
                    </select>
                    </td>
                    <td style="padding:10px 20px;">
                    <select class="form-control text-center" name="level">
                    	<option value="">등급</option>
                    	<option>우등</option>
                    	<option>프리미엄</option>
                    </select>
                    </td>
                    <td><input type="text" class="text-right mt-1" style="width:80px;" id="adult" oninput="restrictAdult(this)" 
                    onkeyup="adultGyesan(this.value);" maxlength="7" />원</td>
                    <td><input type="text" class="text-right mt-1" style="width:80px; border:0; text-align:center" id="teenager" readonly="readonly" />원</td>
                    <td><input type="text" class="text-right mt-1" style="width:80px; border:0;" id="children" readonly="readonly" />원</td>
                    <td><input class="btn waves-effect waves-light btn-primary" type="button" value="등록" /></td>
                </tr>
            </tbody>
        </table>
        </form>
		</div>
		</div>
	</div>
<% } %>
	
</div>
</div>
<div class="modal fade" id="AddLine" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>
</section>
<script>

$(function () {
    $("#time1").timepicker({
        timeFormat: 'HH:mm',
        interval: 10,
        minTime: '00:00',
        maxTime: '23:59',
        defaultTime: '06:00',
        startTime: '06:00',
        dynamic: false,
        dropdown: true,
        scrollbar: true,
        change: function (time) {
            var from_time = $("#time1").val(); // time1에서 선택한 값
            $("#time2").timepicker('option', 'minTime', from_time); // time2의 minTime 변경

            // time2가 time1보다 작은 경우, time2를 time1과 동일하게 설정
            if ($("#time2").val() && $("#time2").val() < from_time) {
                $("#time2").timepicker('setTime', from_time);
            }
        }
        
    });
      

    $("#time2").timepicker({
        timeFormat: 'HH:mm',
        interval: 10,
        minTime: '00:00',
        maxTime: '23:59',
        defaultTime: '07:00',
        startTime: '07:00',
        dynamic: false,
        dropdown: true,
        scrollbar: true
        
    });
    
});


function companyChange() {
	var inputStateValue = document.getElementById('company').value;
	var numberOptions = document.getElementById('number').options;

	for (var i = 0; i < numberOptions.length; i++) {
		var option = numberOptions[i];
		var option2 = option.value;
		var arrOption = option2.split(":");
	    if (inputStateValue == '' || arrOption[0] == inputStateValue) {
	    	option.style.display = 'block';
	    	
	    } else {
	    	option.style.display = 'none';
		}
		
	}
}

</script>
<%@ include file="../_inc/foot.jsp" %>