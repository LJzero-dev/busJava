package svc;

import java.util.List;
import dao.*;
import vo.*;

public class STicketingSvc {
	private STicketingDao sTicketingDao;

	public void setSTicketingDao(STicketingDao sTicketingDao) {
		this.sTicketingDao = sTicketingDao;
	}
	
	public List<TerminalInfo> pickSpotSlow() {
		List<TerminalInfo> terminalList = sTicketingDao.pickSpotSlow();
		return terminalList;
	}
}
