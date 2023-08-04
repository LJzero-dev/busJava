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

	public int travelIn(TravelList tr) {
		int tl_idx = travelDao.travelIn(tr);
		return tl_idx;
	}

	public TravelList getTravelView(int tl_idx) {
		TravelList tr = travelDao.getTravelView(tl_idx);
		return tr;
	}

}
