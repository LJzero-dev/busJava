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
	@ResponseBody
	public List<LineInfo> lineSch(@RequestParam int btsidx) {
        // btidx에 해당하는 터미널 목록을 조회한 결과로 List<LineInfo>를 반환
        List<LineInfo> lineList = hTicketingSvc.getAvailableLineList(btsidx);
        return lineList;
    }
	
	@PostMapping("/hTicketingStep02")
	public String hTicketingStep02() {
		return "ticketing/h_ticket_step2";
	}
	
	
}
