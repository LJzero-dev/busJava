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
		ArrayList<TerminalInfo> terminalList = new ArrayList<TerminalInfo>();
		terminalList = terminalSvc.getTerminalList();

		request.setAttribute("terminalList", terminalList);
		return "/line/h_terminal";
	}
}
