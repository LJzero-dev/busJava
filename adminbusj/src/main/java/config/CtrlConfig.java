package config;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import svc.*;

@Configuration
public class CtrlConfig {
	@Autowired
	private TerminalSvc terminalSvc;
	
	@Autowired
	private LoginSvc loginSvc;
	
	@Autowired
	private MemberSvc memberSvc;
	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
	
	@Bean
	public PayChargeCtrl payChargeCtrl() {
		return new PayChargeCtrl();
	}
	
	@Bean
	public LoginCtrl loginCtrl() {
		LoginCtrl loginCtrl = new LoginCtrl();
		loginCtrl.setLoginSvc(loginSvc);
		return loginCtrl;
	}
	
	@Bean
	public TerminalCtrl terminalCtrl() {
		TerminalCtrl terminalCtrl = new TerminalCtrl();
		terminalCtrl.setTerminalSvc(terminalSvc);
		return terminalCtrl;
	}
	
	@Bean
	public TravelCtrl travelCtrl() {
		return new TravelCtrl();
	}
	
	@Bean
	public MemberCtrl memberCtrl() {
		MemberCtrl memberCtrl = new MemberCtrl();
		memberCtrl.setMemberSvc(memberSvc);
		return memberCtrl;
	}
}

