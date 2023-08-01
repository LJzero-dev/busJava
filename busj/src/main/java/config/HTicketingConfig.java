package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;
import vo.*;
import static config.DbConfig.*;

public class HTicketingConfig {
	
	@Bean
	public HTicketingDao hTicketingDao() {
		return new HTicketingDao(dataSource());
	}
	
	@Bean
	public HTicketingSvc hTicketingSvc() {
		HTicketingSvc hTicketingSvc = new HTicketingSvc();
		hTicketingSvc.sethTicketingDao(hTicketingDao());
		return hTicketingSvc;
	}
}
