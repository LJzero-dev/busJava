package ctrl;

import java.io.*;
import java.net.URLEncoder;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@Controller
public class SalesCtrl {
	private SalesSvc salesSvc;
	
	public void setSalesSvc(SalesSvc salesSvc) {
		this.salesSvc = salesSvc;
	}
	
	@GetMapping("/salesList")
	public String salesList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		List<SalesInfo> salesList = salesSvc.getSalesList();
		
		HttpSession session = request.getSession();
		session.setAttribute("salesList", salesList);
		
		return "/stats/all_sales_list";
		
	}
	
	@GetMapping("/paymoneyList")
	public String paymoneyList(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String where = "where 1 = 1 ";
		String mi_id = request.getParameter("mi_id");
		String sdate = request.getParameter("sDate2-1");
		String edate = request.getParameter("eDate2-1");
		
		if (mi_id != null && !mi_id.equals("")) {
			where += " and mi_id = '" + mi_id +"' ";
		}
		if (sdate != null && !sdate.equals("") ) {
			where += " and mph_date > '" + sdate + "' ";
		}
		
		List<PaymoneyInfo> paymoneyList = salesSvc.getPaymoneyList(where);
		model.addAttribute("paymoneyList", paymoneyList);
		
		return "/sales/paymoney_list";
	}
	
}	