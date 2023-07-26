package ctrl;

import java.io.*;
import java.net.URLEncoder;

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
	public String terminal(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
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
			out.println("alert('�͹̳θ��� Ȯ�����ּ���.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		int result = terminalSvc.terminalInsert(name, area);
		
		if (result != 1) {
			out.println("<script>");
			out.println("alert('�͹̳� �߰��� �����߽��ϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return "redirect:/terminal";
	}
	
	@GetMapping("/terminalLine")
	public String terminalLine(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int bt_idx = Integer.parseInt(request.getParameter("bt_idx"));
		String bt_name = request.getParameter("bt_name");
		List<BusLineInfo> busLineList = terminalSvc.getBusLine(bt_idx);
		
		request.setAttribute("busLineList", busLineList);
		
		return "/line/h_terminal_line";
	}

	@GetMapping("/LineDel")
	public String LineDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int bl_idx = Integer.parseInt(request.getParameter("lineNum"));
		int bt_idx = Integer.parseInt(request.getParameter("bt_idx"));
		String bt_name = request.getParameter("bt_name");
		
		int result = terminalSvc.LineDel(bl_idx);
		
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�뼱 ������ �����߽��ϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return "redirect:/terminalLine?bt_idx=" + bt_idx + "&bt_name=" + URLEncoder.encode(bt_name, "UTF-8");
	}
}
