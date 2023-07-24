<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/head.jsp"%>
<%
MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
%>
<section class="probootstrap_section" id="section-city-guides">
<div class="container">
	<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
		<div class="col-md-12">
			<h2 class="display-5 border-bottom probootstrap-section-heading">내 정보</h2>
			<div class="col-md-8 m-auto">
				<div class="progress-bar-custom">
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<form name="frmJoin" action=memberUpdate method="post">
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
			<td><input type="text" class="form-control" id="mi_name" name="mi_name" value="<%=mi.getMi_name() %>" readonly required /></td>
		</tr>
		<tr>
		<th>아이디</th>
			<td><!-- form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="text" class="form-control" name="mi_id" id="mi_id" value="<%=mi.getMi_id() %>" readonly required>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>
				<!--if조건줘야함 form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="password" class="form-control" id="mi_pw" name="mi_pw" value="<%=mi.getMi_pw() %>" readonly required>
			</td>
			<td>
				<button type="button" class="btn btn-primary" id="change_pw" name="change_pw" onclick="changePw();">변경</button>
			</td>
		</tr>
		
		
		<tr id="pwChangeform1" style="display: none;">
			<th>새 비밀번호</th>
			<td>
				<!--if조건줘야함 form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="password" class="form-control is-invalid" oninput="restrictPw(this)" onkeyup="checkPassword()" id="chg_mi_pw" name="chg_mi_pw" 
				placeholder="4-15자의 영문, 숫자, 특수문자로 입력해주세요." required>
			</td>
		</tr>
		<tr id="pwChangeform2" style="display: none;">
			<th>새 비밀번호확인</th>
			<td>
			<!-- form-control class가 is-valid => 성공, in-invalid => 실패 (테두리 색변화) -->
				<input type="password" class="form-control is-invalid" oninput="restrictPw(this)" onkeyup="checkPassword()" id="chg_mi_pw2" name="chg_mi_pw2"
				placeholder="4-15자의 영문, 숫자, 특수문자로 입력해주세요." required>
				<div id="pwRed" class="valid-feedback text-left"></div>
				<!-- <div class="invalid-feedback text-left">비밀번호가 일치하지 않습니다</div> -->
			</td>
		</tr>
	
		<tr>
			<th>성별</th>
			<td><input type="text" class="form-control" id="mi_gender" name="mi_gender" value="<%=mi.getMi_gender() %>" readonly required /></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" class="form-control" id="mi_email" name="mi_email" value="<%=mi.getMi_email() %>" readonly required /></td>
			<td>
				<button type="button" class="btn btn-primary" id="change_pw" name="change_pw" onclick="changeEmail();">변경</button>
			</td>
		</tr>
		<tr id="mailChangeform" style="display: none;">
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
			<td><input type="text" class="form-control" id="mi_phone" name="mi_phone" value="<%=mi.getMi_phone() %>" readonly required /></td>
			<td>
				<button type="button" class="btn btn-primary" id="change_pw" name="change_pw" onclick="changePhone();">변경</button>
			</td>
		</tr>
		<tr id="phoneChangeform" style="display: none;">
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
	<button type="submit" class="btn btn-primary w-120p ">정보변경</button>
    <button type="button" class="btn btn-secondary w-120p " onclick="location.href=''" >회원탈퇴</button>
	</div>
</div>
</form>
</section>
<script>
function changePw() {
	 var pwChangeForm1 = document.getElementById('pwChangeform1');
	 var pwChangeForm2 = document.getElementById('pwChangeform2');
		
		if (pwChangeForm1.style.display === 'none') {
			pwChangeForm1.style.display = 'block';
			pwChangeForm2.style.display = 'block';
		} else if (pwChangeForm1.style.display === 'block') {
			pwChangeForm1.style.display = 'none';
			pwChangeForm2.style.display = 'none';
		}
}

function changeEmail() {
	var mailChangeform = document.getElementById('mailChangeform');
		if (mailChangeform.style.display === 'none') {
			mailChangeform.style.display = 'block';
		} else if (mailChangeform.style.display === 'block') {
			mailChangeform.style.display = 'none';
		}
}

function changePhone() {
	var phoneChangeform = document.getElementById('phoneChangeform');
	if (phoneChangeform.style.display === 'none') {
		phoneChangeform.style.display = 'block';
	} else if (phoneChangeform.style.display === 'block') {
		phoneChangeform.style.display = 'none';
	}
}
</script>

<%@ include file="../_inc/foot.jsp"%>
