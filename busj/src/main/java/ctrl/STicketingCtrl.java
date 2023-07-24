package ctrl;

import java.util.*;
import java.io.*;
import java.lang.invoke.CallSite;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import svc.*;
import vo.*;

@Controller
public class STicketingCtrl {
	private STicketingSvc sTicketingSvc;
	
	public void setSTicketingSvc(STicketingSvc sTicketingSvc) {
		this.sTicketingSvc = sTicketingSvc;
	}

	@GetMapping("/sTicketingStep01")
	public String sTicketingStep01() {
		return "ticketing/s_ticket_step1";
	}
	
	@GetMapping("/pickSpotSlow")
	public String pickSpotSlow(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<TerminalInfo> terminalList = sTicketingSvc.pickSpotSlow();
		request.setAttribute("terminalList", terminalList);
		return "popup/pick_spot_slow";
	}

}
