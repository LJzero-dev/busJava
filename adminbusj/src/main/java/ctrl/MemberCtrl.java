package ctrl;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class MemberCtrl {
	private MemberSvc memberSvc;

	public void setMemberSvc(MemberSvc memberSvc) {
		this.memberSvc = memberSvc;
	}
	
	@GetMapping("/memberList")
	public String memberList(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10, num = 0;
		//현제페이지 번호, 페이지 수, 시작페이지 , 게시글수, 페이지크기(내가 정하는 값), 블록크기(내가 정하는 값), 번호등을 저장할 변수
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage")); 
		
		// 검색조건 전체, 아이디, 이메일
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where = "";
		String args = "", schargs = "";
		if(schtype == null || keyword == null) {
			schtype = ""; keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			if (schtype.equals("all")) { //검색조건이 '아이디 + 이메일'일 경우
				where += "where (mi_id like '%" + keyword + "%' or mi_email like '%" + keyword + "%') ";
			} else {
				where += "where mi_" + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs;
		
		rcnt = memberSvc.getmemberListCount(where); //천제 게시글개수
		// 검색된 게시글의 총 개수로 게시글 일련번호 출력과 전체 페이지수 계산을 위한 값
		List<MemberInfo> memberList = memberSvc.getmemberList(where, cpage, psize); // jdbc 템플릿이 제공해주는게 List이기 때문에 List사용 
		
		pcnt = rcnt / psize; if(rcnt % psize >0) pcnt++;
		spage = (cpage - 1) / bsize * bsize + 1;
		num = rcnt- (psize * (cpage - 1));
		
		PageInfo pi = new PageInfo();
		pi.setBsize(bsize);
		pi.setCpage(cpage);
		pi.setPcnt(pcnt);
		pi.setPsize(psize);
		pi.setRcnt(rcnt);
		pi.setSpage(spage);
		pi.setNum(num);
		pi.setArgs(args);
		pi.setKeyword(keyword);
		pi.setSchargs(schargs);
		pi.setSchtype(schtype);
		// 페이징에 필요한 정보들과 검색조건을 PageInfo형 인스턴스에 저장
		
		request.setAttribute("memberList", memberList);
		request.setAttribute("pi", pi);
		
		return "member/member_list";
	}
}