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
		System.out.println("컨트롤 : " + btsidx);
        // btidx에 해당하는 터미널 목록을 조회하는 비즈니스 로직을 수행하여 List<LineInfo>를 반환하는 예시
        List<LineInfo> lineList = hTicketingSvc.getAvailableLineList(btsidx);
        return lineList;
    }
	
	
}
