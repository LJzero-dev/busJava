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

	@GetMapping("/pmoneyInfo")
	public String pmoneyInfo() {
		return "member/paymoney_info";
	}

	@GetMapping("/pmoneyCharge1")
	public String pmoneyCharge1() {
		return "popup/paymoney_charge1";
	}

	@GetMapping("/pmoneyCharge2")
	public String pmoneyCharge2() {
		return "popup/paymoney_charge2";
	}

	@PostMapping("/chargePmoney")
	@ResponseBody
	public int chargePmoney(HttpServletRequest request, @RequestParam String payment, @RequestParam int chargePmoney) {
		// chargePmoney에 해당하는 값을 해당 회원의 아이디에 충전후 충전금액 리턴
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo) session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();

		if (payment.equals("card"))
			payment = "카드";
		else if (payment.equals("bankbook"))
			payment = "무통장입금";
		else if (payment.equals("simplepay"))
			payment = "간편결제";

		int totalPmoney = chargePmoney + (chargePmoney / 10); // 실 충전금액

		hTicketingSvc.chargeAmount(loginInfo, payment, chargePmoney, totalPmoney);
		return chargePmoney; // 큰 의미없음

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
	public Map<String, Integer> getLineNum(@RequestParam String spoint, @RequestParam String epoint) {
		// 출발지, 도착지 이름에 따른 노선번호 반환
		int sLineNum = hTicketingSvc.getLineNum(spoint, epoint);
		int eLineNum = hTicketingSvc.getLineNum(epoint, spoint);
		
		Map<String, Integer> lineNumbers = new HashMap<>();
	    lineNumbers.put("sLineNum", sLineNum);
	    lineNumbers.put("eLineNum", eLineNum);

	    return lineNumbers;
	}

	@PostMapping("/hTicketingStep02")
	public String hTicketingStep02(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String mode = request.getParameter("mode");
		String sDate = request.getParameter("sDate1-1").replace('.', '-');
		
		String sPoint = request.getParameter("sPoint");
		String ePoint = request.getParameter("ePoint");
		int sLineNum = Integer.parseInt(request.getParameter("sLineNum"));

		HttpSession session = request.getSession();

		ReservationInfo ri1 = new ReservationInfo();
		ri1.setMode(mode);
		ri1.setSdate(sDate);
		ri1.setSspot(sPoint);
		ri1.setEspot(ePoint);
		ri1.setLinenum(sLineNum);
		
		if (mode.equals("w")) { // 왕복일경우 오는날 예약정보를 담을 세션 추가생성
			String eDate = request.getParameter("eDate1-1").replace('.', '-');
			int eLineNum = Integer.parseInt(request.getParameter("eLineNum"));
			
			ReservationInfo ri2 = new ReservationInfo();
			ri2.setMode(mode);
			ri2.setSdate(eDate);
			ri2.setSspot(ePoint);
			ri2.setEspot(sPoint);
			ri2.setLinenum(eLineNum);
			session.setAttribute("ri2", ri2);
		} 

		List<ScheduleInfo> scheduleList = hTicketingSvc.getSList(sDate, sLineNum);
		session.setAttribute("scheduleList", scheduleList);
		session.setAttribute("ri1", ri1);
		
		return "ticketing/h_ticket_step2";
	}

	@PostMapping("/hTicketingStep03")
	public String hTicketingStep03(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int bsidx = Integer.parseInt(request.getParameter("bsidx"));
		String stime = request.getParameter("stime");
		String etime = request.getParameter("etime");
		int price = Integer.parseInt(request.getParameter("price"));
		String comname = request.getParameter("comname");
		String bllevel = request.getParameter("bllevel");

		HttpSession session = request.getSession();

		ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
		String mode = ri1.getMode();
		String sDate = ri1.getSdate();

		ri1.setStime(stime);
		ri1.setEtime(etime);
		ri1.setPrice(price);
		ri1.setBs_idx(bsidx);
		ri1.setComname(comname);
		ri1.setLevel(bllevel);
		session.setAttribute("ri1", ri1);

		List<SeatInfo> seatList = hTicketingSvc.getSeatList(sDate, bsidx);
		session.setAttribute("seatList", seatList);

		return "ticketing/h_ticket_step3";
	}

	@PostMapping("/hTicketingStep04")
	public String hTicketingStep04(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		ReservationInfo ri1 = (ReservationInfo)session.getAttribute("ri1");
		int acnt = Integer.parseInt(request.getParameter("adult"));
		int tcnt = Integer.parseInt(request.getParameter("teen"));
		int ccnt = Integer.parseInt(request.getParameter("child"));
		int basePrice = Integer.parseInt(request.getParameter("basePrice"));
		String[] seatsGo = request.getParameterValues("seatBoxDtl");
		String seatListGo = "";
		for (String seatGo : seatsGo) {
			seatListGo += ", " + seatGo;
		}
		
		ri1.setRi_acnt(acnt);
		ri1.setRi_scnt(tcnt);
		ri1.setRi_ccnt(ccnt);
		ri1.setBasePrice(basePrice);
		ri1.setSeat(seatListGo.substring(2));
		session.setAttribute("ri1", ri1);
		
		ReservationInfo ri2 = (ReservationInfo)session.getAttribute("ri2");
		
		List<ScheduleInfo> scheduleList = hTicketingSvc.getSList(ri2.getSdate(), ri2.getLinenum());
		session.setAttribute("scheduleList", scheduleList);
		session.setAttribute("seatsGo", seatsGo);
		
		return "ticketing/h_ticket_step4";
	}
	
	@PostMapping("/hTicketingStep05")
	public String hTicketingStep05(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int bsidx = Integer.parseInt(request.getParameter("bsidx"));
		String stime = request.getParameter("stime");
		String etime = request.getParameter("etime");
		int price = Integer.parseInt(request.getParameter("price"));
		String comname = request.getParameter("comname");
		String bllevel = request.getParameter("bllevel");

		HttpSession session = request.getSession();

		ReservationInfo ri2 = (ReservationInfo) session.getAttribute("ri2");

		ri2.setStime(stime);
		ri2.setEtime(etime);
		ri2.setPrice(price);
		ri2.setBs_idx(bsidx);
		ri2.setComname(comname);
		ri2.setLevel(bllevel);
		session.setAttribute("ri2", ri2);

		List<SeatInfo> seatList = hTicketingSvc.getSeatList(ri2.getSdate(), bsidx);
		session.setAttribute("seatList", seatList);

		return "ticketing/h_ticket_step5";
	}
	
	@PostMapping("/hTicketingPay")
	public String hTicketingPay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		ReservationInfo ri1 = (ReservationInfo)session.getAttribute("ri1");
		
		if(ri1.getMode().equals("p")) {	// 편도일 경우
			int acnt = Integer.parseInt(request.getParameter("adult"));
			int tcnt = Integer.parseInt(request.getParameter("teen"));
			int ccnt = Integer.parseInt(request.getParameter("child"));
			int basePrice = Integer.parseInt(request.getParameter("basePrice"));
			String[] seatsGo = request.getParameterValues("seatBoxDtl");
			String seatListGo = "";
			for (String seatGo : seatsGo) {
				seatListGo += ", " + seatGo;
			}
			
			ri1.setRi_acnt(acnt);
			ri1.setRi_scnt(tcnt);
			ri1.setRi_ccnt(ccnt);
			ri1.setBasePrice(basePrice);
			ri1.setSeat(seatListGo.substring(2));
			session.setAttribute("ri1", ri1);
			session.setAttribute("seatsGo", seatsGo);
		} else {	// 왕복일 경우
			ReservationInfo ri2 = (ReservationInfo)session.getAttribute("ri2");
			int acnt = Integer.parseInt(request.getParameter("adult"));
			int tcnt = Integer.parseInt(request.getParameter("teen"));
			int ccnt = Integer.parseInt(request.getParameter("child"));
			int basePrice = Integer.parseInt(request.getParameter("basePrice"));
			String[] seatsCome = request.getParameterValues("seatBoxDtl");
			String seatListCome = "";
			for (String seatCome : seatsCome) {
				seatListCome += ", " + seatCome;
			}
			
			ri2.setRi_acnt(acnt);
			ri2.setRi_scnt(tcnt);
			ri2.setRi_ccnt(ccnt);
			ri2.setBasePrice(basePrice);
			ri2.setSeat(seatListCome.substring(2));
			
			session.setAttribute("ri2", ri2);
			session.setAttribute("seatsCome", seatsCome);
		}

		return "ticketing/h_ticket_pay";
	}
	
	@PostMapping("/hTicketingResult")
	public String hTicketingResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
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
		
		hTicketingSvc.reservationIn(loginInfo, ri1, seatWhereGo);
		if (ri2 != null) {
			hTicketingSvc.reservationIn(loginInfo, ri2, seatWhereCome);
		}

		return "ticketing/h_ticket_result";
	}

}
