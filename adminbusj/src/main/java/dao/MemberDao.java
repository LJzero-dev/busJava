package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;

import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;

import config.*;
import vo.*;

public class MemberDao {
	private JdbcTemplate jdbc;

	public MemberDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<MemberInfo> getmemberList() {
		String sql = "";
		List<MemberInfo> memberList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			MemberInfo mi = new MemberInfo();
			mi.setMi_id(rs.getString("mi_id"));
			mi.setMi_pw(rs.getString("mi_pw"));
			mi.setMi_name(rs.getString("mi_name"));
			mi.setMi_gender(rs.getString("mi_gender"));
			mi.setMi_phone(rs.getString("mi_phone"));
			mi.setMi_email(rs.getString("mi_email"));
			mi.setMi_pmoney(rs.getInt("mi_pmoney"));
			mi.setMi_stamp(rs.getInt("mi_stamp"));
			mi.setMi_coupon(rs.getInt("mi_coupon"));
			mi.setMi_status(rs.getString("mi_status"));
			mi.setMi_date(rs.getString("mi_date"));
			mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
			
			return mi;
		});
		return memberList;
	}

}
