<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ include file="../_inc/head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
String[] seats1 = (String[])session.getAttribute("seats1");
String seatList = "";
for (String seat : seats1) {
	seatList += ", " + seat;
}
seatList = seatList.substring(2);

int base_price = Integer.parseInt(request.getParameter("totalPrice"));
%>
<section class="probootstrap_section">
	<div class="container">
		<div class="row text-center mb-5 probootstrap-animate fadeInUp probootstrap-animated">
			<div class="col-md-12"><h2 class="border-bottom probootstrap-section-heading">고속버스 예매</h2></div>
			<div class="col-md-8 m-auto">
			  <div class="progress-bar-custom">
			    <div class="progress-step">
			      <div class="step-count"></div>
			      <div class="step-description">정보 입력</div>
			    </div>
			    <div class="progress-step">
			      <div class="step-count"></div>
			      <div class="step-description">배차 조회</div>
			    </div>
			    <div class="progress-step">
			      <div class="step-count"></div>
			      <div class="step-description">좌석 선택</div>
			    </div>
			    <div class="progress-step is-active">
			      <div class="step-count"></div>
			      <div class="step-description">확인/결제</div>
			    </div>
			    <div class="progress-step">
			      <div class="step-count"></div>
			      <div class="step-description">예매 결과</div>
			    </div>
			  </div>
			</div>
		</div>
        <div class="row">
			<div class="col-md-12 text-center mb-5">
			  <h4 class="text-left text-primary">승차권정보</h4>
			  <h5 class="text-left">가는편</h5>
			  <table class="table">
			    <colgroup>
			      <col width="5%">
			      <col width="15%">
			      <col width="5%">
			      <col width="15%">
			      <col width="15%">
			      <col width="15%">
			      <col width="15%">
			    </colgroup>
			    <tbody>
			      <tr>
			        <td><span class="badge badge-danger">출발지</span></td>
			        <td><%=ri1.getSspot() %></td>
			        <td><span class="badge badge-primary">도착지</span></td>
			        <td><%=ri1.getEspot() %></td>
			        <td><%=ri1.getSdate() %></td>
			        <td>출발 <%=ri1.getStime() %></td>
			        <td>도착 <%=ri1.getEtime() %></td>
			        <td><%=ri1.getComname() %></td>
			      </tr>
			      <tr>
			        <td colspan="2">예매 매수</td>
			        <td colspan="2" class="text-left">어른<%=ri1.getAdultcnt() %>, 청소년<%=ri1.getTeencnt() %>, 아동<%=ri1.getChildcnt() %></td>
			        <td colspan="2">예매 좌석</td>
			        <td colspan="2" class="text-left"><%=seatList %></td>
			      </tr>
			    </tbody>
			  </table>
			</div>
			<div class="col-md-12 mb-3">
				<h5 class="text-left"><span class="text-danger">*</span>서비스 이용약관 동의</h5>
				<div class="scroll-box">
					<서비스 이용약관><br />
				      제1장 총칙<br />
				      제1조 (목적)<br />
				      본 약관은 티머니(이하 ‘회사’라 합니다)가 제공하는 고속버스 티머니/시외버스 티머니 어플리케이션 서비스 및 고속버스통합예매 홈페이지의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 기타 제반 사항을 정함에 그 목적이 있습니다.<br />
				      제2조 (약관의 적용)<br />
				      ① 서비스 이용자에게는 본 약관과 여객운송 사업자의 운송약관이 적용됩니다.<br />
				      ② 본 약관에서 규정되지 않은 사항에 대해서는 여객운송 사업자의 운송약관에 따릅니다.<br />
				      제3조 (용어의 정의)<br />
				      ① 본 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br />
				      1. “서비스”란 이용자가 모바일 어플리케이션 상에서 고속ㆍ시외버스 승차권의 예매 및 예매 확인, 고속ㆍ시외버스 출발시간 확인과 기타 부가 기능을 이용 할 수 있도록 회사가 제공하는 서비스(고속버스 티머니 및 시외버스 티머니 어플리케이션, 고속버스통합예매 홈페이지)를 말합니다.<br />
				      2. “모바일 기기”란 어플리케이션의 설치가 가능한 운영체재를 탑재하고 있는 스마트 폰, 태블릿 PC 등의 이동 통신 기기를 말합니다.<br />
				      3. “이용자”란 본 약관에 따라 회사가 제공하는 서비스를 이용하는 회원과 비회원을 말합니다.<br />
				      4. “회원”이란 회사가 정한 회원 가입 절차에 따라 계정 등록을 마친 이용자로서 결제 내역 조회, 1:1문의 등의 추가 기능을 사용할 수 있는 자를 말합니다.<br />
				      5. “비회원”이란 회원 가입 절차에 따른 계정 등록을 하지 않고 서비스를 이용하는 자를 말합니다.<br />
				      6. “모바일 승차권”이란 여객운송 사업자가 발행하는 고속ㆍ시외버스 승차권을 모바일 기기 어플리케이션으로 전송 받은 것을 말합니다.<br />
				      7. “결제”란 이용자가 서비스 내에서 제공되는 결제수단으로 고속ㆍ시외버스 승차권의 예매 대금을 지불하는 행위를 말합니다.<br />
				      8. “환불”이란 어플리케이션에서 예매한 승차권을 취소할 때 예매 대금을 이용자와 회사 간에 약정된 방법과 절차에 따라 이용자에게 돌려주는 것을 말합니다.<br />
				      9. “모바일티머니”란 이동전화, 태블릿, 기타 모바일 기기 내에 장착되는 USIM chip 또는 SE(Secure Element, Embedded SE/Secure Memory card 등, 이하 USIM chip 등이라 함) 등에 회사가 발급하는 선불전자지급수단을 말합니다.<br />
				      10. “신용카드”란 서비스 상에서 고속ㆍ시외버스 승차권의 예매 대금을 결제 할 수 있도록 회사와 계약이 체결 된 은행 또는 신용카드사가 발행한 신용카드 및 체크카드를 말합니다.<br />
				      ② 본 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 여객운송 사업자의 운송약관, 관계 법령 및 서비스 별 안내에서 정하는 바에 의합니다.<br />
				      제4조 (약관의 효력 및 변경)<br />
				      ① 본 약관은 회사가 본 약관의 내용을 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공지하고, 이용자가 이에 동의함으로써 적용됩니다.<br />
				      ② 회사는 필요하다고 인정되는 경우, 「약관의 규제에 관한 법률」, 「전자금융거래법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 등 관련 법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.<br />
				      ③ 회사가 약관을 변경할 경우에는 적용일자 및 변경사유를 명시하여 제1항과 같은 방법으로 그 시행일자로부터 14일 전에 공지합니다. 단, 이용자에게 불리한 약관 내용의 변경에 대해서는 30일 전에 공지합니다. 이용자의 연락처 변경 등으로 인하여 회사가 각 이용자에게 개별 통지 하기가 어려운 경우에는 본 항의 공지를 함으로써 개별 통지 한 것으로 간주합니다.<br />
				      ④ 이용자가 제3항에 따라 변경된 약관에 동의하지 않을 경우 서비스의 이용을 중단하고 이용 계약을 해지할 수 있습니다. 다만, 변경 약관 시행일의 전날까지 명시적으로 약관 변경 거부 의사를 표시하지 아니할 경우 변경 약관에 동의한 것으로 간주합니다.<br />
				      제2장 서비스의 이용<br />
				      제5조 (서비스 이용 계약의 체결)<br />
				      ① 이용자는 약관 동의 후 서비스의 이용이 가능합니다.<br />
				      ② 결제 내역 조회, 1:1문의 등 기타 추가 기능을 사용하기 위해서는 서비스 내 회원가입 절차를 통해 계정을 등록해야 합니다.<br />
				      ③ 회원가입 고객은 하나의 아이디와 비밀번호를 통해 본 약관 제3조 1항에 명시되어 있는 서비스를 이용할 수 있습니다.<br />
				      ④ 회사는 다음 각 호에 해당하는 회원가입 신청의 경우에는 이를 승낙하지 아니할 수 있습니다.<br />
				      1. 기술상 서비스 제공이 불가능한 경우<br />
				      2. 다른 사람의 정보를 사용하는 등 허위로 신청하는 경우<br />
				      3. 이용자가 본 조 제2항에 따른 계정 등록 시 등록 사항을 누락하거나 잘못 입력 한 경우<br />
				      4. 공공질서 또는 미풍양속을 저해하거나 저해할 목적으로 신청한 경우<br />
				      5. 기타 회사가 정한 이용 신청 요건이 충족되지 않았을 경우<br />
				      제6조(서비스의 제공 및 변경)<br />
				      ① 서비스의 제공은 연중무휴 1일 24시간을 원칙으로 하며, 구체적인 종류와 세부내용은 서비스 내 사용방법 FAQ 및 서비스 별 안내에 따릅니다.<br />
				      ② 회사는 기술적 사양의 변경 또는 기타 불가피한 여건이나 사정 등이 있는 경우에는 서비스의 내용을 변경 할 수 있습니다. 이 경우 변경된 서비스의 내용 및 제공 일자를 명시하여 이용자에게 공지 합니다.<br />
				      제7조 (서비스의 중단)<br />
				      ① 회사는 다음 각 호에 해당하는 경우 이용자에 대한 서비스 제공을 중지 할 수 있습니다.<br />
				      1. 컴퓨터, 서버 등 서비스 제공을 위한 설비의 보수, 점검, 교체, 고장 등으로 인하여 부득이 한 경우<br />
				      2. 정전, 제반 설비의 장애 또는 이용량의 폭주 등으로 정상적인 서비스 제공에 지장이 있는 경우<br />
				      3. 서비스 제휴 업체와의 계약 종료 등과 같은 회사의 제반 사정 또는 법률상의 장애 등으로 서비스를 유지할 수 없는 경우<br />
				      4. 기타 천재지변, 국가비상사태 등 불가항력적 사유가 있는 경우<br />
				      ② 제1항에 의한 사유로 서비스가 일시 중지될 경우 회사는 인터넷 홈페이지 또는 어플리케이션을 통해 이를 사전에 공지합니다. 다만, 운영자의 고의 또는 과실이 없는 서버 장애, 시스템 다운 등 회사가 통제할 수 없는 사유로 인하여 이용자에게 사전 통지가 불가능한 경우에는 사후에 통지 할 수 있습니다.<br />
				      제8조 (회원 탈퇴 및 자격 상실 등)<br />
				      ① 회원은 언제든지 어플리케이션 내 ‘설정’ 메뉴를 통해 회원 탈퇴를 신청 할 수 있습니다. 단, 승차권 예매 후 탑승이 이루어지지 않은 모바일 승차권을 보유하고 있을 경우에는 해당 승차권의 예매를 취소한 후 회원 탈퇴가 가능 하며, 본 약관 제3조 1항의 서비스에서 예매한 승차권 조회 및 이용이 불가 합니다.<br />
				      ② 다음 각 호의 사유에 해당하는 경우 회사는 회원의 자격을 정지 또는 상실 시킬 수 있습니다.<br />
				      1. 가입 신청 시 허위의 내용을 등록 한 경우<br />
				      2. 타인의 명예를 손상시키거나 불이익을 주는 행위<br />
				      3. 서비스와 관련된 설비의 오 동작이나 정보 등의 파괴 및 혼란을 유발시키는 컴퓨터 바이러스 감염 자료를 등록 또는 유포하는 행위<br />
				      4. 다른 사람의 개인정보를 도용하거나 서비스 이용을 방해하는 경우<br />
				      5. 서비스를 이용하여 법령 또는 이 약관이 금지하는 행위를 하는 경우<br />
				      6. 현금 융통, 시세 차익을 노린 승차권 선 예매 등 비정상적인 목적으로 서비스를 이용하는 경우<br />
				      7. 서비스의 이용과 관련하여 취득한 타인의 개인정보를 무단으로 유용 또는 유출하는 행위<br />
				      제9조 (승차권 예매)<br />
				      ① 서비스내에서 승차권 예매 시 이용자에게 부과되는 예매 수수료는 없으며, 이용자는 신용카드, 모바일티머니 또는 기타 회사가 추가로 정의하는 결제수단을 통해 결제 할 수 있습니다.<br />
				      ② 결제 수단 또는 예매 수수료와 관련하여 변경 사항이 발생하는 경우 회사는 그 내용을 서비스 내에 사전 고지 합니다.<br />
				      제10조 (취소 및 환불)<br />
				      ① 서비스를 통한 예매 건의 취소 마감 시간은 서비스 내에 별도로 안내하며 취소 마감 시간은 여객운송 사업자, 터미널 등 관련 기관의 사정에 의해 변경 될 수 있습니다.<br />
				      ② 승차권 예매 취소에 따른 따른 환불 수수료는 여객운송 사업자의 운송약관이 정한 바에 따릅니다.<br />
				      제3장 회사와 이용자의 권리 및 의무<br />
				      제11조 (회사의 의무)<br />
				      ① 회사는 법령 또는 이 약관이 금지하는 사항 또는 공공질서ㆍ미풍양속에 반하는 행위를 하지 않으며, 이 약관이 정하는 바에 따라 지속적이고 안정적으로 서비스를 제공하는데 최선을 다 하여야 합니다.<br />
				      ② 회사는 이용자가 안전하게 서비스를 이용 할 수 있도록 이용자의 개인정보(신용정보 포함) 보호를 위한 보안 시스템을 갖추어야 하며, 개인정보 처리 방침을 공시하고 준수 합니다.<br />
				      ③ 회사는 이용자의 정보 수집 시 서비스 제공에 필요한 최소한의 정보를 수집하며 이용자가 제공한 개인정보를 본인의 승낙 없이 타인에게 누설, 제공 하여서는 안됩니다. 다만 법령에 의하여 허용되는 경우에는 제공 할 수 있습니다.<br />
				      제12조 (이용자의 의무)<br />
				      ① 이용자는 회원 가입을 위한 개인정보 또는 예매를 위한 결제 정보 입력 등 서비스 이용을 위해 필요한 정보를 입력 할 경우 사실과 일치하는 정확한 정보를 입력해야 하며 이용자가 부정확한 정보를 제공하여 발생하는 불이익에 대하여 회사는 책임을 지지 않습니다.<br />
				      ② 이용자는 본 약관 제8조 제2항에 기재된 행위를 하여서는 안됩니다.<br />
				      ③ 이용자는 관계 법령 및 이 약관의 규정 또는 이용 안내 등 회사가 통지하는 사항을 준수하여야 하며, 기타 회사의 업무에 방해가 되는 행위를 해서는 안됩니다.<br />
				      제4장 기타<br />
				      제13조 (이용자에 대한 통지)<br />
				      ① 회사가 회원에 대하여 통지를 하는 경우 회원이 회원 가입 시 제공한 이메일 주소 또는 이동전화 번호를 통해 통지할 수 있습니다.<br />
				      ② 불특정 다수의 이용자에 대한 통지의 경우 어플리케이션 또는 홈페이지 내의 공지사항에 게시함으로써 개별 통지에 갈음할 수 있습니다.<br />
				      제14조 (이용자의 개인정보보호)<br />
				      회사는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 등 관련 법령이 정하는 바에 따라 이용자의 개인정보를 보호하기 위해 노력합니다.<br />
				      
				      제15조 (정보의 제공 및 광고의 게재)<br />
				      ① 회사는 서비스를 운영함에 있어 회사의 서비스 관련 각종 정보 및 광고(회사 및 제휴사 광고 포함)를 서비스 화면에 게재할 수 있습니다.<br />
				      ② 이용자가 서비스상에 게재되어 있는 광고를 이용하거나 서비스를 통한 광고주의 판촉 활동에 참여하는 등의 방법으로 교신 또는 거래를 하는 것은 이용자의 선택입니다. 회사는 이용자와 광고주를 연결하는 시스템만 제공할 뿐, 광고주 혹은 이용자를 대변하지 않습니다.<br />
				      제16조 (회사의 연락처)<br />
				      회사의 상호, 주소, 및 전화번호 등은 다음과 같습니다.<br />
				      
				      ① 상호: 주식회사 티머니<br />
				      ② 주소: 서울시 중구 후암로 110 서울시티타워 10층(우편번호 100-741)<br />
				      ④ E-mail : webmaster@tmoney.co.kr<br />
				      제17조 (양도금지)<br />
				      이용자 및 회사는 이용자의 서비스 사용 및 회원 가입에 따른 본 약관 상의 지위 또는 권리, 의무의 전부 또는 일부를 제3자에게 양도, 위임하거나 담보제공 등의 목적으로 처분할 수 없습니다.<br />
				      
				      제18조 (손해배상)<br />
				      어느 일방이 본 약관의 규정을 위반함으로써 상대방에게 손해가 발생한 경우, 규정을 위반한 일방이 상대방의 손해에 대해 배상하여야 합니다. 또한 어느 일방의 규정 위반 행위로 인하여 상대방이 제3자로부터 손해배상청구 또는 소송을 비롯한 각종 이의 제기를 받는 경우 귀책 당사자는 자신의 책임과 비용으로 상대방을 면책시켜야 하며, 상대방이 면책되지 못한 경우 그로 인하여 발생한 상대방의 손해에 대해 배상하여야 합니다.<br />
				      
				      제19조 (약관 외 준칙)<br />
				      본 약관에 명시되지 않은 사항에 대해서는 「전자금융거래법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 등 관계 법령과 회사가 정한 서비스의 세부 이용 지침 등에 따릅니다.<br />
				      
				      부칙<br />
				      제1조 (시행일)
				      본 약관은 2019년 10월 1일부터 시행합니다.
				</div>
				<div class="form-check custom ml-0 mt-2">
				    <input class="form-check-input" type="checkbox" name="agree" id="agree1">
				    <label class="form-check-label" for="agree1">동의합니다</label>
				</div>
			</div>
			<div class="col-md-12 mb-3">
		        <h5 class="text-left"><span class="text-danger">*</span>운송약관 동의</h5>
		        <div class="scroll-box">
		고속버스 운송사업 운송약관<br />
		시 행 2016. 03. 09.<br />
		
		제1조 (목 적) 이 운송약관은(이하 약관이라 한다.) 여객자동차 운수사업법(이하 법이라 한다.) 제9조의 규정에 의하여 고속버스운송회사(이하 회사라 한다.)와 여객간의 운송에 관한 책임한계 및 경영에 필요한 사항을 규정함을 목적으로 한다.<br />
		제2조 (용어의 정의) 이 약관에 사용하는 용어의 정의는 다음과 같다.<br />
		1. 승차권이란 여객자동차운수사업법 시행규칙(이하 규칙이라 한다.) 제30조의 규정에 따라 운송을 위하여 회사가 발행하는 증표를 말한다.<br />
		2. 운임이란 회사에서 법 제8조의 규정에 의하여 관할관청에 신고 수리된 금액을 말한다.<br />
		3. 여객의 휴대품이란 여객이 소지하는 물품중 제23조의 규격기준에 부합하고 제26조의 소지제한 물품이 아닌 것으로 여객이 차내 반입하는 물품을 말한다.<br />
		4. 여객의 휴대화물이란 법 제18조의 규정에 의하여 운송되는 화물로 제23조의 규격 기준에 부합하고 제26조의 소지제한 물품이 아닌 것으로 물품적재 장치에 실은 물품을 말한다.<br />
		5. 인터넷승차권(홈티켓)이란 여객이 전국고속버스운송사업조합에서 운영하는 인터넷 홈페이지 내의 승차권 예약•예매서비스를 통해 지정된 양식으로 여객이 직접 발행한 승차권을 말한다.<br />
		6. 모바일승차권이란 여객이 전국고속버스운송사업조합에서 지정하는 고속버스 모바일앱내의 승차권 예매 서비스를 통해 휴대폰으로 전송받은 승차권을 말한다.<br />
		제3조 (약관의 적용)<br />
		① 이 약관은 회사에 의한 여객의 운송 또는 이에 부수되는 업무에 적용된다.<br />
		② 이 약관이 관계법규에 저촉된 때에는 적용하지 아니한다.<br />
		제4조 (여객의 동의) 여객이 회사가 제공하는 승차권 예약•예매서비스를 통해 승차권 예매, 인터넷 승차권(홈티켓), 모바일승차권 구입 발행받은 경우에는 이 약관 및 이에 의하여 정하여진 규정에 동의한 것으로 본다.<br />
		제5조 (약관의 변경) 이 약관 및 이에 의하여 정하여진 규정은 관할관청의 인가 또는 사업 개선명령에 의하여 변경될 수 있다.<br />
		제6조 (게시) 회사의 각 영업소에는 여객 운임표, 운송약관, 운행시간표 등을 여객이 보기 쉬운곳에 게시하여야 한다.<br />
		제7조 (종업원의 안내) 여객은 승, 하차 질서 확립과 안전운행을 위한 회사원의 안내에 따라야 한다.<br />
		제8조 (운행의 변경) 회사는 천재지변, 악천후, 도로의 정체 기타 불가항력적 사태 및 정부기관의 명령이 있을 때에는 운행의 일부 또는 전부를 취소하거나 운행시간의 변경할 수 있으며 여객 및 휴대화물 등의 운송을 제한할 수 있다.<br />
		
		는 여객이 지정하는 제3자의 입회하에 휴대품, 휴대화물의 내용을 조사할 수 있다.<br />
		제25조 (물품의 소지제한) 여객은 다음 각 호의 물품을 소지할 수 없다. 다만, 품명, 수량, 포장방법에 있어서 회사에서 인정한 것은 제외한다.<br />
		1. 폭발성 물질, 부식성 물질, 인화성 물질 등 위험물로서 여객에게 위해를 끼칠염려가 있는 물품<br />
		2. 시체<br />
		3. 동물(단, 장애인 보조견 및 전용운반상자에 넣은 애완동물 제외)<br />
		        </div>
		        <div class="form-check custom ml-0 mt-2">
		            <input class="form-check-input" type="checkbox" name="agree" id="agree2">
		            <label class="form-check-label" for="agree2">동의합니다</label>
		        </div>
			</div>
			<div class="col-md-12 mb-3">
				<h5 class="text-left"><span class="text-danger">*</span>개인정보 수집 및 이용 동의</h5>
				<div class="scroll-box">
					개인정보 수집 및 이용 동의<br />
					1. 개인정보를 제공받는 자<br />
					고속버스 승차권 온라인 예매 서비스의 제공<br />
					
					2. 수집하는 항목<br />
					신용카드 번호ㆍ유효기간ㆍ신용카드 비밀번호 앞 2자리, 생년월일, 휴대전화번호<br />
					
					3. 보유 및 이용 기간<br />
					5년 (근거: 전자상거래 등에서의 소비자 보호에 관한 법률)<br />
					
					4. 개인정보 수집 및 이용 동의 거부 시 승차권 예매 하실 수 없습니다.<br />
					시행일자 : 2017년 5월 18일
				</div>
	            <div class="form-check custom ml-0 mt-2">
	                <input class="form-check-input" type="checkbox" name="agree" id="agree3">
	                <label class="form-check-label" for="agree3">동의합니다</label>
	            </div>
			</div>
			<div class="col-md-12 mb-3">
				<h5 class="text-left"><span class="text-danger">*</span>개인정보 제3자 제공에 대한 동의</h5>
				<div class="scroll-box">
					개인정보 제3자 제공에 대한 동의<br />
					1. 개인정보를 제공받는자: 고속버스 터미널, 고속버스운수사<br />
					터미널: 서울경부 센트럴시티(서울) 동서울 상봉 파주문산 파주운정 서울남부 인천 부천 송내 김포 김포공항 인천공항T1 송도 호계금호 호계동 서수원 수원 용인신갈 영통 아주대 신갈시외 고양화정 고양백석 인천동항T2 죽전 신갈영덕 성남 광명 철산 오산 안성 안성중대 안성풍림 안성공도 안성한경 안양 평촌 안성대림 안성회관 여주대 여주 양지 오천 이천시외 부밭 능서 포천 신철원 철원 용인유림 용인 경기광주 둔전 삼계리 경방 초부리 모현 매산리 양벌리 이천 구리 의정부 이천마장 이천부발 평택용이 평택대 안중오거리 안중 평택시외 평택 운천 장현 안산 상록수역 시흥시화 강릉 동해 동해그린 강원대 삼척 속초 횡계 횡성 원주 횡성시외 홍천 낙산 원주혁신 원주문막 춘천 청평 가평 강촌 화천 양양 영월 고한 태백 대전복합 대전시외 대전청사 청사시외 대전도룡 천안IC 천안 당진 서산 정안 공주 인삼랜드 금산 금산추부 배방정류소 안산테크노밸리 아산(둔포) 아산온양 아산서부 아산탕정사무소 아산 KTX 아산둔포 아산 천안공단 선문대 세종시외 탕정삼성LCD 조치원 세종연구단지 세종시 세종청 홍대세종 고대세종 오송역 오송단지 세종시(연구) 유성 논산 연무대 여주종합 기지시 홍성 내포 청양 정산 태안 보령 안면도 창기리 예산 덕산스파 청주(고속) 청주(센트럴) 남청주 북청주 청주 항 속리산 보은 옥천 중앙탑면 충주 황간 제천하소 제천 증평 괴산 평동 단양상진 단양 사평리 영춘 구인사 대천욕장 명지대 동백 강남마을 세종리젠 새릉골 구성 연원마을 죽전보정 수지현대 현대타운 독바위 범계 안양(경) 산의초교 추풍령 태안 꽃지 광주(유ㆍ스퀘어) 광주비야 목포 여천 여수 엑스포 순천신대지구 순천대 순천 순천종합 순천만 구례 광양 동광양 섬진강 나주 강진 고 녹동 무안 해제 보성 벌교 영광 영산포 영암 완도 관산 회진 원동 노력항 장흥 함평 담양 장성 문장 지도 화순 능주 옥과 곡성 진도 삼호 남악 해남 전주 호남제일 전주시외 군산 군산대야 익산팔봉 완주 애통리 김제 전북혁신 자치인재원 남원 덕과 태인 정읍 흥덕 고창 부안 전북강진 순창 봉동 진안 안천 무주 부산 부산시외 부산사상 진해 마산 내서 창원 창원역 울산시외 울산 울산신복 진주 진주시외 진주 진주개양 진주혁신 통영 장승포 고현 김해 김해장유 장유인천 김해 항 양산 밀양 동대구 서대구 대구용계 대구혁신 구미 선산 경주 김천 김천혁신 낙동강 상주 포항 청 포항 풍기 영주 안동 영덕 평해 영천 영천망정동 점촌 예천 경북도청 울진 광비 삼근 백암온천 후포 온정 대구공항 영주장수 영주꽃동산 동래 석계 통도사 언양 인보 내남 경주 건천 대창 진량<br />
					
					고속운수사: 금호고속㈜ ㈜동부고속 ㈜동양고속 ㈜삼화고속 금호속리산고속㈜ ㈜중앙고속 ㈜천일고속 ㈜한일고속 ㈜동양고속운수 ㈜경기고속 경일고속㈜ ㈜금남고속 ㈜대원고속 대한여객자동차㈜ ㈜아진고속 코리아와이드경북 전북고속 충주 호남고속 고려여객㈜-시외 고 여객자동차㈜ 천일여객㈜ 경원여객㈜ ㈜성남고속 ㈜천마고속 ㈜아성고속 경남여객(시외) 경남여객 서울고속㈜ 새서울고속 대한고속 금건 진흥고속 대원공항 코리아와이드대성 금강고속 강원고속㈜ 광신고속 ㈜경남고속 경남버스㈜-시외 ㈜중부고속 ㈜가야강남 ㈜진안고속 경원여객 ㈜충남고속 한양고속 ㈜삼흥고속<br />
					
					2. 개인정보를 제공받는 자의 개인정보 이용 목적 : 배차정보 변경, 감차, 사고 등 특수한 상황에서 터미널, 고속사가 고객에게 변경 정보를 고지할 필요가 있을 때 이용<br />
					3. 제공하는 개인정보의 항목 : 휴대폰번호<br />
					4. 개인정보를 제공받는 자의 개인정보 보유 및 이용 기간 : 제공목적 달성 후 즉시 파기<br />
					5. 개인정보 제3자 제공 동시 거부 시 승차원 예매 하실 수 없습니다.<br />
				</div>
				<div class="form-check custom ml-0 mt-2">
				    <input class="form-check-input" type="checkbox" name="agree" id="agree4">
				    <label class="form-check-label" for="agree4">동의합니다</label>
				</div>
			</div>
			<div class="col-md-12">
				<div class="allchkbox">
				<input type="checkbox" id="chkAll"><label for="chkAll" id="chkAllL"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-check2" viewBox="0 0 16 16">
					<path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"></path>
				</svg>전체 약관에 동의합니다.</label>
				</div>
			</div>
        </div>
        <div class="row">
          <div class="col-md-4 text-center mb-5 mt-5">
            <h4 class="text-left text-primary">쿠폰 적용</h4>
            <div class="d-flex justify-content-between">
              <p class="h5">쿠폰</p>
              <div>
              <!-- 쿠폰 없을경우 -->
         <p class="h6">-</p>
         <!-- 쿠폰 있을경우 -->
         <div class="d-flex align-items-center">
           <p class="h6 mb-0 mr-3">1개</p>
           <button type="button" class="btn btn-primary btn-sm">쿠폰 적용</button>
         </div>
         <!-- 쿠폰 적용 후-->
         <div class="d-flex align-items-center">
           <p class="h6 mb-0 mr-3">버스 무료 탑승권</p>
           <p class="h5 mb-0 mr-3">-30,000</p>
         </div>
         </div>
       </div>
     </div>
     <div class="col-md-5 text-center mb-5 mt-5">
       <h4 class="text-left text-primary">결제 방법</h4>
       <div class="d-flex">
       <div class="form-check custom">
         <input class="form-check-input" type="radio" name="payment" id="payment1" value="카드" checked>
         <label class="form-check-label" for="payment1">카드</label>
       </div>
       <div class="form-check custom">
         <input class="form-check-input" type="radio" name="payment" id="payment2" value="무통장입금">
         <label class="form-check-label" for="payment2">무통장입금</label>
       </div>
       <div class="form-check custom">
         <input class="form-check-input" type="radio" name="payment" id="payment3" value="간편결제">
         <label class="form-check-label" for="payment3">간편결제</label>
       </div>
       <div class="form-check custom">
         <input class="form-check-input" type="radio" name="payment" id="payment4" value="페이머니">
         <label class="form-check-label" for="payment4">페이머니</label>
       </div>
       <div class="form-check custom">
         <input class="form-check-input" type="radio" name="payment" id="payment5" value="쿠폰" hidden>
         <label class="form-check-label" for="payment5" hidden>쿠폰</label>
       </div>
     </div>
     <div id="pmoney_view" style="display: none;">
       <div>
        <p class="h5 text-left">잔액 270,000</p>
        <p class="text-danger text-left">잔액이 부족합니다. 충전 후 이용해 주세요.</p>
       </div>
       <div class="justify-content-end d-flex">
        <button type="button" class="btn btn-primary align-self-end">충전</button>
       </div>
     </div>
     </div>
     <div class="col-md-3 mb-5 mt-5">
       <div class="total">
         <div class="d-flex justify-content-between">
           <p class="h6">예매금액</p>
           <p id="basePrice" class="h5"></p>
         </div>
         <div class="d-flex justify-content-between">
           <p class="h6">쿠폰사용</p>
           <p class="h5">-</p>
         </div>
         <hr />
         <div class="d-flex justify-content-between">
           <p class="h6">총 결제금액</p>
           <p id="realPrice" class="h5"></p>
         </div>
         <button type="button" class="btn btn-primary btn-block mt-4">결제하기</button>
       </div>
     </div>
   </div>
	</div>
</section>
<%@ include file="../_inc/foot.jsp" %>
<script>

const pmoneybox = document.getElementById('pmoney_view');
const paymentChks = document.getElementsByName('payment');

for (let i = 0; i < paymentChks.length; i++) {
	paymentChks[i].onclick = function() {
    const chkValue = document.querySelector('input[type=radio][name=payment]:checked');
    if (chkValue.value === '페이머니') {
      pmoneybox.style.display = 'block';
    } else {
      pmoneybox.style.display = 'none';
    }
  };
}

const agreeChks = document.getElementsByName("agree");
const basePrice = <%=base_price %>;
$("#basePrice").text(basePrice.toLocaleString());
$("#realPrice").text(basePrice.toLocaleString());

$(document).ready(function() {

});

</script>


    
