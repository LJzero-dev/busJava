package svc;

import java.util.*;
import dao.*;
import vo.*;

public class ScheduleSvc {
	private ScheduleDao scheduleDao;

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	public int getLineidx(String sPoint, String ePoint, String busType) {
	// 받아온 출발지, 도착지, 버스구분 값을 이용하여 버스 노선을 구함
		int blidx = scheduleDao.getLineidx(sPoint, ePoint, busType);
		return blidx;
	}

	public List<ReservationStep2> getScheduleList(int blidx, String risday) {
	// 구해온 노선에 운영되는 시간표를 ReservationStep2형 getScheduleList인스턴스로 받아옴
		List<ReservationStep2> scheduleList = scheduleDao.getScheduleList(blidx, risday);
		return scheduleList;
	}

	public List<BusCompanyInfo> getBusCompany() {
	// 버스회사 정보를 BusCompanyInfo형 busCompany로
		List<BusCompanyInfo> busCompany = scheduleDao.getBusCompany();
		return busCompany;
	}

	public List<TerminalInfo> getDepartureTerminal(String selectedArea) {
	// 선택한 출발지역에 있는 터미널 이름
		List<TerminalInfo> departureTerminal = scheduleDao.getDepartureTerminal(selectedArea);
		return departureTerminal;
	}

	public List<LineInfo> getArrivalTerminal(String selectedTerminal) {
	// 선택한 출발 터미널에 해당하는 버스 노선을 select (도착 터미널 이름 + 라인 인덱스 사용)
		List<LineInfo> lineList = scheduleDao.getArrivalTerminal(selectedTerminal);
		return lineList;
	}

	public List<ArriveInfo> getArrivalTerminal(String arrivalTerminal, String busCompany, String time) {
	// 
		List<ArriveInfo> timeList = scheduleDao.getArrivalTerminal(arrivalTerminal, busCompany, time);
		return timeList;
	}
}
