package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import org.springframework.beans.factory.annotation.*;
import dao.*;
import svc.*;

@Configuration
public class DbConfig {
	@Bean(destroyMethod = "close")
	public static DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost/busjava?characterEncoding=utf8");
		ds.setUsername("root");
		ds.setPassword("1234");
		ds.setInitialSize(2);
		ds.setMaxActive(10);
		ds.setTestWhileIdle(true);
		ds.setMinEvictableIdleTimeMillis(60000 * 3);
		ds.setMinEvictableIdleTimeMillis(10 * 1000);
		return ds;
	}
	
	@Bean
	public TerminalDao terminalDao() {
		return new TerminalDao(dataSource());
	}
	
	@Bean
	public TerminalSvc terminalSvc() {
		TerminalSvc terminalSvc = new TerminalSvc();
		terminalSvc.setTerminalDao(terminalDao());
		return terminalSvc;
	}
	
	@Bean
	public LoginDao loginDao() {
		return new LoginDao(dataSource());
	}

	@Bean
	public LoginSvc loginSvc() {
		LoginSvc loginSvc = new LoginSvc();
		loginSvc.setLoginDao(loginDao());
		return loginSvc;
	}
}
