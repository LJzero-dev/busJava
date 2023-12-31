package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import ctrl.*;
import svc.*;

@Configuration
public class CtrlConfig {
	@Autowired
	private MemberSvc memberSvc;
	
	@Autowired
	private HTicketingSvc hTicketingSvc;
	
	@Autowired
	private STicketingSvc sTicketingSvc;
	
	@Autowired
	private ScheduleSvc scheduleSvc;
	
	@Autowired
	private TravelSvc travelSvc;
	
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
		HTicketingCtrl hTicketingCtrl = new HTicketingCtrl();
		hTicketingCtrl.sethTicketingSvc(hTicketingSvc);
		return hTicketingCtrl;
	}
	
	@Bean
	public STicketingCtrl sTicketingCtrl() {
		STicketingCtrl sTicketingCtrl = new STicketingCtrl();
		sTicketingCtrl.setSTicketingSvc(sTicketingSvc);
		return sTicketingCtrl;
	}
	
	@Bean
	public ScheduleCtrl scheduleCtrl() {
		ScheduleCtrl scheduleCtrl = new ScheduleCtrl();
		scheduleCtrl.setScheduleSvc(scheduleSvc);
		return scheduleCtrl;
	}
	
	@Bean
	public TravelCtrl travelCtrl() {
		TravelCtrl travelCtrl = new TravelCtrl();
		travelCtrl.setTravelSvc(travelSvc);
		travelCtrl.sethTicketingSvc(hTicketingSvc);
		return travelCtrl;
	}

}
