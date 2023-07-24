package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import svc.*;
import vo.*;

@Controller
public class MemberCtrl {
	private MemberSvc memberSvc;
	
	public void setMemberSvc(MemberSvc memberSvc) {
		this.memberSvc = memberSvc;
	}
	
	/* 회원로그인 시작*/	
	@GetMapping("/memberLogin")
	public String index() {
		/* System.out.println("yap"); */
		return "/member/login";
	}
	
	@PostMapping("/memberLogin")
	public String loginProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String mi_id = request.getParameter("mi_id").trim().toLowerCase();
		String mi_pw = request.getParameter("mi_pw").trim();
		MemberInfo loginInfo = memberSvc.getLoginInfo(mi_id, mi_pw);
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디와 암호를 확인하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
		}
		
		return "redirect:/";
	}
	/* 회원로그인 끝*/	

	/* 회원로그아웃 시작*/	
	@RequestMapping("/memberLogout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	/* 회원로그아웃 끝*/
	
	/* 회원가입 시작 */
	@GetMapping("/memberJoinStep1")
	public String joinStep1() {
		return "/member/join_step1";
	}
	
	@GetMapping("/memberJoinStep2")
	public String joinStep2() {
		return "/member/join_step2";
	}
	
	@PostMapping("/memberJoinStep2")
	public String joinProc(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		request.setCharacterEncoding("utf-8");
		MemberInfo mi = new MemberInfo();
		mi.setMi_id(request.getParameter("mi_id"));
		mi.setMi_pw(request.getParameter("mi_pw"));
		mi.setMi_name(request.getParameter("mi_name"));
		mi.setMi_gender(request.getParameter("mi_gender"));
		String p2 = request.getParameter("p2");
		String p3 = request.getParameter("p3");
		mi.setMi_phone("010-" + p2 + "-" + p3);
		String e1 = request.getParameter("e1");
		String e2 = request.getParameter("e2");
		String e3 = request.getParameter("e3");
		if (e3 == null) {
			mi.setMi_email(e1 + "@" + e2);			
		} else {
			mi.setMi_email(e1 + "@" + e3);	
		}
		
		/*
		 * System.out.println(e1 + "@" + e2); System.out.println(e1 + "@" + e3);
		 */
		
		int result = memberSvc.memberInsert(mi);
		
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		redirectAttributes.addFlashAttribute("mi_id", mi.getMi_id());
	    redirectAttributes.addFlashAttribute("mi_name", mi.getMi_name());
		return "redirect:/memberJoinStep3";
	}
	
	
	@GetMapping("/memberJoinStep3")
	public String joinStep3(String mi_id, String mi_name, Model model) {
		return "/member/join_step3";
	}
	
	/* 회원가입 아이디 검사 부분 */
	@PostMapping("/dupId")
	@ResponseBody // 자바 객체를 http 응답을 객체로 변환하여 클라이언트에 전송
	// 비동기 통신(ajax)시 서버에서 클라이언트로 응답 메세지를 보낼 떄 데이터를 담아서 보낼 해당 본문을 의미
	public String dupId(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		int result = memberSvc.chkDupId(uid);
		
		return result + "";
	}
	/* 회원가입 아이디 검사 부분 */
	
	
	/* 회원가입 메일 검사 부분 */
	@PostMapping("/dupMail")
	@ResponseBody // 자바 객체를 http 응답을 객체로 변환하여 클라이언트에 전송
	// 비동기 통신(ajax)시 서버에서 클라이언트로 응답 메세지를 보낼 떄 데이터를 담아서 보낼 해당 본문을 의미
	public String dupMail(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String e1 = request.getParameter("e1").trim();
		String e3 = request.getParameter("e3").trim();
		String email = (e1 + "@" + e3);
		int result = memberSvc.chkDupMail(email);
		
		return result + "";
	}
	/* 회원가입 메일 검사 부분 */
	
	
	/* 회원가입 전화번호 부분 */
	@PostMapping("/dupPhone")
	@ResponseBody // 자바 객체를 http 응답을 객체로 변환하여 클라이언트에 전송
	// 비동기 통신(ajax)시 서버에서 클라이언트로 응답 메세지를 보낼 떄 데이터를 담아서 보낼 해당 본문을 의미
	public String dupPhone(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String p2 = request.getParameter("p2").trim();
		String p3 = request.getParameter("p3").trim();
		String phone = ("010-" + p2 + "-" + p3);
		int result = memberSvc.chkDupPhone(phone);
		
		return result + "";
	}
	/* 회원가입 전화번호 부분 */
	
	/* 회원 아이디 / 비밀번호 찾기 부분 */
	@GetMapping("/memberFind")
	public String find() {
		return "/member/find";
	}
	
	@PostMapping("/memberFindId")
	// 비동기 통신(ajax)시 서버에서 클라이언트로 응답 메세지를 보낼 떄 데이터를 담아서 보낼 해당 본문을 의미
	public String memberFindId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String idE1 = request.getParameter("idE1").trim();
		String idE2 = request.getParameter("idE2");
		String idE3 = request.getParameter("idE3");
		String email = "";
		if (idE3 == null) {
			idE2.trim();
			email = (idE1 + "@" + idE2);		
		} else {
			idE3.trim();
			email = (idE1 + "@" + idE3);
		}
		
		int result = memberSvc.chkDupMail(email);
		
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('유효하지 않은 회원 정보 입니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('회원님께서 입력하신 이메일 주소로 아이디를 발송했습니다.');");
		out.println("location.href='/busj/memberLogin';");
		out.println("</script>");
		out.close();
		
		return "/member/login";
	}
	
	@PostMapping("/memberFindPw")
	// 비동기 통신(ajax)시 서버에서 클라이언트로 응답 메세지를 보낼 떄 데이터를 담아서 보낼 해당 본문을 의미
	public String memberFindPw(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String pwE1 = request.getParameter("pwE1").trim();
		String pwE2 = request.getParameter("pwE2");
		String pwE3 = request.getParameter("pwE3");
		String mi_id = request.getParameter("mi_id");
		String email = "";
		if (pwE3 == null) {
			pwE2.trim();
			email = (pwE1 + "@" + pwE2);		
		} else {
			pwE3.trim();
			email = (pwE1 + "@" + pwE3);
		}
		
		int result = memberSvc.chkDupIdMail(mi_id, email);
		
		
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('유효하지 않은 회원 정보 입니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} 
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('회원님께서 입력하신 이메일 주소로 임시 비밀번호를 발송했습니다.');");
		out.println("location.href='/busj/memberLogin';");
		out.println("</script>");
		out.close();
		
		return "/member/login";
		
	}
	/* 회원 아이디 / 비밀번호 찾기 부분 */

	/* 회원 마이페이지 부분 */
	@GetMapping("/memberMypage")
	public String mypage() {
		return "/member/mypage";
	}
	
	@GetMapping("/pwChk")
	public String pwForm() {
		return "/member/pw_form";
	}
	@GetMapping("/booking")
	public String bookingList() {
		return "/member/booking_list";
	}
	@GetMapping("/payMoney")
	public String paymoney() {
		return "/member/paymoney";
	}
	@GetMapping("/coupon")
	public String coupon() {
		return "/member/coupon";
	}
	@GetMapping("/stamp")
	public String stamp() {
		return "/member/stamp";
	}

	/* 회원 마이페이지 부분 */
	
}
