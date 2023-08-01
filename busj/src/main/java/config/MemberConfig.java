package config;

import java.util.Properties;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import ctrl.*;
import dao.*;
import svc.*;
import vo.*;
import static config.DbConfig.*;

public class MemberConfig {	
	@Bean
	public MemberDao memberDao() {
		return new MemberDao(dataSource());
	}
	
	@Bean
	public MemberSvc memberSvc() {
		MemberSvc memberSvc = new MemberSvc();
		memberSvc.setMemberDao(memberDao());
		return memberSvc;
	}
	
	@Bean
    public JavaMailSenderImpl mailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        
        mailSender.setHost("smtp.naver.com");
        mailSender.setPort(465);
        mailSender.setUsername("jeenworks@naver.com");
        mailSender.setPassword("skrowneej!");

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");
        props.put("mail.smtp.socketFactory.port", "465");

        return mailSender;
    }
}

