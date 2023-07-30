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
// 시외버스 예매관련 모든 기능에 대한 컨트롤러
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
	
	@GetMapping("/sLineSch")
	@ResponseBody
	public List<LineInfo> sLineSch(@RequestParam int btsidx) {
		// btsidx에 해당하는 터미널 목록을 조회한 결과로 List<LineInfo>를 반환
        List<LineInfo> lineList = sTicketingSvc.getArrivalLineList(btsidx);
        return lineList;
	}
	
	@PostMapping("/sTicketingStep02")
	public String sTicketingStep02(HttpServletRequest request) throws Exception {
		// step1에서 보낸 mode, 가는 날(가는 날 / 오는 날), 출발터미널, 도착터미널 정보를 가지고 해당하는 노선의 시간표와 잔여 좌석 정보를 select
		request.setCharacterEncoding("utf-8");
		String mode = request.getParameter("mode");
		String ri_sday1 = request.getParameter("ri_sday1");		String ri_sday2 = request.getParameter("ri_sday2");
		String btsname = request.getParameter("btsname");		String btename = request.getParameter("btename");
		
		HttpSession session = request.getSession();	
		ReservationInfo ri1 =  new ReservationInfo();	// 편도/왕복의 가는 날 세션(ri1) 
		ri1.setMode(mode);			ri1.setSdate(ri_sday1);
		ri1.setSspot(btsname);		ri1.setEspot(btename);
		session.setAttribute("ri1", ri1);
		
		if (mode.equals("w")) {	// 왕복 예매일 경우 오는 날 세션(ri2)도 생성		/ 탑승일을 ri_sday2로 출발지와 도착지는 서로 크로스하여 입력
			ReservationInfo ri2 =  new ReservationInfo();
			ri2.setMode(mode);			ri2.setEdate(ri_sday2);
			ri1.setSspot(btename);		ri1.setEspot(btsname);
			session.setAttribute("ri2", ri2);
		}
		
		List<ReservationStep2>scheduleList = sTicketingSvc.getScheduleList(btsname, btename);
		request.setAttribute("scheduleList", scheduleList);
		
		return "ticketing/s_ticket_step2";
	}

}
