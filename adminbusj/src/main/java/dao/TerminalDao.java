package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class TerminalDao {
	private JdbcTemplate jdbc;

	public TerminalDao(DataSource dataSource) {
		 this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public List<TerminalInfo> getTerminalList() {
		String sql = "select * from t_bus_terminal where bt_type != 'c'";
		List<TerminalInfo> terminalList = jdbc.query(sql, 
				(ResultSet rs, int rowNum) -> {
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

	public int chkTerminal(String name) {
		String sql = "select count(*) from t_bus_terminal where bt_name = '" + name + "' ";
		int result = jdbc.queryForObject(sql, Integer.class);
		return result;
	}
}
