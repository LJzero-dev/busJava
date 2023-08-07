package svc;

import java.util.*;
import dao.*;
import vo.*;

public class SalesSvc {
	private SalesDao salesDao;

	public void setSalesDao(SalesDao salesDao) {
		this.salesDao = salesDao;
	}

	public List<SalesInfo> getSalesList() {
		List<SalesInfo> salesList = salesDao.getSalesList();
		return salesList;
	}
	

}
