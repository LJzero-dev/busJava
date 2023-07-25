package svc;

import java.util.*;
import dao.*;
import vo.*;

public class TerminalSvc {
	private TerminalDao terminalDao;
	
	public void setTerminalDao(TerminalDao terminalDao) {
		this.terminalDao = terminalDao;
	}

	public List<TerminalInfo> getTerminalList() {
		List<TerminalInfo> terminalList = terminalDao.getTerminalList();
		return terminalList;
	}

	public int chkTerminal(String name) {
		int result = terminalDao.chkTerminal(name);
		return result;
	}

	public int terminalInsert(String name, String area) {
		int result = terminalDao.terminalInsert(name, area);
		return result;
	}

	public List<TerminalLineInfo> getTerminalLine(String bt_name) {
		List<TerminalLineInfo> terminalLine = terminalDao.getTerminalLine(bt_name);
		return terminalLine;
	}
}
