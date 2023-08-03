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

		if (mode.equals("p")) { // 편도일경우 (세션 1개 생성)
			ReservationInfo ri1 = new ReservationInfo();
			ri1.setMode(mode);
			ri1.setSdate(sDate);
			ri1.setSspot(sPoint);
			ri1.setEspot(ePoint);
			ri1.setLinenum(lineNum);
			session.setAttribute("ri1", ri1);
		} else { // 왕복일 경우 (세션2개 생성)
			ReservationInfo ri1 = new ReservationInfo();
			ri1.setMode(mode);
			ri1.setSdate(sDate);
			ri1.setSspot(sPoint);
			ri1.setEspot(ePoint);
			ri1.setLinenum(lineNum);

			session.setAttribute("ri1", ri1);

			ReservationInfo ri2 = new ReservationInfo();
			ri2.setMode(mode);
			ri2.setSdate(eDate);
			ri2.setSspot(ePoint);
			ri2.setEspot(sPoint); // 반대로 저장
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

		// 편도, 왕복 상관없음
		ri1.setStime(stime);
		ri1.setEtime(etime);
		ri1.setPrice(price);
		ri1.setBs_idx(bsidx);
		ri1.setComname(comname);
		ri1.setLevel(bllevel);
		session.setAttribute("ri1", ri1);

		List<SeatInfo> seatList = hTicketingSvc.getSeatList(sDate, bsidx);
		// 일자도 포함하여 좌석정보 가져올 수 있도록 수정필요
		session.setAttribute("seatList", seatList);

		return "ticketing/h_ticket_step3";
	}

	@PostMapping("/hTicketingStep04P")
	public String hTicketingStep04P(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int acnt = Integer.parseInt(request.getParameter("adult"));
		int tcnt = Integer.parseInt(request.getParameter("teen"));
		int ccnt = Integer.parseInt(request.getParameter("child"));
		String[] seats1 = request.getParameterValues("seatBoxDtl");

		HttpSession session = request.getSession();

		ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
		ri1.setRi_acnt(acnt);
		ri1.setRi_scnt(tcnt);
		ri1.setRi_ccnt(ccnt);
		session.setAttribute("ri1", ri1);
		session.setAttribute("seats1", seats1);

		return "ticketing/h_ticket_step4p";
	}

	@PostMapping("/hTicketingStep05P")
	public String hTicketingStep05P(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String payment = request.getParameter("paymentOpt");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo) session.getAttribute("loginInfo");
		ReservationInfo ri1 = (ReservationInfo) session.getAttribute("ri1");
		String[] seats1 = (String[]) session.getAttribute("seats1");
		
		ri1.setPayment(payment);
	
		String seatWhere = " WHERE BS.bi_idx = SI.bi_idx AND BS.bl_idx = " + ri1.getLinenum() + " AND BS.bs_stime = '" + ri1.getStime() + "'";
		for (int i = 0 ; i < seats1.length ; i++) {
				if (i == 0) seatWhere += " and (SI.si_seat = " + seats1[i];
				else		seatWhere += " or SI.si_seat = " + seats1[i];
		}
		seatWhere += ")";

		hTicketingSvc.reservationIn(loginInfo, ri1, seatWhere);

		return "ticketing/h_ticket_step5p";
	}

}
