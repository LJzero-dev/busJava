package svc;

import dao.*;
import vo.*;

public class MemberSvc {
	private MemberDao memberDao;
	
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	public MemberInfo getLoginInfo(String mi_id, String mi_pw) {
		MemberInfo mi = memberDao.getLoginInfo(mi_id, mi_pw);
		return mi;
	}
	
	public int memberInsert(MemberInfo mi) {
		int result = memberDao.memberInsert(mi);
		return result;
	}

	public int chkDupId(String uid) {
		int result = memberDao.chkDupId(uid);
		
		return result;
	}
}
