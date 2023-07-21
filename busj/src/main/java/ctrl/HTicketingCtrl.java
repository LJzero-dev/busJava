package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class HTicketingCtrl {
//	private HTicketingSvc hTicketingSvc;
//	
//	public void sethTicketingSvc(HTicketingSvc hTicketingSvc) {
//		this.hTicketingSvc = hTicketingSvc;
//	}

	@GetMapping("/hTicketing")
	public String goTicketing() {
		return "ticketing/h_ticket_step1";
	}

}
