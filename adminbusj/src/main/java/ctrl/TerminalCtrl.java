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
	@GetMapping("/terminal")	// 터미널관리 목록
	public String terminal(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<TerminalInfo> terminalList = terminalSvc.getTerminalList();
		
		request.setAttribute("terminalList", terminalList);
		return "/line/h_terminal";
	}
	
	@GetMapping("/terminalAdd")		//	터미널 추가 팝업으로 이동
	public String terminalAdd()  {
		return "/popup/terminal_add";
	}
	
	@PostMapping("/chkTerminal")	// 터미널명 중복확인
	@ResponseBody
	public String chkTerminal(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name").trim();
		int result = terminalSvc.chkTerminal(name);
		
		return result + "";
	}
	
	@PostMapping("/terminalIn")		// 터미널 insert
	public String terminalInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("bt_name");
		String area = request.getParameter("area");
		String chkName = request.getParameter("chkName");
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (chkName.equals("n")) {
			out.println("<script>");
			out.println("alert('터미널 명을 확인해주세요.');");
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
	
	@GetMapping("/terminalLine")	// 터미널 시간표 목록
	public String terminalLine(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int bt_idx = Integer.parseInt(request.getParameter("bt_idx"));
		String bt_name = request.getParameter("bt_name");
		
		List<BusLineInfo> busLineList = terminalSvc.getBusLine(bt_idx);
		List<BusInfo> busInfo = terminalSvc.getBusInfo();
		
		request.setAttribute("busLineList", busLineList);
		request.setAttribute("busInfo", busInfo);
		return "/line/h_terminal_line";
	}

	@GetMapping("/LineDel")		// 노선 삭제 update
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
			out.println("alert('노선 삭제에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return "redirect:/terminalLine?bt_idx=" + bt_idx + "&bt_name=" + URLEncoder.encode(bt_name, "UTF-8");
	}
	
	@GetMapping("/popUpLineAdd")		// 노선 추가 팝업으로 이동
	public String popUpLineAdd(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int bt_idx = Integer.parseInt(request.getParameter("bt_idx")); 
		String bt_name = request.getParameter("bt_name");
		List<TerminalInfo> terminalList = terminalSvc.getTerminalListPop(bt_idx);
		
		request.setAttribute("bt_idx", bt_idx);
		request.setAttribute("bt_name", bt_name);
		request.setAttribute("terminalList", terminalList);
		return "/popup/terminal_line_add";
	}
	
	@PostMapping("/AddLine")		// 노선 추가 insert 작업
	public String AddLine(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int bt_sidx = Integer.parseInt(request.getParameter("bt_sidx"));
		String tmp = request.getParameter("bt_eidx");
		
		if(tmp.equals("")) {
			out.println("<script>");
			out.println("alert('터미널명을 확인해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return "";
		}
		
		String[] arr = tmp.split(":");
		int bt_eidx = Integer.parseInt(arr[1]);
		String bt_name = request.getParameter("bt_name");
		String[] tmp2 = request.getParameter("adult").split(",");
		String str = "";
		for (int i = 0; i < tmp2.length; i++) {
			str += tmp2[i];
		}
		int adult = Integer.parseInt(str);
		if(adult < 10000) {
			out.println("<script>");
			out.println("alert('요금을 확인해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return "";
		}
		
		int result = terminalSvc.AddLineIn(bt_sidx, bt_eidx, adult);
		
		if (result != 1) {
			out.println("<script>");
			out.println("alert('노선 추가에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return "redirect:/terminalLine?bt_idx="+bt_sidx+"&bt_name="+ URLEncoder.encode(bt_name, "UTF-8");
	}
	
	@PostMapping("/scheduleAdd")
	public String scheduleAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int bt_idx = Integer.parseInt(request.getParameter("bt_idx"));
		String bt_name = request.getParameter("bt_name");
		
		int bl_idx = Integer.parseInt(request.getParameter("bl_idx"));
		String time1 = request.getParameter("time1");
		String time2 = request.getParameter("time2");
		
		int n1 = Integer.parseInt(time1.replace(":", "")) + 100;
		int n2 = Integer.parseInt(time2.replace(":", ""));
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (n1 > n2) {
			out.println("<script>");
			out.println("alert('시간을 확인해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return "";
		}
		
		String str = request.getParameter("number");
		String[] arr = str.split(":");
		String number = arr[1];
		
		if (number.equals("")) {
			out.println("<script>");
			out.println("alert('차량 번호를 선택해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return "";
		}
		int adult = Integer.parseInt(request.getParameter("adult" + bl_idx));
		
		BusScheduleInfo busScheduleInfo = new BusScheduleInfo(0, 0, 0, number, time1, time2, "", "", "");
		
		int result = terminalSvc.scheduleAdd(busScheduleInfo, adult, bl_idx);
		
		if (result != 1) {
			out.println("<script>");
			out.println("alert('시간표 추가에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return "redirect:/terminalLine?bt_idx=" + bt_idx + "&bt_name="+ URLEncoder.encode(bt_name, "UTF-8");
	}
	
	@PostMapping("/changeLevel")
	@ResponseBody
	public String changeLevel(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String number = request.getParameter("number");

		int result = terminalSvc.changeLevel(number);
		return result + "";
	}
	
	@PostMapping("/delShcedule")
	@ResponseBody
	public String delShcedule(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String bs_idx = request.getParameter("bsidx");
		int bsidx = Integer.parseInt(bs_idx);	
		
		int result = terminalSvc.delShcedule(bsidx);
		return result + "";
	}
}
