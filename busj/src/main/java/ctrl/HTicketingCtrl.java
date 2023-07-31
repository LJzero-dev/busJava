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
	
	@PostMapping("/getLineNum")
	@ResponseBody
	public int getLineNum(@RequestParam String spoint, @RequestParam String epoint) {
	// 출발지, 도착지 이름에 따른 노선번호 반환	
		int lineNum = hTicketingSvc.getLineNum(spoint, epoint);
		return lineNum;
	}
	
	@PostMapping("/hTicketingStep02")
	public String hTicketingStep02(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String mode = request.getParameter("mode");
		String sDate = request.getParameter("sDate1-1").replace('.', '-');
		String eDate = "";
		if (mode.equals("w")) {
			eDate = request.getParameter("eDate1-2").replace('.', '-');
		}
		String sPoint = request.getParameter("sPoint");
		String ePoint = request.getParameter("ePoint");
		int lineNum = Integer.parseInt(request.getParameter("lineNum"));
		
		HttpSession session = request.getSession();
		
		if (mode.equals("p")) {	// 편도일경우 (세션 1개 생성)
			ReservationInfo ri1 =  new ReservationInfo();
			ri1.setMode(mode);			ri1.setSdate(sDate);
			ri1.setSspot(sPoint);		ri1.setEspot(ePoint);
			ri1.setLinenum(lineNum);
			session.setAttribute("ri1", ri1);
		} else {	// 왕복일 경우 (세션2개 생성)
			ReservationInfo ri1 =  new ReservationInfo();
			ri1.setMode(mode);		ri1.setSdate(sDate);	
			ri1.setSspot(sPoint);	ri1.setEspot(ePoint);
			ri1.setLinenum(lineNum);
			
			session.setAttribute("ri1", ri1);
			
			ReservationInfo ri2 =  new ReservationInfo();
			ri2.setMode(mode);		ri2.setSdate(eDate);
			ri2.setSspot(ePoint);	ri2.setEspot(sPoint);	// 반대로 저장
			ri2.setLinenum(lineNum);
			session.setAttribute("ri2", ri2);
		}
		
		List<ScheduleInfo> scheduleList = hTicketingSvc.getSList(sDate, lineNum);
		session.setAttribute("scheduleList", scheduleList);

		return "ticketing/h_ticket_step2";
	}
	
	@PostMapping("/hTicketingStep03")
	public String hTicketingStep03(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		
		
		ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
		String mode = ri1.getMode();
//		
//		if (mode.equals("p")) {	// 편도일경우 (세션 1개 생성)
//			
//			session.setAttribute("ri1", ri1);
//		} else {	// 왕복일 경우 (세션2개 생성)
//			session.setAttribute("ri1", ri1);
//			
//			ReservationInfo ri2 = (ReservationInfo) session.getAttribute("ri2");
//			session.setAttribute("ri2", ri2);
//		}
		
//		List<ScheduleInfo> seatList = hTicketingSvc.getSeatList(sDate, lineNum);
//		session.setAttribute("seatList", seatList);

		return "ticketing/h_ticket_step3";
	}
	
	
}
