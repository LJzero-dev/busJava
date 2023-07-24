package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import config.*;
import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class STicketingDao {
	private JdbcTemplate jdbc;

	public STicketingDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<TerminalInfo> pickSpotSlow() {
		String sql = "select * from t_bus_terminal where bt_type != 'b' and bt_status = 'y'";

		List<TerminalInfo> terminalList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			TerminalInfo ti = new TerminalInfo();
			ti.setBt_idx(rs.getInt("bt_idx"));
			ti.setBt_name(rs.getString("bt_name"));
			ti.setBt_area(rs.getString("bt_area"));
			ti.setBt_type(rs.getString("bt_type"));
			ti.setBt_status(rs.getString("bt_status"));
			return ti;
		});
		return terminalList;
	}

}
