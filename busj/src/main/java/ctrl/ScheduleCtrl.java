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
	
	@GetMapping("/arrivaltime")
	public String arrivaltime() {
		return "raceinfo/arrivaltime";
	}
}
