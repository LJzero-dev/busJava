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
	
}
