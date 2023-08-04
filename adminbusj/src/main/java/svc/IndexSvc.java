package svc;

import java.util.List;

import dao.*;
import vo.*;

public class IndexSvc {
	private IndexDao indexDao;

	public void setIndexDao(IndexDao indexDao) {
		this.indexDao = indexDao;
	}

	public List<String> getSales() {
		List<String> salesList = indexDao.getSales();
		return salesList;
	}
}
