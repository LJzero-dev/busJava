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
	
}	