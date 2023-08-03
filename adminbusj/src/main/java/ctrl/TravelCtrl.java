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
public class TravelCtrl {
	private TravelSvc travelSvc;
	private String area, ctgr, title, content, isview; 

	public void setTravelSvc(TravelSvc travelSvc) {
		this.travelSvc = travelSvc;
	}
	
	@GetMapping("/travelList")
	public String travelList(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10, num = 0;
		// 현재페이지 번호, 페이지 수, 시작 페이지, 게시글 수, 페이지 크기, 블록 크기, 번호
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String schctgr = request.getParameter("schctgr");
		String isview = request.getParameter("isview");
		String where = " where 1 = 1 ";
		String args = "", schargs = "";
		if (schctgr != null && !schctgr.equals("")) {
			URLEncoder.encode(schctgr, "UTF-8");
			where = " and tl_ctgr like '" + schctgr + "'";
			schargs = "&schctgr=" + schctgr;
		}
		if (isview != null && !isview.equals("")) {
			where = " and tl_isview = '" + isview + "'";
			schargs = "&isview=" + isview;
		}
		if (schtype == null || keyword == null) {
			schtype = ""; keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();	
			where += " and tl_" + schtype + " like '%" + keyword + "%'";
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs;
		
		rcnt = travelSvc.getTraverListCount(where);
		
		List<TravelList> travelList = travelSvc.getTravelList(where, cpage, psize);
		
		pcnt = rcnt / psize;	if(rcnt % psize > 0)	pcnt++;
		spage = (cpage - 1) / bsize * bsize + 1;
		num = rcnt - (psize * (cpage - 1));
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);		pi.setCpage(cpage);		pi.setPcnt(pcnt);		pi.setPsize(psize);
		pi.setRcnt(rcnt);		pi.setSpage(spage);		pi.setNum(num);			pi.setSchtype(schtype);
		pi.setKeyword(keyword);	pi.setArgs(args);		pi.setSchargs(schargs); pi.setSchctgr(schctgr);
		pi.setIsview(isview);
		// 페이징에 필요한 정보들과 검색 조건을 PageInfo형 인스턴스에 저장
		
		model.addAttribute("travelList", travelList);
		model.addAttribute("pi", pi);
		
		return "/travel/travel_list";
	}
	
	@GetMapping("/travelForm")
	public String travelForm() {
		return "travel/travel_form";
	}
	
	@PostMapping("/travelIn")
	public String travelIn(MultipartFile uploadFile, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uploadPath = "E:/lsj/spring/busjava/adminbusj/src/main/webapp/resources/images/travel";
		String files = "";
		
		MultipartFile file = uploadFile;
		File saveFile = new File(uploadPath, file.getOriginalFilename());
		try {
			file.transferTo(saveFile);
			files += file.getOriginalFilename();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/travelView?files=" + files;
	}
	
	@GetMapping("/travelView")
	public String travelView(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String files = request.getParameter("files");
		model.addAttribute("files", files);
		return "travel/travel_view";
		
	}
}
