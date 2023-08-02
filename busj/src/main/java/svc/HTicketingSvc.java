package svc;

import java.util.*;

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

	public int chargeAmount(String miid, String payment, int chargePmoney, int totalPmoney) {
		int result = 0;
		
		// 페이머니 충전내역 Insert
		result += hTicketingDao.chargeAmountIn(miid, payment, chargePmoney, totalPmoney);
		
		// 회원정보 테이블 Update
		result += hTicketingDao.chargeAmountUp(miid, totalPmoney);
		
		System.out.println(result);
		return chargePmoney;
	}


	
	
}
