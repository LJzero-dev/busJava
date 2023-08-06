package svc;

import java.util.*;

import org.springframework.transaction.annotation.Transactional;

import dao.*;
import vo.*;

public class HTicketingSvc {
	private HTicketingDao hTicketingDao;

	public void sethTicketingDao(HTicketingDao hTicketingDao) {
		this.hTicketingDao = hTicketingDao;
	}

	public List<TerminalInfo> getTerminalList() {
		List<TerminalInfo> terminalList = hTicketingDao.getTerminalList();
		return terminalList;
	}

	public List<LineInfo> getAvailableLineList(int btsidx) {
		List<LineInfo> lineList = hTicketingDao.getAvailableLineList(btsidx);
		return lineList;
	}

	public int getLineNum(String spoint, String epoint) {
		int lineNum = hTicketingDao.getLineNum(spoint, epoint);
		return lineNum;
	}

	public List<ScheduleInfo> getSList(String sDate, int lineNum) {
		List<ScheduleInfo> scheduleList = hTicketingDao.getSList(sDate, lineNum);
		return scheduleList;
	}

	public List<SeatInfo> getSeatList(String sDate, int bsidx) {
		List<SeatInfo> seatList = hTicketingDao.getSeatList(sDate, bsidx);
		return seatList;
	}

	@Transactional
	public int chargeAmount(MemberInfo loginInfo, String payment, int chargePmoney, int totalPmoney) {
	// 페이머니 충전 메서드	
		int result = 0;
		String uID = loginInfo.getMi_id();
		
		// 페이머니 충전내역 Insert
		result += hTicketingDao.chargeAmountIn(uID, payment, chargePmoney, totalPmoney);
		
		// 회원정보 테이블 Update
		result += hTicketingDao.chargeAmountUp(loginInfo, uID, totalPmoney);
		return result;
	}

	@Transactional
	public void reservationIn(MemberInfo loginInfo, ReservationInfo ri, String seatWhere) {
	// 예매 메서드
		int totalP = ri.getBasePrice();
		
		// 1. 예매 정보 테이블 insert
		String result = hTicketingDao.reservationIn(loginInfo, ri);
		// 인서트 성공시 성공한 ri_idx(예매번호) 리턴
		
		// 2. seatWhere 절에 맞는 좌석번호 리턴
		List<String> seatArr = hTicketingDao.getSeat(seatWhere);

		// 3. 예매 좌석 테이블 insert
		hTicketingDao.reservationSeatIn(result, seatArr);
		
		// 4. 결제방식이 페이머니인 경우에만 회원정보 테이블의 해당 회원 페이머니 잔액 업데이트 메서드 실행
		if (ri.getPayment().equals("페이머니")) {
			hTicketingDao.reservationUserUp(loginInfo, ri, totalP);
		}
		
		// 5. 회원 결제내역 테이블 insert
		hTicketingDao.reservationPayIn(result, loginInfo, ri, totalP);
		
		// 6. 예매 매출 집계 테이블 insert 
		hTicketingDao.reservationCntIn(result, ri, totalP);
	}


	
	
}
