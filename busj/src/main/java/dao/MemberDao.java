package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import config.*;
import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class MemberDao {
	private JdbcTemplate jdbc;

	public MemberDao(DataSource dataSource) {
		 this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public MemberInfo getLoginInfo(String mi_id, String mi_pw) {
		String sql = "select * from t_member_info where mi_id = ? and mi_pw = ? and mi_status != '탈퇴' ";

		List<MemberInfo> results = jdbc.query(sql, new RowMapper<MemberInfo>() {
			public MemberInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberInfo mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
	            mi.setMi_pw(rs.getString("mi_pw"));
	            mi.setMi_name(rs.getString("mi_name"));
	            mi.setMi_gender(rs.getString("mi_gender"));
	            mi.setMi_phone(rs.getString("mi_phone"));
	            mi.setMi_email(rs.getString("mi_email"));
	            mi.setMi_status(rs.getString("mi_status"));
	            mi.setMi_date(rs.getString("mi_date"));
	            mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
	            mi.setMi_pmoney(rs.getInt("mi_pmoney"));
	            mi.setMi_stamp(rs.getInt("mi_stamp"));
	            mi.setMi_coupon(rs.getInt("mi_coupon"));
	            return mi;
			}
		}, mi_id, mi_pw);
		// 쿼리에 직접 값을 넣으면 매개변수로 값을 추가할 필요 없음
		
		return results.isEmpty() ? null : results.get(0);
	}

	public int memberInsert(MemberInfo mi) {
		String sql = "insert into t_member_info values ('" + mi.getMi_id() + "', '" + mi.getMi_pw() + 
				"', '" + mi.getMi_name() + "', '" + mi.getMi_gender() + "', '" + mi.getMi_phone() + 
				"', '" + mi.getMi_email() + "', 0, 0, 0, '정상', now(), null) ";
		int result = jdbc.update(sql);
		
		System.out.println(sql);
		
		return result;
	}

	public int chkDupId(String mi_id) {
		String sql = "select count(*) from t_member_info where mi_id = '" + mi_id + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
	
	public int chkDupMail(String mi_email) {
		String sql = "select count(*) from t_member_info where mi_email = '" + mi_email + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
	
	public int chkDupPhone(String mi_phone) {
		String sql = "select count(*) from t_member_info where mi_phone = '" + mi_phone + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	} 

	public int chkDupIdMail(String mi_id, String mi_email) {
		String sql = "select count(*) from t_member_info where mi_id = '" + mi_id + "' and mi_email= '" + mi_email + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public String passDupMail(String email) {
		String sql = "select mi_id from t_member_info where mi_email = '" + email + "'";
		String mi_id = jdbc.queryForObject(sql, String.class);
		return mi_id;
	}

	public int passDupIdMail(String mi_id, String email, String newPw) {
		String sql = "update t_member_info set mi_pw = '" + newPw + "' where mi_id = '" + mi_id + "' and mi_email = '" + email + "' ";
		int resultUp = jdbc.update(sql);
		return resultUp;
	}

	public int memberPwChk(String mi_id, String mi_pw) {
		String sql = "select count(*) from t_member_info where mi_id = '" + mi_id + "' and mi_pw= '" + mi_pw + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}

	public int memberUpPw(String mi_id, String mi_pw) {
		String sql = "update t_member_info set mi_pw = '" + mi_pw + "' where mi_id = '" + mi_id + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public int memberUpMail(String mi_id, String mi_email) {
		String sql = "update t_member_info set mi_email = '" + mi_email + "' where mi_id = '" + mi_id + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public int memberUpPhone(String mi_id, String mi_phone) {
		String sql = "update t_member_info set mi_phone = '" + mi_phone + "' where mi_id = '" + mi_id + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public int memberDel(String mi_id) {
		String sql = "update t_member_info set mi_status = '탈퇴' where mi_id = '" + mi_id + "' ";
		int result = jdbc.update(sql);
		return result;
	}

}

