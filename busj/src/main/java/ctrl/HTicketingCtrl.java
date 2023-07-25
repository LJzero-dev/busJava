package ctrl;

import java.util.*;
import java.io.*;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import svc.*;
import vo.*;

@Controller
public class HTicketingCtrl {
	private HTicketingSvc hTicketingSvc;
	
	public void sethTicketingSvc(HTicketingSvc hTicketingSvc) {
		this.hTicketingSvc = hTicketingSvc;
	}

	@GetMapping("/hTicketingStep01")
	public String hTicketingStep01() {
		return "ticketing/h_ticket_step1";
	}
	
	@GetMapping("/pickSpotHigh")
	public String pickSpotHigh(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<TerminalInfo> terminalList = hTicketingSvc.getTerminalList();
		request.setAttribute("terminalList", terminalList);
		
		return "popup/pick_spot_high";
	}
	
	@GetMapping("/lineSch")
	public String lineSch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		int btsidx = Integer.parseInt(request.getParameter("btidx"));
		List<LineInfo> lineList = hTicketingSvc.getAvailableLineList(btsidx);
		request.setAttribute("lineList", lineList);
		
		// 수정하기기기기
		return "popup/pick_spot_high";
	}
	
	
}
