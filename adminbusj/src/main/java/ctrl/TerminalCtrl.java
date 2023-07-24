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
	@ResponseBody // �ڹ� ��ü�� http ������ ��ü�� ��ȯ�Ͽ� Ŭ���̾�Ʈ�� ����
	// �񵿱� ���(ajax)�� �������� Ŭ���̾�Ʈ�� ���� �޼����� ���� �� �����͸� ��Ƽ� ���� �ش� ������ �ǹ�
	public String chkTerminal(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name").trim();
		int result = terminalSvc.chkTerminal(name);
		
		return result + "";
	}
}
