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
}
