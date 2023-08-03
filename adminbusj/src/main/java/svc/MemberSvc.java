package svc;

import java.util.List;

import dao.*;
import vo.*;

public class MemberSvc {
	private MemberDao memberDao;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public List<MemberInfo> getmemberList() {
		List<MemberInfo> memberList = memberDao.getmemberList();
		return memberList;
	}
	
}
