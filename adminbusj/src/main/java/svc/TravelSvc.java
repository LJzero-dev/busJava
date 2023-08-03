package svc;

import java.util.*;
import dao.*;
import vo.*;

public class TravelSvc {
	private TravelDao travelDao;

	public void setTravelDao(TravelDao travelDao) {
		this.travelDao = travelDao;
	}

	public int getTraverListCount(String where) {
		int rcnt = travelDao.getTraverListCount(where);
		return rcnt;
	}

	public List<TravelList> getTravelList(String where, int cpage, int psize) {
		List<TravelList> travelList = travelDao.getTravelList(where, cpage, psize);
		return travelList;
	}

}
