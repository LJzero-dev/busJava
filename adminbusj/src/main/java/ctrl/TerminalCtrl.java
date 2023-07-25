package ctrl;

import java.io.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@Controller
public class TerminalCtrl {
	private TerminalSvc terminalSvc;
	
	public void setTerminalSvc(TerminalSvc terminalSvc) {
		this.terminalSvc = terminalSvc;
	}
	@GetMapping("/terminal")
	public String terminal(HttpServletRequest request, HttpServletResponse response)  {
		
		List<TerminalInfo> terminalList = terminalSvc.getTerminalList();
		
		request.setAttribute("terminalList", terminalList);
		return "/line/h_terminal";
	}
	
	@GetMapping("/terminalAdd")
	public String terminalAdd()  {
		return "/popup/terminal_add";
	}
	
	@PostMapping("/chkTerminal")
	@ResponseBody // 자바 객체를 http 응답을 객체로 변환하여 클라이언트에 전송
	// 비동기 통신(ajax)시 서버에서 클라이언트로 응답 메세지를 보낼 떄 데이터를 담아서 보낼 해당 본문을 의미
	public String chkTerminal(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name").trim();
		int result = terminalSvc.chkTerminal(name);
		
		return result + "";
	}
	
	@PostMapping("/terminalIn")
	public String terminalInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("bt_name");
		String area = request.getParameter("area");
		String chkName = request.getParameter("chkName");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (chkName.equals("n")) {
			out.println("<script>");
			out.println("alert('터미널명을 확인해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		int result = terminalSvc.terminalInsert(name, area);
		
		if (result != 1) {
			out.println("<script>");
			out.println("alert('터미널 추가에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return "redirect:/terminal";
	}
	
	@GetMapping("/terminalLine")
	public String terminalLine(HttpServletRequest request, HttpServletResponse response)  {
		/*
		String bt_name = request.getParameter("bt_name");
		List<TerminalLineInfo> terminalLine = terminalSvc.getTerminalLine(bt_name);
		
		request.setAttribute("terminalLine", terminalLine);
		*/
		return "/line/h_terminal_line";
	}
}
