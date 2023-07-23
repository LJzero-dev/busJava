package ctrl;

import java.util.*;
import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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
	public String pick_spot_high() {
		return "popup/pick_spot_high";
	}
	
	
}
