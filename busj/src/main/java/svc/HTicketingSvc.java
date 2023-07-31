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

	public List<SeatInfo> getSeatList(int bsidx) {
		List<SeatInfo> seatList = hTicketingDao.getSeatList(bsidx);
		return seatList;
	}

	
	
}
