package svc;

import java.util.*;
import dao.*;
import vo.*;

public class TerminalSvc {
	private TerminalDao terminalDao;
	
	public void setTerminalDao(TerminalDao terminalDao) {
		this.terminalDao = terminalDao;
	}

	public List<TerminalInfo> getTerminalList(String kind) {
		List<TerminalInfo> terminalList = terminalDao.getTerminalList(kind);
		return terminalList;
	}

	public int chkTerminal(String name, String kind) {
		int result = terminalDao.chkTerminal(name, kind);
		return result;
	}

	public int terminalInsert(String name, String area, String kind) {
		int result = terminalDao.terminalInsert(name, area, kind);
		return result;
	}

	public List<BusLineInfo> getBusLine(int bt_idx, String kind) {
		List<BusLineInfo> busLineList = terminalDao.getBusLine(bt_idx, kind);
		return busLineList;
	}
	
	public List<BusInfo> getBusInfo(String kind) {
		List<BusInfo> busInfo = terminalDao.getBusInfo(kind);
		return busInfo;
	}
	
	public int LineDel(int bl_idx) {
		int result = terminalDao.LineDel(bl_idx);
		return result;
	}

	public List<TerminalInfo> getTerminalListPop(int bt_idx, String kind) {
		List<TerminalInfo> terminalList = terminalDao.getTerminalListPop(bt_idx, kind);
		return terminalList;
	}

	public int AddLineIn(String kind, int bt_sidx, int bt_eidx, int adult) {
		int result = terminalDao.AddLineIn(kind, bt_sidx, bt_eidx, adult);
		return result;
	}

	public int scheduleAdd(BusScheduleInfo busScheduleInfo, int adult, int bl_idx) {
		int result = terminalDao.scheduleAdd(busScheduleInfo, adult, bl_idx);
		return result;
	}

	public int changeLevel(String number, String kind) {
		int result = terminalDao.changeLevel(number, kind);
		return result;
	}

	public int delShcedule(int bsidx) {
		int result = terminalDao.delShcedule(bsidx);
		return result;
	}
	
}
