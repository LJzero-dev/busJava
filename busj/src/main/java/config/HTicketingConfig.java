package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;
import vo.*;

public class HTicketingConfig {
//	@Bean(destroyMethod = "close")
//	public DataSource dataSource() {
//		DataSource ds = new DataSource();
//		ds.setDriverClassName("com.mysql.jdbc.Driver");
//		ds.setUrl("jdbc:mysql://localhost/busjava?characterEncoding=utf-8");
//		ds.setUsername("root");
//		ds.setPassword("1234");
//		ds.setInitialSize(2);
//		ds.setMaxActive(10);
//		ds.setTestWhileIdle(true);
//		ds.setMinEvictableIdleTimeMillis(60000 * 3);
//		ds.setTimeBetweenEvictionRunsMillis(10 * 1000);
//		return ds;
//	}
//	
//	@Bean
//	public HTicketingDao hTicketingDao() {
//		return new HTicketingDao(dataSource());
//	}
//	
//	@Bean
//	public HTicketingSvc hTicketingSvc() {
//		HTicketingSvc hTicketingSvc = new HTicketingSvc();
//		hTicketingSvc.sethTicketingDao(hTicketingDao());
//		return hTicketingSvc;
//	}
}
