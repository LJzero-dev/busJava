package svc;

import dao.*;
import vo.*;

public class LoginSvc {
	private LoginDao loginDao;

	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}

	public MemberInfo getLoginInfo(String mi_id, String mi_pw) {
		MemberInfo mi = loginDao.getLoginInfo(mi_id, mi_pw);
		return mi;
	}
}
