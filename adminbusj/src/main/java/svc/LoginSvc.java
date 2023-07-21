package svc;

import dao.*;
import vo.*;

public class LoginSvc {
	private LoginDao loginDaoSpr;

	public void setLoginDaoSpr(LoginDao loginDaoSpr) {
		this.loginDaoSpr = loginDaoSpr;
	}

	public MemberInfo getLoginInfo(String uid, String pwd) {
		MemberInfo mi = loginDaoSpr.getLoginInfo(uid, pwd);
		return mi;
	}
}
