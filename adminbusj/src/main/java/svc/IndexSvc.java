package svc;

import java.util.*;

import com.fasterxml.jackson.core.JsonProcessingException;

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

   public String getTopLine(String linetype) throws JsonProcessingException {
      String topLineList = indexDao.getTopLine(linetype);
      return topLineList;
   }

	public List<String> getSalesByQuarter(int i, String linetype) {
		List<String> salesQuarterList = indexDao.getSalesByQuarter(i, linetype);
		return salesQuarterList;
	}
}