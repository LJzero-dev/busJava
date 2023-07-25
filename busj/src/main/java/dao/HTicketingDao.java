package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;

import org.apache.tomcat.jdbc.pool.DataSource.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;

import config.*;
import vo.*;

public class HTicketingDao {
	private JdbcTemplate jdbc;

	public HTicketingDao(DataSource dataSource) {
		 this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<TerminalInfo> getTerminalList() {
		String sql = "select bt_idx, bt_name, bt_area, bt_type, bt_status from t_bus_terminal where bt_type <> 'c' and bt_status ='y' order by bt_name";
		List<TerminalInfo> terminalList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			TerminalInfo ti = new TerminalInfo(rs.getInt("bt_idx"), rs.getString("bt_name"), rs.getString("bt_area"), rs.getString("bt_type"), rs.getString("bt_status"));
			return ti;
		});
		
		return terminalList;
	}

}

