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
	
	public int chkDupMail(String email) {
		int result = memberDao.chkDupMail(email);
		
		return result;
	}
	
	public int chkDupPhone(String phone) {
		int result = memberDao.chkDupPhone(phone);
		
		return result;
	}
	
	public int chkDupIdMail(String mi_id, String email) {
		int result = memberDao.chkDupIdMail(mi_id, email);
		
		return result;
	}

	public String passDupMail(String email) {
		String mi_id = memberDao.passDupMail(email);
		return mi_id;
	}

	public int passDupIdMail(String mi_id, String email, String newPw) {
		int resultUp = memberDao.passDupIdMail(mi_id, email, newPw);
		return resultUp;
	}

	public int memberPwChk(String mi_id, String mi_pw) {
		int result = memberDao.memberPwChk(mi_id, mi_pw);
		return result;
	}

}
