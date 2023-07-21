package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import ctrl.*;
import svc.*;

@Configuration
public class CtrlConfig {
	@Autowired
	private MemberSvc memberSvc;
	
//	@Autowired
//	private HTicketingSvc hTicketingSvc;
	
	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
	
	@Bean
	public PayChargeCtrl payChargeCtrl() {
		return new PayChargeCtrl();
	}
	
	@Bean
	public MemberCtrl loginCtrl() {
		MemberCtrl memberCtrl = new MemberCtrl();
		memberCtrl.setMemberSvc(memberSvc);
		return memberCtrl;
	}
	
	@Bean
	public HTicketingCtrl hTicketingCtrl() {
//		HTicketingCtrl hTicketingCtrl = new HTicketingCtrl();
//		hTicketingCtrl.sethTicketingSvc(hTicketingSvc);
//		return hTicketingCtrl;
		return new HTicketingCtrl();
	}

}
