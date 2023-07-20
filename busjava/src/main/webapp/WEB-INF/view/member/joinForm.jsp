<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<!DOCTYPE html>

<script>
$(document).ready(function() { // .ready : 문서가 다 읽힌 다음에 작동해라
	$("#e2").change(function() {
		if ($(this).val() == "") {
			$("#e3").val("");
		} else if ($(this).val() == "direct") {
			$("#e3").val("");	$("#e3").focus();
		} else {
			$("#e3").val($(this).val());
		}
	})
});

function chkDupId(uid) {
	if (uid.length >= 4) {
		$.ajax({
			type : "POST", url : "./dupId", data : {"uid" : uid},
			success : function(chkRs){
				var msg = "";
				if (chkRs == 0) {
					msg = "<span id='fontBlue'>사용하실 수 있는 아이디 입니다.</span>";
					$("#idChk").val("y");
				} else {
					msg = "<span id='fontRed'>사용할 수 없는 아이디 입니다.</span>";
					$("#idChk").val("n");
				}
				$("#idMsg").html(msg); // .html : ()안의 태그를 바꿔라
			}
		});
		$("#idChk").val("y");
	} else {
		$("#idMsg").text("아이디는 4 ~ 20자로 입력하세요."); // .text :()안의 내용을 바꿔라
		$("#idChk").val("n"); //기본적으로 val값이 "n"이지만  4자 이상 입력했다가 지웠을 경우를 대비해서 넣어줌
	}
}
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
<form name="frmJoin" action="memberJoin" method="post">
<input type="hidden" name="idChk" id="idChk" value="n" />
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
			<td><input type="text" class="form-control" id="validationServer01" required /></td>
		</tr>
		<tr>
		<th>아이디</th>
			<td><!-- form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="text" class="form-control is-invalid" name="mi_id" id="validationServer01" 
				placeholder="4-15자의 영문, 숫자로 입력해주세요." onkeyup="chkDupId(this.value);"
				required>
				<div class="valid-feedback text-left" id="idMsg" >사용가능한 아이디 입니다.</div>
				<!-- <div class="invalid-feedback text-left">이미 사용중인 아이디 입니다.</div> -->
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<!--if조건줘야함 form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="password" class="form-control is-invalid"
				id="validationServer01" name="mi_pw"
				placeholder="4-15자의 영문, 숫자, 특수문자로 입력해주세요." required>
			</td>
		</tr>
		<tr>
			<th>비밀번호확인</th>
			<td>
			<!-- form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="password" class="form-control is-invalid"
				id="validationServer01" name="mi_pw2"
				placeholder="4-15자의 영문, 숫자, 특수문자로 입력해주세요." required>
				<div class="valid-feedback text-left">비밀번호가 일치합니다</div>
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
						<label class="sr-only" for="inlineFormInputName">Name</label>
						<input type="text" class="form-control" name="e1" id="e1">
					</div>
					<div class="col-sm-3 my-1">
						<label class="sr-only" for="inlineFormInputGroupUsername">Username</label>
						<div class="input-group">
							<div class="input-group-prepend d-flex align-items-center">
								<div class="input-group-text">@ &nbsp;&nbsp;&nbsp;</div>
							</div>
							<input type="text" class="form-control" name="e3" id="e3" size="10">
						</div>
					</div>
					<select class="custom-select my-1 mr-sm-2" name="e2" id="e2" >
						<option value="" selected>이메일 선택</option>
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
					</select>
					<div class="col-auto my-1" >
						<button type="button" class="btn btn-primary" onclick="chkDupMail();">중복검사</button>
					</div>
					<div class="valid-feedback text-left">사용가능한 이메일 입니다.</div>
					<div class="invalid-feedback text-left">이미 등록된 이메일 입니다.</div>
				</div>
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
						<input type="text" class="form-control" name="p2" size="4" maxlength="4" >
					</div>
					-
					<div class="col">
						<input type="text" class="form-control" name="p3" size="4" maxlength="4" >
					</div>
					<div class="col-auto my-1 pl-0">
						<button type="button" class="btn btn-primary" onclick="chkDupNum();">중복검사</button>
					</div>

				</div>
				<div class="valid-feedback text-left">사용가능한 전화번호 입니다.</div>
				<div class="invalid-feedback text-left">이미 등록된 전화번호 입니다.</div>
			</td>
		</tr>
		</tbody>
	</table>
	<button type="submit" class="btn btn-primary btn-block">회원가입</button>
	</div>
</div>
</form>
</section>

<script>
   $('#chkAll').on('click', function () {
     if ($(this).is(":checked")) {
       $(this).parents('.allchkbox').addClass('active');
     } else {
       $(this).parents('.allchkbox').removeClass('active');
     }
   });
</script>
<%@ include file="../_inc/foot.jsp"%>