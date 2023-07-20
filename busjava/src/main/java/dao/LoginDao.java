/*
 * package dao;
 * 
 * import java.util.*; import java.sql.*; import javax.sql.*; import
 * org.springframework.jdbc.core.*; import org.springframework.jdbc.support.*;
 * import vo.*;
 * 
 * public class LoginDao { private JdbcTemplate jdbcTemplate;
 * 
 * public LoginDao(DataSource dataSource) { this.jdbcTemplate = new
 * JdbcTemplate(dataSource); }
 * 
 * public MemberInfo getLoginInfo(String mi_id, String mi_pw) { String sql =
 * "select * from t_member_info where mi_id = ? and mi_pw = ?";
 * 
 * System.out.println("here"); List<MemberInfo> results =
 * jdbcTemplate.query(sql, new RowMapper<MemberInfo>() { public MemberInfo
 * mapRow(ResultSet rs, int rowNum) throws SQLException { MemberInfo mi = new
 * MemberInfo(); mi.setMi_id(rs.getString("mi_id"));
 * mi.setMi_pw(rs.getString("mi_pw")); mi.setMi_name(rs.getString("mi_name"));
 * mi.setMi_gender(rs.getString("mi_gender"));
 * mi.setMi_phone(rs.getString("mi_phone"));
 * mi.setMi_email(rs.getString("mi_email"));
 * mi.setMi_status(rs.getString("mi_status"));
 * mi.setMi_date(rs.getString("mi_date"));
 * mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
 * mi.setMi_pmoney(rs.getInt("mi_pmoney"));
 * mi.setMi_stamp(rs.getInt("mi_stamp"));
 * mi.setMi_coupon(rs.getInt("mi_coupon")); return mi; } }, mi_id, mi_pw); //
 * 쿼리에 직접 값을 넣으면 매개변수로 값을 추가할 필요 없음
 * 
 * return results.isEmpty() ? null : results.get(0); } }
 */