package svc;

import java.util.*;
import dao.*;
import vo.*;

public class TerminalSvc {
	private TerminalDao terminalDao;
	
	public void setTerminalDao(TerminalDao terminalDao) {
		this.terminalDao = terminalDao;
	}

	public ArrayList<TerminalInfo> getTerminalList() {
		ArrayList<TerminalInfo> terminalList = new ArrayList<TerminalInfo>();
		terminalList = terminalDao.getTerminalList();
		return terminalList;
	}
}
