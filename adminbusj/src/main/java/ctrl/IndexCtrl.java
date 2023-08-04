package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
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
	public String index(HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<String> salesList = indexSvc.getSales();
		session.setAttribute("salesList", salesList);
		return "index";
	}
}
