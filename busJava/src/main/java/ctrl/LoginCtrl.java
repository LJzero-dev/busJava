package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
@RequestMapping("/login")
public class LoginCtrl {
	
	private LoginSvc loginSvc;
	
	public void setLoginSvc(LoginSvc loginSvc) {
		this.loginSvc = loginSvc;
	}

	@GetMapping
	public String index() {
		return "/member/login";
	}
	
	@PostMapping
	public String loginProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String mi_id = request.getParameter("mi_id").trim().toLowerCase();
		String mi_pw = request.getParameter("mi_pw").trim();
		MemberInfo loginInfo = loginSvc.getLoginInfo(mi_id, mi_pw);
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
}
