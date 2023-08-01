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

function companyChange(){
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
var chk = true;
function numberChange(blidx){
	var number = document.getElementById('number').value;
	var arr = number.split(":");
	var carId = arr[1];
	
	if (carId != "") {
		$.ajax({
			type : "POST", 				
			url : "./changeLevel", 
			data : {"number" : carId}, 		
			success : function(chkRs){	
				var msg = "";
				if (chkRs == 0) {	
					msg = "<input type='text' class='text-center mt-1' id='level' style='width:100px; border:0; text-align:center' value='우등' readonly='readonly' />";
					
					if (!chk) {
						var sale1Value = parseFloat(document.getElementById("common" + blidx).value.replace(",", "")) / 1.5;
	                    var sale2Value = parseFloat(document.getElementById("teenager" + blidx).value.replace(",", "")) / 1.5;
	                    var sale3Value = parseFloat(document.getElementById("child" + blidx).value.replace(",", "")) / 1.5;
	                    document.getElementById('common' + blidx).value = formatNumber(sale1Value) + "원";
	                    document.getElementById('teenager' + blidx).value = formatNumber(sale2Value) + "원";
	                    document.getElementById('child' + blidx).value = formatNumber(sale3Value) + "원";
	                    chk = true;
					}
					
				} else {	
					msg = "<input type='text' class='text-center mt-1' id='level' style='width:100px; border:0; text-align:center' value='프리미엄' readonly='readonly' />";
					
					if (chk) {
						var sale1Value = parseFloat(document.getElementById('common' + blidx).value.replace(",", "")) * 1.5;
	                    var sale2Value = parseFloat(document.getElementById('teenager' + blidx).value.replace(",", "")) * 1.5;
	                    var sale3Value = parseFloat(document.getElementById('child' + blidx).value.replace(",", "")) * 1.5;
	                    document.getElementById('common' + blidx).value = formatNumber(sale1Value) + "원";
	                    document.getElementById('teenager' + blidx).value = formatNumber(sale2Value) + "원";
	                    document.getElementById('child' + blidx).value = formatNumber(sale3Value) + "원";
	                    chk = false;
					}
					
                    
				}
				$("#msg").html(msg);
			}
		});
	}
}

function formatNumber(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function delShcedule(bsidx) {
	if(confirm('정말 삭제하시겠습니까?')) {
		$.ajax({
			type : "POST", 				
			url : "./delShcedule", 
			data : {"bsidx" : bsidx}, 		
			success : function(chkRs){	
				if (chkRs == 1) {	
					location.reload();
				} else {	
					alert('삭제에 실패했습니다.');
				}
			}
		});
	}
	event.preventDefault(); // form 액션 실행을 막음
}

function scheduleAdd(blidx) {
	var tbodyElement = document.getElementById("disAdd" + blidx);
		if (tbodyElement) {
		tbodyElement.style.display = "";
	}
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
		<form name="frmIn" action="scheduleAdd" method="post">
		<input type="hidden" name="bl_idx" value="<%=bl.getBl_idx() %>" />
		<input type="hidden" name="bt_idx" value="<%=request.getParameter("bt_idx") %>" />
		<input type="hidden" name="bt_name" value="<%=request.getParameter("bt_name") %>" />
		<input type="hidden" name="adult<%=bl.getBl_idx() %>" value="<%=bl.getBl_adult() %>" />
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
                    <th>삭제</th>
                </tr>
            </thead>
<% 
	if (bl.getBusScheduleInfo().size() > 0) {
		for (BusScheduleInfo bs : bl.getBusScheduleInfo()) {
			
%>
            
            <tbody class="border border-primary ">
                <tr>
                    <td><input type="text" class="text-center" name="stime" style="width:100px; border:0;"  
                    value="<%=bs.getBs_stime() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" name="etime" style="width:100px; border:0;"  
                    value="<%=bs.getBs_etime() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" name="bc_name" style="width:100px; border:0;" 
                    value="<%=bs.getBc_name() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" name="bi_num" style="width:100px; border:0;"  
                    value="<%=bs.getBi_num() %>" readonly="readonly" /></td>
                    <td><input type="text" class="text-center" name="bi_level" style="width:100px; border:0;" 
                    value="<%=bs.getBi_level() %>" readonly="readonly" /></td>
<% 
String tmp = "";
String tmp1 = "";
String tmp2 = "";

if (bs.getBi_level().equals("프리미엄")) {
	tmp += Math.round(bl.getBl_adult() * 1.5 * 0.8);
	tmp1 += Math.round(bl.getBl_adult() * 1.5);
	tmp2 += Math.round(bl.getBl_adult() * 1.5 * 0.5);
} else {
	tmp += Math.round(bl.getBl_adult() * 0.8);
	tmp1 += Math.round(bl.getBl_adult());
	tmp2 += Math.round(bl.getBl_adult() * 0.5);	
}
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
                    <td style="padding:5px;">
                    <button class="btn waves-effect waves-light btn-primary" value="<%=bs.getBs_idx() %>"
                    onclick="delShcedule(this.value);">삭제</button>
                    </td>
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
			
			<tbody id="disAdd<%=bl.getBl_idx() %>" style="display:none;" class="border border-primary">
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
                    <select class="form-control text-center" id="number" name="number" onchange="numberChange(<%=bl.getBl_idx() %>);">
                    	<option value="">차량번호</option>
<% for (BusInfo bi : busInfo) { %>
						<option value="<%=bi.getBc_name() %>:<%=bi.getBi_num() %>"><%=bi.getBi_num() %></option>
<% } %>
                    </select>
                    </td>
                    <td style="padding:10px 20px;">
                    <span id="msg"><input type='text' class='text-center mt-1' id='level' style='width:100px; border:0; text-align:center' value='우등' readonly='readonly' /></span>
                    </td>
<%
String tmp1 = "";
String tmp2 = "";
String tmp3 = "";
tmp1 += Math.round(bl.getBl_adult());
tmp2 += Math.round(bl.getBl_adult() * 0.8);
tmp3 += Math.round(bl.getBl_adult() * 0.5);
StringBuffer sb1 = new StringBuffer();
StringBuffer sb2 = new StringBuffer();
StringBuffer sb3 = new StringBuffer();

sb1.append(tmp1);
if (tmp1.length() > 7)
	sb1.insert(3, ",");
sb1.insert(2, ",");

sb2.append(tmp2);
if (tmp2.length() > 7)
	sb2.insert(3, ",");
sb2.insert(2, ",");

sb3.append(tmp3);
if (tmp3.length() > 7)
	sb3.insert(3, ",");
sb3.insert(2, ",");

%>
                    <td><input type="text" id="common<%=bl.getBl_idx() %>" class="text-center mt-1" style="width:100px; border:0; text-align:center" 
                    value="<%=sb1 %>원" readonly="readonly" /></td>
                    <td><input type="text" id="teenager<%=bl.getBl_idx() %>" class="text-center mt-1" style="width:100px; border:0; text-align:center" 
                    value="<%=sb2 %>원" readonly="readonly" /></td>
                    <td><input type="text" id="child<%=bl.getBl_idx() %>" class="text-center mt-1" style="width:100px; border:0; text-align:center" value="<%=sb3 %>원" readonly="readonly" /></td>
                    <td><input class="btn waves-effect waves-light btn-primary" type="submit" value="등록" /></td>
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
    $(".timepicker").timepicker({
        timeFormat: 'HH:mm',
        interval: 10,
        minTime: '00:00',
        maxTime: '23:59',
        defaultTime: '06:00',
        startTime: '06:00',
        dynamic: false,
        dropdown: true,
        scrollbar: true
        /*
        change: function (time) {
            var from_time = $("#time1").val(); // time1에서 선택한 값
            $("#time2").timepicker('option', 'minTime', from_time); // time2의 minTime 변경

            // time2가 time1보다 작은 경우, time2를 time1과 동일하게 설정
            if ($("#time2").val() && $("#time2").val() < from_time) {
                $("#time2").timepicker('setTime', from_time);
            }
        }*/
        
    });
      
/*
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
        
    });*/
    
});

</script>
<%@ include file="../_inc/foot.jsp" %>