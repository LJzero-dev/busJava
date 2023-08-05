package ctrl;

import java.util.*;
import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import svc.*;
import vo.*;

@Controller
public class TravelCtrl {
	private TravelSvc travelSvc;
	
	public void setTravelSvc(TravelSvc travelSvc) {
		this.travelSvc = travelSvc;
	}
	
	private HTicketingSvc hTicketingSvc;

	public void sethTicketingSvc(HTicketingSvc hTicketingSvc) {
		this.hTicketingSvc = hTicketingSvc;
	}

	@GetMapping("/travelList")
	public String pmoneyInfo(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");
		String where = " where tl_isview = 'y' ";
		String area = request.getParameter("hiddenArea");
		String terminal = request.getParameter("area");
		
		if (type != null && !type.equals("")) {
			where += " and tl_ctgr = '" + type + "' ";
		}
		
		if (area != null && !area.equals("")) {
			where += " and tl_area = '" + area + "' ";
		}
		
		List<TravelInfo> travelList = travelSvc.getTravelList(where);
		model.addAttribute("travelList", travelList);
		model.addAttribute("terminal", terminal);
		model.addAttribute("area", area);
		
		return "/travel/travel_list";
	}
	
	@GetMapping("/pickSpot")
	public String pickSpot(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<TerminalInfo> terminalList = hTicketingSvc.getTerminalList();
		request.setAttribute("terminalList", terminalList);

		return "popup/pick_spot";
	}
}
