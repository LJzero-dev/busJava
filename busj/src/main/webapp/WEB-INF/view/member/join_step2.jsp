<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<!DOCTYPE html>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
/* 아이디 */
function restrictId(input) {
	input.value = input.value.replace(/[^a-zA-Z0-9]/g, '');
}
function chkDupId(uid) {
	if (uid.length >= 4) {
		$.ajax({
			type : "POST", url : "./dupId", data : {"uid" : uid},
			success : function(chkRs){
				var msg = "";
				if (chkRs == 0) {
					msg = "<div class='valid-feedback text-left'>사용가능한 아이디 입니다.</div>";
					$("#idChk").val("y");
					$("#mi_id").removeClass("is-invalid").addClass("is-valid");
				} else {
					msg = "<div class='valid-feedback text-left' style='color: red;'>이미 사용중인 아이디 입니다.</div>";
					$("#idChk").val("n");
					$("#mi_id").removeClass("is-valid").addClass("is-invalid");
				}
				$("#idMsg").html(msg); // .html : ()안의 태그를 바꿔라
			}
		});
		$("#idChk").val("y");
	} else {
		$("#idMsg").text("아이디는 4 ~ 20자로 입력하세요."); // .text :()안의 내용을 바꿔라
		$("#idChk").val("n"); //기본적으로 val값이 "n"이지만  4자 이상 입력했다가 지웠을 경우를 대비해서 넣어줌
		$("#mi_id").removeClass("is-valid").addClass("is-invalid");
	}
}

/* 비밀번호 */
function restrictPw(input) {
	input.value = input.value.replace(/[^a-zA-Z0-9!@#$%^&*()_+=\-[\]{}|\\:;"'<>,.?/~`]/g, '');
}

function checkPassword() {
	var passwordInput = document.getElementById("mi_pw");
	var passwordchkInput = document.getElementById("mi_pw2");
	var pwDup = document.getElementById("pwDup");
	
	var mi_pw = passwordInput.value;
	var mi_pw2 = passwordchkInput.value;
	var pwRed = document.getElementById("pwRed");

	if (mi_pw === mi_pw2) {
		if(mi_pw.length < 4 || mi_pw.length > 15) {
			
			pwDup.value = "n";
			passwordInput.focus();
		}else {
			pwRed.innerHTML = "<div class='valid-feedback text-left' >비밀번호가 일치합니다.</div>";
			$("#mi_pw").removeClass("is-invalid").addClass("is-valid");
			$("#mi_pw2").removeClass("is-invalid").addClass("is-valid");
			pwDup.value = "y";
		}
	} else if (mi_pw.length < 4 || mi_pw2.length < 4 ){
		 pwRed.innerHTML = "<div class='valid-feedback text-left' style='color: red;' >4-15자의 영문, 숫자, 특수문자로 입력해주세요.</div>";
		 $("#mi_pw").removeClass("is-invalid").addClass("is-invalid");
		 $("#mi_pw2").removeClass("is-invalid").addClass("is-invalid");
		 pwDup.value = "n";
	} else {
		 pwRed.innerHTML = "<div class='valid-feedback text-left' style='color: red;' >비밀번호가 일치하지않습니다.</div>";
		 $("#mi_pw").removeClass("is-invalid").addClass("is-invalid");
		 $("#mi_pw2").removeClass("is-invalid").addClass("is-invalid");
		 pwDup.value = "n";
	}
}
/* 이메일 */
function restrictEm1(input) {
	input.value = input.value.replace(/[^a-zA-Z0-9!#$%^&*()_+=\-[\]{}|\\:;"'<>,.?/~`]/g, '');
}
function restrictEm2(input) {
	input.value = input.value.replace(/[^a-zA-Z0-9.]/g, '');
}

$(document).ready(function() { // .ready : 문서가 다 읽힌 다음에 작동해라
	$("#e2").change(function() {
		if ($(this).val() == "") {
			$("#e3").val("");
		} else if ($(this).val() == "direct") {
			$("#e3").val("").prop("disabled", false).focus();
		} else {
			$("#e3").val($(this).val()).prop("disabled", true);
		}
	})
}); 


function mailButtonClick() {
  var e1Value = document.getElementById('e1').value;
  var e3Value = document.getElementById('e3').value;
  var mailChk = document.getElementById('mailChk');
  	if (e1Value === "" || e3Value === "") {
	    alert("이메일을 입력해주세요.");
	    mailChk.value = "n";
	    return;
	}
  chkDupMail(e1Value, e3Value); // 변수에 담은 값들을 함수에 전달
}


function chkDupMail(e1, e3) {
	if (e1 != null && e3 != null) {
		$.ajax({
			type : "POST", url : "./dupMail", data : {"e1" : e1, "e3" : e3 },
			success : function(chkRs){
				var msg = "";
				if (chkRs == 0) {
					msg = "<div class='valid-feedback text-left'>사용가능한 이메일 입니다.</div>";
					$("#mailChk").val("y");
				} else {
					msg = "<div class='valid-feedback text-left' style='color: red;'>이미 등록된 이메일 입니다.</div>";
					$("#mailChk").val("n");
				}
				$("#mailMsg").html(msg); // .html : ()안의 태그를 바꿔라
			}
		});
		$("#mailChk").val("y");
	} else {
		$("#mailChk").val("n"); //기본적으로 val값이 "n"이지만  4자 이상 입력했다가 지웠을 경우를 대비해서 넣어줌
	}
}

/* 전화번호 */
function phoneButtonClick() {
  var p2Value = document.getElementById('p2').value;
  var p3Value = document.getElementById('p3').value;
  var phoneChk = document.getElementById('phoneChk');
  	if (p2Value === "" || p3Value === "") {
	    alert("전화번호를 입력해주세요.");
	    phoneChk.value = "n";
	    return;
	} else if ((p2Value.length < 4 || p3Value.length < 4)){
		alert("전화번호를 확인 해주세요.");
		phoneChk.value = "n";
	    return;
	}
  	chkDupPhone(p2Value, p3Value); // 변수에 담은 값들을 함수에 전달
}


function chkDupPhone(p2, p3) {
	if (p2 != null && p3 != null) {
		$.ajax({
			type : "POST", url : "./dupPhone", data : {"p2" : p2, "p3" : p3 },
			success : function(chkRs){
				var msg = "";
				if (chkRs == 0) {
					msg = "<div class='valid-feedback text-left'>사용가능한 번호 입니다.</div>";
					$("#phoneChk").val("y");
				} else {
					msg = "<div class='valid-feedback text-left' style='color: red;'>이미 등록된 번호 입니다.</div>";
					$("#phoneChk").val("n");
				}
				$("#phoneMsg").html(msg); // .html : ()안의 태그를 바꿔라
			}
		});
		$("#phoneChk").val("y");
	} else {
		$("#phoneChk").val("n");
	}
}

/* 메일 변화 여부 */
function checkMchange(){
	var mailChk = document.getElementById('mailChk');
	mailChk.value = 'n';
	return;
}

/* 번호 숫자 4자리 여부 */
function checkPlength(){
	var p2 = document.getElementById('p2').value;
	var p3 = document.getElementById('p3').value;
	var phoneChk = document.getElementById('phoneChk');
	
	if (p2.length < 4 || p3.length < 4){
		phoneChk.value = 'n';
		return;
	}
}

/* 전체 점검 */
document.getElementById('signIn').addEventListener('click', function(event) {
    var idChk = document.getElementById('idChk').value;
    var pwDup = document.getElementById('pwDup').value;
    var mailChk = document.getElementById('mailChk').value;
    var phoneChk = document.getElementById('phoneChk').value;
    
/*     var e3 = document.getElementById('e3').value; */
    /* alert(e3); */
    
 	if (!(idChk=== 'y' && pwDup === 'y' && mailChk === 'y' && phoneChk === 'y')) {
        alert('중복검사를 확인하여주세요.');
        event.preventDefault(); // 이벤트의 기본 동작(폼 제출)을 막음
    }
});

</script>

<section class="probootstrap_section" id="section-city-guides">
<div class="container">
	<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
		<div class="col-md-12">
			<h2 class="display-5 border-bottom probootstrap-section-heading">회원가입</h2>
				<div class="col-md-8 m-auto">
					<div class="progress-bar-custom">
						<div class="progress-step">
							<div class="step-count"></div>
							<div class="step-description">약관 동의</div>
						</div>
						<div class="progress-step is-active">
							<div class="step-count"></div>
							<div class="step-description">정보입력</div>
						</div>
						<div class="progress-step">
						<div class="step-count"></div>
					<div class="step-description">가입완료</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<form name="frmJoin" action=memberJoinStep2 method="post">
<input type="hidden" name="idChk" id="idChk" value="n" />
<input type="hidden" id="pwDup" name="pwDup" value="n" />
<input type="hidden" name="mailChk" id="mailChk" value="n" />
<input type="hidden" name="phoneChk" id="phoneChk" value="n" />
<div class="row">
	<div class="col-md-8 mb-3 m-auto">
		<table class="table text-center">
		<colgroup>
			<col width="25%">
			<col width="*">
		</colgroup>
		<tbody>
		<tr>
			<th>이름</th>
			<td><input type="text" class="form-control" id="mi_name" name="mi_name" required /></td>
		</tr>
		<tr>
		<th>아이디</th>
			<td><!-- form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="text" class="form-control is-invalid" name="mi_id" id="mi_id" 
				placeholder="4-15자의 영문, 숫자로 입력해주세요." onkeyup="chkDupId(this.value);" 
				oninput="restrictId(this)" required>
				<div class="valid-feedback text-left" id="idMsg" ></div>
				<!-- <div class="invalid-feedback text-left">이미 사용중인 아이디 입니다.</div> -->
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<!--if조건줘야함 form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="password" class="form-control is-invalid" oninput="restrictPw(this)"
				onkeyup="checkPassword()" id="mi_pw" name="mi_pw"
				placeholder="4-15자의 영문, 숫자, 특수문자로 입력해주세요." required>
			</td>
		</tr>
		<tr>
			<th>비밀번호확인</th>
			<td>
			<!-- form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="password" class="form-control is-invalid" oninput="restrictPw(this)"
				onkeyup="checkPassword()" id="mi_pw2" name="mi_pw2"
				placeholder="4-15자의 영문, 숫자, 특수문자로 입력해주세요." required>
				<div id="pwRed" class="valid-feedback text-left"></div>
				<!-- <div class="invalid-feedback text-left">비밀번호가 일치하지 않습니다</div> -->
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td class="text-left">
				<div class="form-check custom">
					<input class="form-check-input " type="radio" name="mi_gender" value="남" id="male" checked> 
					<label class="form-check-label" for="male">남자</label>
				</div>
				<div class="form-check custom">
					<input class="form-check-input" " type="radio" name="mi_gender" value="여" id="fmale"> 
					<label class="form-check-label" for="fmale">여자</label>
				</div>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<div class="form-row align-items-center justify-content-between">
					<div class="col-sm-3 my-1">
						<input type="text" class="form-control" name="e1" id="e1" oninput="restrictEm1(this)" onchange="checkMchange()">
					</div>
					<div class="col-sm-3 my-1">
						<div class="input-group">
							<div class="input-group-prepend d-flex align-items-center">
								<div class="input-group-text">@ &nbsp;&nbsp;&nbsp;</div>
							</div>
							<input type="text" class="form-control" name="e3" id="e3" size="10" oninput="restrictEm2(this)" disabled>
						</div>
					</div>
					<select class="custom-select my-1 mr-sm-2" name="e2" id="e2" >
						<option value="" selected disabled>이메일 선택</option>
						<option value="gmail.com" >gmail.com</option>
						<option value="naver.com" >naver.com</option>
						<option value="daum.net" >daum.net</option>
						<option value="direct" >직접입력</option>
					</select>
					<div class="col-auto my-1" >
						<button type="button" class="btn btn-primary" 
						onclick="mailButtonClick()">중복검사</button>
					</div>
					<!-- <div class="invalid-feedback text-left">이미 등록된 이메일 입니다.</div> -->
				</div>
					<div class="valid-feedback text-left" id="mailMsg"></div>
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<div class="row align-items-center">
					<div class="col">
						<input type="text" class="form-control" placeholder="010"
							readonly>
					</div>
					-
					<div class="col">
						<input type="text" class="form-control" name="p2" id="p2" size="4" maxlength="4" onkeyup="checkPlength()" >
					</div>
					-
					<div class="col">
						<input type="text" class="form-control" name="p3" id="p3" size="4" maxlength="4" onkeyup="checkPlength()" >
					</div>
					<div class="col-auto my-1 pl-0">
						<button type="button" class="btn btn-primary" onclick="phoneButtonClick();">중복검사</button>
					</div>

				</div>
				<div id="phoneMsg" class="valid-feedback text-left"></div>
				<!-- <div class="invalid-feedback text-left">이미 등록된 전화번호 입니다.</div> -->
			</td>
		</tr>
		</tbody>
	</table> 
	<button type="submit" class="btn btn-primary btn-block" id="signIn" name="signIn">회원가입</button>
	</div>
</div>
</form>
</section>

<%@ include file="../_inc/foot.jsp"%>