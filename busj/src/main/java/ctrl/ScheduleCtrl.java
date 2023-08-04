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
	public String arrivaltime() {
		return "raceinfo/arrivaltime";
	}
}
