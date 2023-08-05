package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;
import vo.*;
import static config.DbConfig.*;

public class TravelConfig {
	@Bean
	public TravelDao travelDao() {
		return new TravelDao(dataSource());
	}
	
	@Bean
	public TravelSvc travelSvc() {
		TravelSvc travelSvc = new TravelSvc();
		travelSvc.setTravelDao(travelDao());
		return travelSvc;
	}
}
