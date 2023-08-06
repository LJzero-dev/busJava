package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.JsonProcessingException;

import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.util.*;
import svc.*;
import vo.*;

@Controller
public class IndexCtrl {
   private IndexSvc indexSvc;
   
   public void setIndexSvc(IndexSvc indexSvc) {
      this.indexSvc = indexSvc;
   }
   
   @GetMapping("/")
   public String index(HttpServletRequest request) throws JsonProcessingException {
      HttpSession session = request.getSession();
      List<String> salesList = indexSvc.getSales();
      String hTopLinelist = indexSvc.getTopLine("고속");
      String sTopLinelist = indexSvc.getTopLine("시외");
      
      List<String> hSalesQuarterLast = indexSvc.getSalesByQuarter(-1, "고속");
      List<String> hSalesQuarterNow = indexSvc.getSalesByQuarter(0, "고속");
      
      List<String> sSalesQuarterLast = indexSvc.getSalesByQuarter(-1, "시외");
      List<String> sSalesQuarterNow = indexSvc.getSalesByQuarter(0, "시외");
      
      session.setAttribute("salesList", salesList);
      session.setAttribute("hTopLinelist", hTopLinelist);
      session.setAttribute("sTopLinelist", sTopLinelist);
      session.setAttribute("hSalesQuarterLast", hSalesQuarterLast);
      session.setAttribute("hSalesQuarterNow", hSalesQuarterNow);
      session.setAttribute("sSalesQuarterLast", sSalesQuarterLast);
      session.setAttribute("sSalesQuarterNow", sSalesQuarterNow);
      return "index";
   }
}