package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;
import vo.*;
import static config.DbConfig.*;

public class STicketingConfig {
	
	@Bean
	public STicketingDao sTicketingDao() {
		return new STicketingDao(dataSource());
	}
	
	@Bean
	public STicketingSvc sTicketingSvc() {
		STicketingSvc sTicketingSvc = new STicketingSvc();
		sTicketingSvc.setSTicketingDao(sTicketingDao());
		return sTicketingSvc;
	}
}
