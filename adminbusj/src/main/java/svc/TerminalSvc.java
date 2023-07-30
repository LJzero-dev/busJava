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

	public List<BusLineInfo> getBusLine(int bt_idx) {
		List<BusLineInfo> busLineList = terminalDao.getBusLine(bt_idx);
		return busLineList;
	}
	
	public List<BusInfo> getBusInfo() {
		List<BusInfo> busInfo = terminalDao.getBusInfo();
		return busInfo;
	}
	
	public int LineDel(int bl_idx) {
		int result = terminalDao.LineDel(bl_idx);
		return result;
	}

	public List<TerminalInfo> getTerminalListPop(int bt_idx) {
		List<TerminalInfo> terminalList = terminalDao.getTerminalListPop(bt_idx);
		return terminalList;
	}

	public int AddLineIn(int bt_sidx, int bt_eidx, int adult) {
		int result = terminalDao.AddLineIn(bt_sidx, bt_eidx, adult);
		return result;
	}
	
}
