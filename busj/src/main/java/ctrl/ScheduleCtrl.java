package ctrl;

import java.util.*;
import java.io.*;
import java.lang.invoke.CallSite;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import svc.*;
import vo.*;

@Controller
public class ScheduleCtrl {
// 시간표 조회와 도착시간 관련 모든 기능에 대한 컨트롤러
	private ScheduleSvc scheduleSvc;
	
	public void setScheduleSvc(ScheduleSvc scheduleSvc) {
		this.scheduleSvc = scheduleSvc;
	}
	
	@GetMapping("/schedule")
	public String schedule() {
		return "raceinfo/schedule";
	}
	
	@PostMapping("/getSchedule")
	@ResponseBody
	public List<ReservationStep2> getSchedule(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String sPoint = request.getParameter("sPoint");
		String ePoint = request.getParameter("ePoint");
		String busType = request.getParameter("busType");
		String risday = request.getParameter("risday");
		
		int blidx = scheduleSvc.getLineidx(sPoint, ePoint, busType);
		
		System.out.println(blidx);	System.out.println(risday);
		
		List<ReservationStep2> scheduleList = scheduleSvc.getScheduleList(blidx, risday);
		
		
		return scheduleList;
	}
	
	@GetMapping("/arrivaltime")
	public String arrivaltime(Model model) {
		List<BusCompanyInfo> busCompany = scheduleSvc.getBusCompany();
		model.addAttribute("busCompany", busCompany);
		
		return "raceinfo/arrivaltime";
	}
	
	@PostMapping("/getDepartureTerminal")
	@ResponseBody
	public List<TerminalInfo> getDepartureTerminal(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String selectedArea = request.getParameter("selectedArea");
//		System.out.println(selectedArea);
		List<TerminalInfo> departureTerminal = scheduleSvc.getDepartureTerminal(selectedArea);

		return departureTerminal;
	}
	
	@PostMapping("/getArrivalTerminal")
	@ResponseBody
	public List<LineInfo> getArrivalTerminal(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String selectedTerminal = request.getParameter("selectedTerminal");
//		System.out.println(selectedTerminal);
		List<LineInfo> lineList = scheduleSvc.getArrivalTerminal(selectedTerminal);
		
		return lineList;
	}
	
	@PostMapping("/getArrivalTime")
	@ResponseBody
	public List<ArriveInfo> getArrivalTime(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String arrivalTerminal = request.getParameter("arrivalTerminal");	// 노선 인덱스 (bl_idx)
		String busCompany = request.getParameter("busCompany");				// 버스회사 인덱스 (bc_idx)
		String time = request.getParameter("time");							// 현재시간 (hh:mm)
		
		List<ArriveInfo> timeList = scheduleSvc.getArrivalTerminal(arrivalTerminal, busCompany, time);
		
		return timeList;
	}
}
