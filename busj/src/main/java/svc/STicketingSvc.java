package svc;

import java.util.*;
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

	public List<LineInfo> getArrivalLineList(int btsidx) {
		List<LineInfo> lineList = sTicketingDao.getArrivalLineList(btsidx);
		return lineList;
	}

	public int getsLineNum(String btsname, String btename) {
	// 받아온 출발지와 도착지를 이용하여 노선을 구함
		int blidx = sTicketingDao.getsLineNum(btsname, btename);
		return blidx;
	}
	
	public List<ReservationStep2> getScheduleList(int blidx, String ri_sday1) {
	// 구해온 노선에 운영되는 시간표를 ReservationStep2형 scheduleList인스턴스로 받아옴
		List<ReservationStep2> scheduleList = sTicketingDao.getScheduleList(blidx, ri_sday1);
		return scheduleList;
	}

	public List<SeatInfo> getSeatList(int bsidx, String ri_sday1) {
	// 선택한 시간에 운행하는 버스번호와 좌석정보를 불러옴 예매 테이블에서 기 예매된 좌석이 있는지 확인
		List<SeatInfo> seatList = sTicketingDao.getSeatList(bsidx, ri_sday1);
		return seatList;
	}
	
}

