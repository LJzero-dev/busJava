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
		String ri_sday3 = request.getParameter("ri_sday3");
		String btsname = request.getParameter("sPoint");		String btename = request.getParameter("ePoint");
		
		int blidx = sTicketingSvc.getsLineNum(btsname, btename);
		
		HttpSession session = request.getSession();	
		ReservationInfo ri1 =  new ReservationInfo();	// 편도/왕복의 가는 날 세션(ri1) 
		ri1.setMode(mode);			ri1.setSdate(ri_sday1);
		ri1.setSspot(btsname);		ri1.setEspot(btename);		ri1.setLinenum(blidx);
		session.setAttribute("ri1", ri1);
		
		if (mode.equals("w")) {	// 왕복 예매일 경우 오는 날 세션(ri2)도 생성		/ 탑승일을 ri_sday2로 출발지와 도착지는 서로 크로스하여 입력
			ReservationInfo ri2 =  new ReservationInfo();
			ri1.setMode(mode);			ri2.setMode(mode);			ri2.setSdate(ri_sday3);
			ri2.setSspot(btename);		ri2.setEspot(btsname);
			session.setAttribute("ri2", ri2);
		}
		
		List<ReservationStep2>scheduleList = sTicketingSvc.getScheduleList(blidx, ri_sday1);
		request.setAttribute("scheduleList", scheduleList);
		
		return "ticketing/s_ticket_step2";
	}
	
	@PostMapping("/sTicketingStep03")
	public String sTicketingStep03(HttpServletRequest request, HttpServletResponse response) throws Exception {
	// bs_idx로 버스 운영시간표 (출발시간, 도착시간) / bi_idx로 조인해서 버스 좌석 정보 (좌석 번호) 가져오기
	// 예매된 좌석은 선택이 되지 않게 (checkbox 비활성화)
		request.setCharacterEncoding("utf-8");
		int bsidx = Integer.parseInt(request.getParameter("bsidx"));
		
		String bcname = request.getParameter("bcname");		String bilevel = request.getParameter("bilevel");
		String stime = request.getParameter("stime");		String etime = request.getParameter("etime");
		int bladult = Integer.parseInt(request.getParameter("bladult"));
		int totalseat = Integer.parseInt(request.getParameter("totalseat"));
		int leftseat = Integer.parseInt(request.getParameter("leftseat"));
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();	
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		ReservationInfo ri1 = (ReservationInfo)session.getAttribute("ri1");
		
		if (loginInfo == null || ri1 == null) {	// ri1 객체가 null인 경우에 대한 처리
		    out.println("<script>");
		    out.println("alert('시간이 경과되었습니다.\\예매를 다시 시도해주세요.')");
		    out.println("location.href='sTicketingStep01';");
		    out.println("</script>");
		    out.close();
		}
		
		ri1.setBs_idx(bsidx);		ri1.setComname(bcname);		ri1.setLevel(bilevel);	ri1.setPrice(bladult);
		ri1.setStime(stime);		ri1.setEtime(etime);		ri1.setBs_idx(bsidx);	

		if (request.getParameter("ri_sday1") != null && !request.getParameter("ri_sday1").equals("")) 
			ri1.setSdate(request.getParameter("ri_sday1"));	
		
		String ri_sday1 = ri1.getSdate();					// 바뀐 값이 있으면 세션에 다시 담기
		
		List<SeatInfo> seatList = sTicketingSvc.getSeatList(bsidx, ri_sday1);
		request.setAttribute("seatList", seatList);
		
		return "ticketing/s_ticket_step3";
	}
	
	@PostMapping("/sTicketingPay")
	public String sTicketingStep04P(HttpServletRequest request, HttpServletResponse response) throws Exception {
	// 연령별 좌석 매수, 예매좌석 번호, 총 예매 금액(연령별 예매금액)
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();	
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		ReservationInfo ri1 = (ReservationInfo)session.getAttribute("ri1");	
		ReservationInfo ri2 = (ReservationInfo)session.getAttribute("ri2");

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (loginInfo == null || ri1 == null) {	// ri1 객체가 null인 경우에 대한 처리
		    out.println("<script>");
		    out.println("alert('시간이 경과되었습니다.\\예매를 다시 시도해주세요.')");
		    out.println("location.href='sTicketingStep01';");
		    out.println("</script>");
		    out.close();
		} else {
			if (ri1.getMode().equals("p")) {	// 편도일 경우
				ri1.setRi_acnt(Integer.parseInt(request.getParameter("riacnt")));
				ri1.setRi_scnt(Integer.parseInt(request.getParameter("riscnt")));
				ri1.setRi_ccnt(Integer.parseInt(request.getParameter("riccnt")));
				String[] seatsGo = request.getParameterValues("seatBoxDtl");
				String seatListGo = "";
				for (String seatGo : seatsGo) {
					seatListGo += ", " + seatGo;
				}
				ri1.setSeat(request.getParameter("selectedSeats"));
				ri1.setSi_idx(request.getParameter("selectedSeatsIndexes"));
				ri1.setBasePrice(Integer.parseInt(request.getParameter("basePrice")));
				
				session.setAttribute("seatsGo", seatsGo);

			} else {
				ri2.setRi_acnt(Integer.parseInt(request.getParameter("riacnt")));
				ri2.setRi_scnt(Integer.parseInt(request.getParameter("riscnt")));
				ri2.setRi_ccnt(Integer.parseInt(request.getParameter("riccnt")));
				String[] seatsCome = request.getParameterValues("seatBoxDtl");
				String seatListCome = "";
				for (String seatCome : seatsCome) {
					seatListCome += ", " + seatCome;
				}
				ri2.setSeat(request.getParameter("selectedSeats"));
				ri2.setSi_idx(request.getParameter("selectedSeatsIndexes"));
				ri2.setBasePrice(Integer.parseInt(request.getParameter("basePrice2")));
				
				session.setAttribute("seatsCome", seatsCome);
			}
		} 
		return "ticketing/s_ticket_pay";
	}
	
	@PostMapping("/sTicketingStep04")
	public String sTicketingStep04W(HttpServletRequest request, HttpServletResponse response) throws Exception {
	// 
		HttpSession session = request.getSession();	
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		ReservationInfo ri1 = (ReservationInfo)session.getAttribute("ri1");
		ReservationInfo ri2 = (ReservationInfo)session.getAttribute("ri2");

		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (loginInfo == null || ri1 == null || ri2 == null) {	// ri1, ri2 객체가 null인 경우에 대한 처리
		    out.println("<script>");
		    out.println("alert('시간이 경과되었습니다.\\예매를 다시 시도해주세요.')");
		    out.println("location.href='sTicketingStep01';");
		    out.println("</script>");
		    out.close();
		} else {
			ri1.setRi_acnt(Integer.parseInt(request.getParameter("riacnt")));
			ri1.setRi_scnt(Integer.parseInt(request.getParameter("riscnt")));
			ri1.setRi_ccnt(Integer.parseInt(request.getParameter("riccnt")));
			ri1.setSeat(request.getParameter("selectedSeats"));
			ri1.setSi_idx(request.getParameter("selectedSeatsIndexes"));
			ri1.setBasePrice(Integer.parseInt(request.getParameter("basePrice")));
		}
		String btsname = ri2.getSspot();
		String btename = ri2.getEspot();
		String ri_sday3 = ri2.getSdate();
		int blidx = sTicketingSvc.getsLineNum(btsname, btename);
		
		
		List<ReservationStep2>scheduleList = sTicketingSvc.getScheduleList(blidx, ri_sday3);
		request.setAttribute("scheduleList", scheduleList);
		
		return "ticketing/s_ticket_step4";
	}
	
	@PostMapping("/sTicketingStep05")
	public String sTicketingStep05(HttpServletRequest request, HttpServletResponse response) throws Exception {
	// bs_idx로 버스 운영시간표 (출발시간, 도착시간) / bi_idx로 조인해서 버스 좌석 정보 (좌석 번호) 가져오기
	// 예매된 좌석은 선택이 되지 않게 (checkbox 비활성화)
		request.setCharacterEncoding("utf-8");
		int bsidx = Integer.parseInt(request.getParameter("bsidx"));
		
		String bcname = request.getParameter("bcname");		String bilevel = request.getParameter("bilevel");
		String stime = request.getParameter("stime");		String etime = request.getParameter("etime");
		int bladult = Integer.parseInt(request.getParameter("bladult"));
		int totalseat = Integer.parseInt(request.getParameter("totalseat"));
		int leftseat = Integer.parseInt(request.getParameter("leftseat"));
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();	
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		ReservationInfo ri1 = (ReservationInfo)session.getAttribute("ri1");
		ReservationInfo ri2 = (ReservationInfo)session.getAttribute("ri2");
		
		if (loginInfo == null || ri1 == null || ri2 == null) {	// ri1 객체가 null인 경우에 대한 처리
		    out.println("<script>");
		    out.println("alert('시간이 경과되었습니다.\\예매를 다시 시도해주세요.')");
		    out.println("location.href='sTicketingStep01';");
		    out.println("</script>");
		    out.close();
		}
		
		ri2.setBs_idx(bsidx);		ri2.setComname(bcname);		ri2.setLevel(bilevel);	ri2.setPrice(bladult);
		ri2.setStime(stime);		ri2.setEtime(etime);		ri2.setBs_idx(bsidx);	

		if (request.getParameter("ri_sday3") != null && !request.getParameter("ri_sday3").equals("")) 
			ri2.setSdate(request.getParameter("ri_sday3"));	
		
		String ri_sday3 = ri2.getSdate();					// 바뀐 값이 있으면 세션에 다시 담기
		
		List<SeatInfo> seatList = sTicketingSvc.getSeatList(bsidx, ri_sday3);
		request.setAttribute("seatList", seatList);
		
		return "ticketing/s_ticket_step5";
	}
	
	@PostMapping("/sTicketingResult")
	public String sTicketingResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
	// 결제 완료된 예매 건을 db에 저장하여 예매확인 내역 형식으로 보여줌
		request.getParameter("utf-8");
		
		String payment = request.getParameter("paymentOpt");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo) session.getAttribute("loginInfo");
		ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
		ReservationInfo ri2 = null;
		String[] seatsGo = (String[]) session.getAttribute("seatsGo");
		
		ri1.setPayment(payment);
		
		String seatWhereGo = " WHERE BS.bi_idx = SI.bi_idx AND BS.bl_idx = " + ri1.getLinenum() + " AND BS.bs_stime = '" + ri1.getStime() + "'";
		for (int i = 0 ; i < seatsGo.length ; i++) {
				if (i == 0) seatWhereGo += " and (SI.si_seat = " + seatsGo[i];
				else		seatWhereGo += " or SI.si_seat = " + seatsGo[i];
		}
		seatWhereGo += ")";
		
		String seatWhereCome = "";
		if (ri1.getMode().equals("w")) {
			ri2 = (ReservationInfo) session.getAttribute("ri2");
			String[] seatsCome = (String[]) session.getAttribute("seatsCome");
			if (ri2 != null) {
				seatWhereCome += " WHERE BS.bi_idx = SI.bi_idx AND BS.bl_idx = " + ri2.getLinenum() + " AND BS.bs_stime = '" + ri2.getStime() + "'";
				for (int i = 0 ; i < seatsCome.length ; i++) {
						if (i == 0) seatWhereCome += " and (SI.si_seat = " + seatsCome[i];
						else		seatWhereCome += " or SI.si_seat = " + seatsCome[i];
				}
				seatWhereCome += ")";
			}
			
			ri2.setPayment(payment);
		}
		
		sTicketingSvc.reservationIn(loginInfo, ri1, seatWhereGo);
		if (ri2 != null) {
			sTicketingSvc.reservationIn(loginInfo, ri2, seatWhereCome);
		}

		
		return "ticketing/s_ticket_result";
	}

}
