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
	public LoginCtrl loginCtrl() {
		return new LoginCtrl();
	}
	
	@Bean
	public TerminalCtrl terminalCtrl() {
		TerminalCtrl terminalCtrl = new TerminalCtrl();
		terminalCtrl.setTerminalSvc(terminalSvc);
		return terminalCtrl;
	}
	
	@Bean
	public TravelCtrl travelCtrl() {
		TravelCtrl travelCtrl = new TravelCtrl();
		travelCtrl.setTravelSvc(travelSvc);
		return travelCtrl;
	}
}
